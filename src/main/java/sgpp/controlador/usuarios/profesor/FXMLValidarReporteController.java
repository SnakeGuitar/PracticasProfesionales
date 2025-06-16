/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 16-06-2025
 * Fecha de la última modificación: 17-06-2025
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
 * Estado: En funcionamiento
 */


package sgpp.controlador.usuarios.profesor;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseButton;
import javafx.stage.FileChooser;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaReporteMensual;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaReporteMensualDAO;
import sgpp.modelo.dao.expediente.documentoparcial.ReporteMensualDAO;
import sgpp.utilidad.Utilidad;

import java.io.FileOutputStream;
import java.net.URL;
import java.sql.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import javafx.stage.Stage;

public class FXMLValidarReporteController implements Initializable {

    @FXML private TableView<EntregaReporteMensual> tablaEntregas;
    @FXML private TableColumn<EntregaReporteMensual, Integer> colID;
    @FXML private TableColumn<EntregaReporteMensual, String>  colEstudiante;
    @FXML private TableColumn<EntregaReporteMensual, Integer> colReporte;
    @FXML private TableColumn<EntregaReporteMensual, String>  colFechaEntrega;
    @FXML private TableColumn<EntregaReporteMensual, String>  colEstado;
    @FXML private TableColumn<EntregaReporteMensual, Integer> colHoras;
    @FXML private Button btnValidar, btnRechazar;

    private static final int ID_PERIODO = 4;
    private static final DateTimeFormatter DF = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    private final ObservableList<EntregaReporteMensual> datos = FXCollections.observableArrayList();
    private final Map<Integer, String> mapaEstudiantes = new HashMap<>();
    private final Map<Integer, Integer> mapaHoras = new HashMap<>();

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarMapaEstudiantes();
        cargarHorasReportadas();
        configurarColumnas();
        cargarDatos();

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

    private void cargarMapaEstudiantes() {
        try {
            for (Estudiante e : EstudianteDAO.obtenerEstudiantes()) {
                mapaEstudiantes.put(e.getIdEstudiante(), e.getNombre());
            }
        } catch (SQLException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    private void cargarHorasReportadas() {
        try (Connection con = sgpp.modelo.ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT ID_Entrega_Reporte, horas_reportadas FROM reporte_mensual")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                mapaHoras.put(rs.getInt("ID_Entrega_Reporte"), rs.getInt("horas_reportadas"));
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    private void configurarColumnas() {
        colID.setCellValueFactory(c -> new javafx.beans.property.ReadOnlyObjectWrapper<>(c.getValue().getIdEntregaReporte()));

        colReporte.setCellValueFactory(c -> new javafx.beans.property.ReadOnlyObjectWrapper<>(c.getValue().getNumReporte()));

        colEstudiante.setCellValueFactory(c -> {
            String nombre = mapaEstudiantes.getOrDefault(c.getValue().getIdEstudiante(), "Desconocido");
            return new javafx.beans.property.SimpleStringProperty(nombre);
        });

        colFechaEntrega.setCellValueFactory(c -> {
            var f = c.getValue().getFechaEntrega();
            String txt = (f == null) ? "—" : DF.format(f);
            return new javafx.beans.property.SimpleStringProperty(txt);
        });

        colEstado.setCellValueFactory(c ->
            new javafx.beans.property.SimpleStringProperty(estadoActual(c.getValue()))
        );

        colHoras.setCellValueFactory(c -> {
            int horas = mapaHoras.getOrDefault(c.getValue().getIdEntregaReporte(), 0);
            return new javafx.beans.property.ReadOnlyObjectWrapper<>(horas);
        });
    }

    private void cargarDatos() {
        datos.clear();
        try {
            datos.addAll(EntregaReporteMensualDAO.obtenerPorPeriodo(ID_PERIODO));
            tablaEntregas.setItems(datos);
        } catch (SQLException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    @FXML private void actualizarLista(ActionEvent e) {
        cargarHorasReportadas();
        cargarDatos();
    }

    @FXML private void validarEntrega(ActionEvent e) {
        cambiarEstado("Aceptado");
    }

    @FXML private void rechazarEntrega(ActionEvent e) {
        cambiarEstado("Rechazado");
    }

    private void cambiarEstado(String nuevoEstado) {
        EntregaReporteMensual sel = tablaEntregas.getSelectionModel().getSelectedItem();
        if (sel == null) {
            Utilidad.crearAlertaAdvertencia("Sin selección", "Selecciona una entrega primero.");
            return;
        }

        TextInputDialog dlg = new TextInputDialog();
        dlg.setTitle(nuevoEstado);
        dlg.setHeaderText("Observaciones (opcional)");
        dlg.setContentText("Escribe un comentario:");
        Optional<String> obsOpt = dlg.showAndWait();
        if (obsOpt.isEmpty()) return;

        if (!Utilidad.crearAlertaConfirmacion(
                "Confirmar " + nuevoEstado,
                "¿Seguro que deseas marcar la entrega como " + nuevoEstado + "?")) return;

        try {
            boolean ok = ReporteMensualDAO.actualizarEstado(
                    sel.getIdEntregaReporte(), nuevoEstado, obsOpt.get());
            if (ok) {
                Utilidad.crearAlertaInformacion("Guardado",
                        "Se actualizó el estado a " + nuevoEstado + ".");
                cargarHorasReportadas();
                cargarDatos();
            } else {
                Utilidad.crearAlertaAdvertencia("Sin cambios",
                        "No se pudo actualizar la base de datos.");
            }
        } catch (SQLException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    private String estadoActual(EntregaReporteMensual er) {
        try (Connection c = sgpp.modelo.ConexionBD.abrirConexion()) {
            PreparedStatement ps = c.prepareStatement(
                    "SELECT estado FROM reporte_mensual WHERE ID_Entrega_Reporte = ?");
            ps.setInt(1, er.getIdEntregaReporte());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("estado");
        } catch (SQLException ignored) {}
        return "Pendiente";
    }

    private void descargarPDF(EntregaReporteMensual er) {
        try (Connection c = sgpp.modelo.ConexionBD.abrirConexion()) {
            PreparedStatement ps = c.prepareStatement(
                    "SELECT reporte FROM reporte_mensual WHERE ID_Entrega_Reporte = ?");
            ps.setInt(1, er.getIdEntregaReporte());
            ResultSet rs = ps.executeQuery();
            if (!rs.next() || rs.getBytes("reporte") == null) {
                Utilidad.crearAlertaAdvertencia("Sin archivo", "Esta entrega aún no ha subido un PDF.");
                return;
            }
            byte[] pdf = rs.getBytes("reporte");

            FileChooser fc = new FileChooser();
            fc.setTitle("Guardar PDF");
            fc.setInitialFileName("Reporte_" + er.getNumReporte() + ".pdf");
            fc.getExtensionFilters().add(new FileChooser.ExtensionFilter("PDF", "*.pdf"));
            java.io.File destino = fc.showSaveDialog(tablaEntregas.getScene().getWindow());
            if (destino == null) return;

            try (FileOutputStream fos = new FileOutputStream(destino)) {
                fos.write(pdf);
            }
            Utilidad.crearAlertaInformacion("Descargado", "PDF guardado correctamente.");
        } catch (Exception ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }
    
private void volverAtras(ActionEvent event) {
    ((Stage) tablaEntregas.getScene().getWindow()).close();
}

    @FXML
    private void btnRegresar(ActionEvent event) {
    }


}
