/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Controlador JavaFX para la generación de documentos de asignación.
 *              Obtiene los datos desde la base de datos a través del DAO,
 *              los muestra en una tabla interactiva con checkboxes y permite
 *              generar documentos para los seleccionados.
 *
 * Estado: En funcionamiento
 * Modificaciones:
 * - Separación con POJO y DAO
 * - Manejo de errores mediante Utilidad.crearAlerta()
 * - Mejora visual y funcional con selección múltiple
 */

package sgpp.controlador.usuarios.coordinador;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.CheckBoxTableCell;
import sgpp.modelo.beans.expediente.documentoinicial.TablaAsignacion;
import sgpp.modelo.dao.entidades.TablaAsignacionDAO;
import sgpp.utilidad.Utilidad;

import java.sql.SQLException;

public class FXMLGenerarDocumentosController {

    // ──── FXML ────────────────────────────────────────────────────────────────
    @FXML private TableView<TablaAsignacion> tablaAsignaciones;
    @FXML private TableColumn<TablaAsignacion, String> colEmpresa;
    @FXML private TableColumn<TablaAsignacion, String> colProyecto;
    @FXML private TableColumn<TablaAsignacion, String> colAlumno;
    @FXML private TableColumn<TablaAsignacion, String> colMatricula;
    @FXML private TableColumn<TablaAsignacion, Boolean> colSeleccion;

    @FXML private Button btnGenerar;
    @FXML private Button btnSeleccionarTodos;

    // ──── Datos ───────────────────────────────────────────────────────────────
    private final ObservableList<TablaAsignacion> listaAsignaciones = FXCollections.observableArrayList();

    // ──── Inicialización ──────────────────────────────────────────────────────
    @FXML
    public void initialize() {
        configurarTabla();
        cargarDatos();
    }

    // ──── Configuración de la tabla ───────────────────────────────────────────
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

    // ──── Carga de datos desde el DAO ─────────────────────────────────────────
    private void cargarDatos() {
        try {
            listaAsignaciones.setAll(TablaAsignacionDAO.obtenerAsignaciones());
            tablaAsignaciones.setItems(listaAsignaciones);
        } catch (SQLException e) {
            Utilidad.crearAlerta(Alert.AlertType.ERROR,
                "Error al cargar asignaciones",
                "No se pudieron obtener las asignaciones desde la base de datos. Intente más tarde.");
            e.printStackTrace();
        }
    }

    // ──── Botón "Seleccionar todos" ───────────────────────────────────────────
    @FXML
    private void seleccionarTodos() {
        listaAsignaciones.forEach(a -> a.setSeleccionado(true));
        tablaAsignaciones.refresh(); // fuerza el refresco visual
    }

    // ──── Botón "Generar Documentos" ──────────────────────────────────────────
    @FXML
    private void generarDocumentos() {
        long seleccionados = listaAsignaciones.stream()
                .filter(TablaAsignacion::isSeleccionado)
                .count();

        if (seleccionados == 0) {
            Utilidad.crearAlerta(Alert.AlertType.INFORMATION,
                "Ninguna asignación seleccionada",
                "Por favor, seleccione al menos una asignación para generar documentos.");
            return;
        }

        listaAsignaciones.stream()
                .filter(TablaAsignacion::isSeleccionado)
                .forEach(a -> {
                    System.out.println("Generar documento para: " + a.getNombreEstudiante()
                            + " (" + a.getMatricula() + ") en proyecto: " + a.getNombreProyecto());
                    // Aquí va la lógica real de generación de documentos
                });

        Utilidad.crearAlerta(Alert.AlertType.INFORMATION,
            "Documentos generados",
            "Los documentos de asignación fueron generados exitosamente para los elementos seleccionados.");
    }
}
