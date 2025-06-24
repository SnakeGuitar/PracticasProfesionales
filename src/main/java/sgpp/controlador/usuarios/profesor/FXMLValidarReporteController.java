/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 16-06-2025
 * Fecha de la última modificación: 24-06-2025
 * Descripción: Controlador JavaFX para la vista de validación de reportes mensuales.
 *              Permite visualizar las entregas realizadas por los estudiantes, descargar
 *              los documentos PDF asociados, y validar o rechazar los reportes incluyendo
 *              observaciones opcionales.
 *
 * Funcionalidades:
 *   - Mostrar reportes entregados por los estudiantes en el periodo actual
 *   - Descargar el PDF de cada entrega mediante doble clic
 *   - Validar o rechazar entregas con opción a comentario
 *   - Mostrar nombre del estudiante y horas reportadas
 *   - Filtros adecuados para un buen funcionamiento
 *   - Validaciones para la validacion o el rechazo
 * Estado: En funcionamiento
 */
package sgpp.controlador.usuarios.profesor;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.input.MouseButton;
import javafx.stage.FileChooser;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.expediente.EstadoExpediente;
import sgpp.modelo.beans.expediente.Expediente;
import sgpp.modelo.beans.expediente.reporte.EntregaReporteMensual;
import sgpp.modelo.beans.expediente.reporte.ReporteMensual;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.expediente.ExpedienteDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaReporteMensualDAO;
import sgpp.modelo.dao.expediente.documentoparcial.ReporteMensualDAO;
import sgpp.utilidad.Utilidad;

import java.io.FileOutputStream;
import java.net.URL;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class FXMLValidarReporteController implements Initializable {

    @FXML private Label lbTitulo;
    @FXML private TableView<EntregaReporteMensual> tablaEntregas;
    @FXML private TableColumn<EntregaReporteMensual, String>  colEstudiante;
    @FXML private TableColumn<EntregaReporteMensual, Integer> colReporte;
    @FXML private TableColumn<EntregaReporteMensual, String>  colFechaEntrega;
    @FXML private TableColumn<EntregaReporteMensual, String>  colEstado;
    @FXML private TableColumn<EntregaReporteMensual, Integer> colHoras;
    @FXML private Button btnValidar, btnRechazar;

    @FXML private ComboBox<String> cbFiltroReporte;
    @FXML private ComboBox<String> cbFiltroEstado;
    @FXML private TextField tfFiltroNombre;

    private static final DateTimeFormatter DF = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    private final ObservableList<EntregaReporteMensual> DATOS = FXCollections.observableArrayList();
    private final ObservableList<EntregaReporteMensual> DATOS_FILTRADOS = FXCollections.observableArrayList();

    private final Map<Integer, String> MAPA_ESTUDIANTES = new HashMap<>();
    private final Map<Integer, Integer> MAPA_HORAS = new HashMap<>();

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarMapaEstudiantes();
        cargarHorasReportadas();
        configurarColumnas();
        configurarFiltros();
        cargarDatos();
        colocarTitulo();

        tablaEntregas.setRowFactory(tv -> {
            TableRow<EntregaReporteMensual> row = new TableRow<>();
            row.setOnMouseClicked(ev -> {
                if (ev.getButton() == MouseButton.PRIMARY && ev.getClickCount() == 2 && !row.isEmpty()) {
                    descargarPDF(row.getItem());
                }
            });
            return row;
        });
    }

    private void configurarFiltros() {
        cbFiltroReporte.setItems(FXCollections.observableArrayList("Todos", "1", "2", "3", "4"));
        cbFiltroReporte.getSelectionModel().select("Todos");

        cbFiltroEstado.setItems(FXCollections.observableArrayList( "Entregado", "Pendiente", "Aceptado", "Rechazado", "Todos"));
        cbFiltroEstado.getSelectionModel().select("Entregado");

        cbFiltroReporte.setOnAction(e -> aplicarFiltros());
        cbFiltroEstado.setOnAction(e -> aplicarFiltros());
        tfFiltroNombre.textProperty().addListener((obs, old, val) -> aplicarFiltros());
    }

    private void cargarMapaEstudiantes() {
        try {
            int idPeriodo = PeriodoDAO.obtenerPeriodoActual().getIdPeriodo();
            for (Estudiante e : EstudianteDAO.obtenerEstudiantesPorPeriodo(idPeriodo)) {
                MAPA_ESTUDIANTES.put(e.getIdEstudiante(), e.getNombre());
            }
        } catch (SQLException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    private void cargarHorasReportadas() {
        try {
            for (ReporteMensual r : ReporteMensualDAO.obtenerTodos()) {
                MAPA_HORAS.put(r.getIdEntregaReporte(), r.getHorasReportadas());
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    private void configurarColumnas() {
        colReporte.setCellValueFactory(c -> new javafx.beans.property.ReadOnlyObjectWrapper<>(c.getValue().getNumReporte()));

        colEstudiante.setCellValueFactory(c ->
                new javafx.beans.property.SimpleStringProperty(
                        MAPA_ESTUDIANTES.getOrDefault(c.getValue().getIdEstudiante(), "Desconocido")
                )
        );

        colFechaEntrega.setCellValueFactory(c -> {
            var f = c.getValue().getFechaEntrega();
            return new javafx.beans.property.SimpleStringProperty(f == null ? "—" : DF.format(f));
        });

        colEstado.setCellValueFactory(c ->
                new javafx.beans.property.SimpleStringProperty(estadoActual(c.getValue()))
        );

        colHoras.setCellValueFactory(c ->
                new javafx.beans.property.ReadOnlyObjectWrapper<>(MAPA_HORAS.getOrDefault(c.getValue().getIdEntregaReporte(), 0))
        );
    }

    private void cargarDatos() {
        DATOS.clear();
        try {
            int idPeriodo = PeriodoDAO.obtenerPeriodoActual().getIdPeriodo();
            DATOS.addAll(EntregaReporteMensualDAO.obtenerPorPeriodo(idPeriodo));
            aplicarFiltros();
        } catch (SQLException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    private void aplicarFiltros() {
        String nombreFiltro = tfFiltroNombre.getText().toLowerCase().trim();
        String estadoFiltro = cbFiltroEstado.getValue();
        String reporteFiltro = cbFiltroReporte.getValue();

        DATOS_FILTRADOS.setAll(DATOS.filtered(entrega -> {
            String nombre = MAPA_ESTUDIANTES.getOrDefault(entrega.getIdEstudiante(), "").toLowerCase();
            boolean coincideNombre = nombre.contains(nombreFiltro);
            boolean coincideEstado = estadoFiltro.equals("Todos") || estadoActual(entrega).equalsIgnoreCase(estadoFiltro);
            boolean coincideReporte = reporteFiltro.equals("Todos") ||
                    String.valueOf(entrega.getNumReporte()).equals(reporteFiltro);
            return coincideNombre && coincideEstado && coincideReporte;
        }));

        tablaEntregas.setItems(DATOS_FILTRADOS);
    }

    @FXML
    private void validarEntrega(ActionEvent e) {
        cambiarEstado("Aceptado");
    }

    @FXML
    private void rechazarEntrega(ActionEvent e) {
        cambiarEstado("Rechazado");
    }

    private void cambiarEstado(String nuevoEstado) {
        EntregaReporteMensual sel = tablaEntregas.getSelectionModel().getSelectedItem();
        if (sel == null) {
            Utilidad.crearAlertaAdvertencia("Sin selección", "Selecciona una entrega primero.");
            return;
        }


        if (!esReporteEntregable(sel) || !esCambioDeEstadoValido(sel, nuevoEstado)) {
            return;
        }

        TextInputDialog dlg = new TextInputDialog();
        dlg.setTitle(nuevoEstado);
        dlg.setHeaderText("Observaciones (opcional)");
        dlg.setContentText("Escribe un comentario:");
        Optional<String> obsOpt = dlg.showAndWait();
        if (obsOpt.isEmpty()) return;

        if (!Utilidad.crearAlertaConfirmacion("Confirmar " + nuevoEstado, "¿Seguro que deseas marcar la entrega como " + nuevoEstado + "?")) {
            return;
        }

        try {
            boolean ok = ReporteMensualDAO.actualizarEstado(sel.getIdEntregaReporte(), nuevoEstado, obsOpt.get());
            if (ok && nuevoEstado.equals("Aceptado")) {
                Expediente expediente = new Expediente();
                expediente.setEstado(EstadoExpediente.Activo);
                expediente.setHorasAcumuladas(MAPA_HORAS.getOrDefault(sel.getIdEntregaReporte(), 0));
                expediente.setIdEstudiante(sel.getIdEstudiante());
                expediente.setIdPeriodo(sel.getIdPeriodo());
                if (!ExpedienteDAO.actualizar(expediente)) {
                    Utilidad.crearAlertaAdvertencia("Error", "No fue posible actualizar las horas del expediente.");
                }
            }
            if (ok) {
                Utilidad.crearAlertaInformacion("Guardado", "Se actualizó el estado a " + nuevoEstado + ".");
                cargarHorasReportadas();
                cargarDatos();
            } else {
                Utilidad.crearAlertaAdvertencia("Sin cambios", "No se pudo actualizar la base de datos.");
            }
        } catch (SQLException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    private boolean esReporteEntregable(EntregaReporteMensual entrega) {
        if (entrega.getFechaEntrega() == null) {
            Utilidad.crearAlertaAdvertencia("No entregado", "Este reporte aún no ha sido entregado. No puede validarse ni rechazarse.");
            return false;
        }
        return true;
    }

    private boolean esCambioDeEstadoValido(EntregaReporteMensual entrega, String nuevoEstado) {
        String estado = estadoActual(entrega);

        if (estado.equalsIgnoreCase(nuevoEstado)) {
            Utilidad.crearAlertaAdvertencia("Sin cambios", "El reporte ya está marcado como " + nuevoEstado + ".");
            return false;
        }

        if (estado.equalsIgnoreCase("Aceptado") && nuevoEstado.equals("Rechazado")) {
            Utilidad.crearAlertaAdvertencia("No permitido", "Este reporte ya fue validado. No puede ser rechazado.");
            return false;
        }

        if (estado.equalsIgnoreCase("Rechazado") && nuevoEstado.equals("Aceptado")) {
            Utilidad.crearAlertaAdvertencia("No permitido", "Este reporte ya fue rechazado. No puede ser validado.");
            return false;
        }

        return true;
    }

    private String estadoActual(EntregaReporteMensual er) {
        try {
            ReporteMensual reporte = ReporteMensualDAO.obtenerReportePorExpediente(er.getIdEntregaReporte());
            return (reporte != null) ? reporte.getEstado().toString() : "Pendiente";
        } catch (SQLException e) {
            return "Pendiente";
        }
    }

    private void descargarPDF(EntregaReporteMensual er) {
        try {
            ReporteMensual reporte = ReporteMensualDAO.obtenerReportePorExpediente(er.getIdEntregaReporte());
            if (reporte == null) {
                Utilidad.crearAlertaAdvertencia("Sin archivo", "Esta entrega aún no ha subido un PDF.");
                return;
            }
            FileChooser fc = new FileChooser();
            fc.setTitle("Guardar PDF");
            fc.setInitialFileName("Reporte_" + er.getNumReporte() + ".pdf");
            fc.getExtensionFilters().add(new FileChooser.ExtensionFilter("PDF", "*.pdf"));
            java.io.File destino = fc.showSaveDialog(tablaEntregas.getScene().getWindow());
            if (destino == null) return;

            try (FileOutputStream fos = new FileOutputStream(destino)) {
                fos.write(reporte.getDocumento());
            }
            Utilidad.crearAlertaInformacion("Descargado", "PDF guardado correctamente.");
        } catch (Exception ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    private void colocarTitulo() {
        try {
            lbTitulo.setText(PeriodoDAO.obtenerPeriodoActual().getAbreviatura());
        } catch (SQLException e) {
            Utilidad.crearAlertaAdvertencia("Error", "No se pudo obtener el periodo actual");
        }
    }

    @FXML
    private void volverAtras(ActionEvent event) {
        Utilidad.cerrarVentana(btnValidar);
    }
}
