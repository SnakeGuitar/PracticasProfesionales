/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Controlador JavaFX para generar oficios de asignación.
 *              Muestra las asignaciones en una tabla con checkboxes y,
 *              al seleccionar, genera el PDF y lo guarda tanto en disco
 *              como en la tabla oficio_asignacion.  Si el oficio ya existe
 *              para el periodo y estudiante, el documento se actualiza.
 */


package sgpp.controlador.usuarios.coordinador;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.CheckBoxTableCell;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import sgpp.modelo.beans.Periodo;
import sgpp.modelo.beans.expediente.documentoinicial.OficioAsignacion;
import sgpp.modelo.beans.expediente.documentoinicial.TablaAsignacion;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.entidades.TablaAsignacionDAO;
import sgpp.modelo.dao.expediente.documentoinicial.OficioAsignacionDAO;
import sgpp.utilidad.Impresora;
import sgpp.utilidad.Utilidad;

import java.sql.SQLException;

public class FXMLGenerarDocumentosController {

    @FXML private TableView<TablaAsignacion> tablaAsignaciones;
    @FXML private TableColumn<TablaAsignacion, String> colEmpresa;
    @FXML private TableColumn<TablaAsignacion, String> colProyecto;
    @FXML private TableColumn<TablaAsignacion, String> colAlumno;
    @FXML private TableColumn<TablaAsignacion, String> colMatricula;
    @FXML private TableColumn<TablaAsignacion, Boolean> colSeleccion;
    @FXML private Button btnGenerar;
    @FXML private Button btnSeleccionarTodos;

    private final ObservableList<TablaAsignacion> listaAsignaciones = FXCollections.observableArrayList();

    @FXML
    public void initialize() {
        configurarTabla();
        cargarDatos();
        configurarDobleClick();
    }

    private void configurarTabla() {
        tablaAsignaciones.setEditable(true);
        colSeleccion.setEditable(true);

        colEmpresa.setCellValueFactory(c -> c.getValue().nombreOrganizacionProperty());
        colProyecto.setCellValueFactory(c -> c.getValue().nombreProyectoProperty());
        colAlumno.setCellValueFactory(c -> c.getValue().nombreEstudianteProperty());
        colMatricula.setCellValueFactory(c -> c.getValue().matriculaProperty());
        colSeleccion.setCellValueFactory(c -> c.getValue().seleccionadoProperty());

        colSeleccion.setCellFactory(CheckBoxTableCell.forTableColumn(colSeleccion));
    }

    private void configurarDobleClick() {
        tablaAsignaciones.setRowFactory(tv -> {
            TableRow<TablaAsignacion> row = new TableRow<>();
            row.setOnMouseClicked(event -> {
                if (event.getClickCount() == 2 && !row.isEmpty()) {
                    TablaAsignacion asignacion = row.getItem();
                    descargarConFileChooser(asignacion);
                }
            });
            return row;
        });
    }

    private void descargarConFileChooser(TablaAsignacion asignacion) {
        try {
            Periodo periodoActual = PeriodoDAO.obtenerPeriodoActual();
            if (periodoActual == null) {
                Utilidad.crearAlerta(Alert.AlertType.WARNING,
                        "Periodo no encontrado",
                        "No hay un periodo activo para la fecha actual.");
                return;
            }

            OficioAsignacion oficio = OficioAsignacionDAO.obtenerPorEstudianteYPeriodo(
                    asignacion.getIdEstudiante(), periodoActual.getIdPeriodo());

            if (oficio == null || oficio.getDocumento() == null) {
                Utilidad.crearAlerta(Alert.AlertType.INFORMATION,
                        "Oficio no disponible",
                        "No hay oficio generado para este estudiante.");
                return;
            }

            FileChooser fileChooser = new FileChooser();
            fileChooser.setTitle("Guardar oficio de asignación");

            String nombreSugerido = String.format("Asignacion_%s_%s.pdf",
                    asignacion.getNombreEstudiante().replace(" ", "_"),
                    asignacion.getMatricula());

            fileChooser.setInitialFileName(nombreSugerido);
            fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("Documento PDF", "*.pdf"));

            Stage stage = (Stage) tablaAsignaciones.getScene().getWindow();
            File destino = fileChooser.showSaveDialog(stage);

            if (destino != null) {
                try (FileOutputStream out = new FileOutputStream(destino)) {
                    out.write(oficio.getDocumento());
                }

                Utilidad.crearAlerta(Alert.AlertType.INFORMATION,
                        "Descarga completada",
                        "El oficio fue guardado correctamente en:\n" + destino.getAbsolutePath());
            }

        } catch (Exception e) {
            Utilidad.mostrarError(true, e,
                    "Error al descargar oficio",
                    "No se pudo guardar el documento.");
        }
    }

    private void cargarDatos() {
        try {
            listaAsignaciones.setAll(TablaAsignacionDAO.obtenerAsignaciones());
            tablaAsignaciones.setItems(listaAsignaciones);
        } catch (SQLException e) {
            Utilidad.crearAlerta(Alert.AlertType.ERROR,
                    "Error al cargar asignaciones",
                    "No se pudieron obtener las asignaciones desde la base de datos.");
            e.printStackTrace();
        }
    }

    @FXML
    private void seleccionarTodos() {
        listaAsignaciones.forEach(a -> a.setSeleccionado(true));
        tablaAsignaciones.refresh();
    }

    @FXML
    private void generarDocumentos() {
        long seleccionados = listaAsignaciones.stream()
                .filter(TablaAsignacion::isSeleccionado)
                .count();

        if (seleccionados == 0) {
            Utilidad.crearAlerta(Alert.AlertType.INFORMATION,
                    "Sin selección",
                    "Seleccione al menos una asignación para generar documentos.");
            return;
        }

        try {
            Periodo periodoActual = PeriodoDAO.obtenerPeriodoActual();
            if (periodoActual == null) {
                Utilidad.crearAlerta(Alert.AlertType.WARNING,
                        "Periodo no encontrado",
                        "No hay un periodo activo para la fecha actual.");
                return;
            }
            int idPeriodoActual = periodoActual.getIdPeriodo();

            listaAsignaciones.stream()
                    .filter(TablaAsignacion::isSeleccionado)
                    .forEach(asignacion -> {
                        try {
                            byte[] pdf = Impresora.generarDocumentoAsignacion(asignacion);
                            if (pdf == null) {
                                System.err.println("No se generó PDF para: " + asignacion.getNombreEstudiante());
                                return;
                            }

                            String nombreArchivo = String.format("Asignacion_%s_%s.pdf",
                                    asignacion.getNombreEstudiante().replace(" ", "_"),
                                    asignacion.getMatricula());
                            Path ruta = Path.of(System.getProperty("user.home"), "Documents", nombreArchivo);
                            Files.write(ruta, pdf);

                            OficioAsignacion oficio = new OficioAsignacion();
                            oficio.setIdEstudiante(asignacion.getIdEstudiante());
                            oficio.setIdPeriodo(idPeriodoActual);
                            oficio.setDocumento(pdf);

                            boolean existe = OficioAsignacionDAO.yaExiste(asignacion.getIdEstudiante(), idPeriodoActual);
                            boolean operacionExitosa;

                            if (existe) {
                                operacionExitosa = OficioAsignacionDAO.actualizar(oficio);
                                System.out.println("Oficio actualizado para: " + asignacion.getNombreEstudiante());
                            } else {
                                operacionExitosa = OficioAsignacionDAO.guardar(oficio);
                                System.out.println("Oficio guardado para: " + asignacion.getNombreEstudiante());
                            }

                            if (!operacionExitosa) {
                                System.err.println("No se pudo guardar o actualizar el oficio para: " + asignacion.getNombreEstudiante());
                            }

                        } catch (Exception e) {
                            Utilidad.mostrarError(true, e,
                                    "Error al generar oficio",
                                    "No se pudo generar el oficio para: " + asignacion.getNombreEstudiante());
                        }
                    });

            Utilidad.crearAlerta(Alert.AlertType.INFORMATION,
                    "Proceso finalizado",
                    "Los documentos fueron generados y almacenados correctamente.");
        } catch (SQLException e) {
            Utilidad.crearAlerta(Alert.AlertType.ERROR,
                    "Error de base de datos",
                    "No se pudo verificar duplicados o recuperar el periodo activo.");
            e.printStackTrace();
        }
    }
}
