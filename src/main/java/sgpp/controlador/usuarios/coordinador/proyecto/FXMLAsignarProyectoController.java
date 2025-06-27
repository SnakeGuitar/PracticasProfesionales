/*
 * Autor original: Abel Hernandez Yong
 * Ultimo autor: Abel Hernandez Yong
 * Fecha de creación: 16-06-2025
 * Fecha de la última versión aprobada: 23-06-2026
 * Fecha de la última modificación: 23-06-2025
 * Descripción: Controlador para manejar las operaciones de la vista FXMLAsignarProyecto.fxml
 *              Se encarga de mostrar la lista de proyectos disponibles y estudiantes pendientes de asignacion
 *              asi como la preferencia de proyecto del estudiante seleccionado
 */

/*
 * Estado: Completado
 * Modificaciones: Se reemplazo el metodo cerrar ventana con Utilidad.cerrarVentana()
 */

package sgpp.controlador.usuarios.coordinador.proyecto;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.SortedList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.TextArea;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.PreferenciaProyecto;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.dao.ResultadoSQL;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.entidades.PreferenciaProyectoDAO;
import sgpp.modelo.dao.entidades.ProyectoDAO;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.ResourceBundle;

public class FXMLAsignarProyectoController implements Initializable {
    @FXML
    private ListView<Estudiante> listEstudiantes;
    @FXML
    private ListView<Proyecto> listProyectos;
    @FXML
    private VBox vboxPreferenciaProyecto;
    @FXML
    private Label lbPreferenciaProyecto;
    @FXML
    private Label lbNombreEstudiante;
    @FXML
    private TextArea txArPrimeraOpcion;
    @FXML
    private TextArea txArSegundaOpcion;
    @FXML
    private TextArea txArTerceraOpcion;

    private ObservableList<Estudiante> estudiantes;
    private ObservableList<Proyecto> proyectos;
    private List<PreferenciaProyecto> preferencias;
    private List<Proyecto> proyectosPreferidos;

    public void initialize(URL url, ResourceBundle rb) {
        vboxPreferenciaProyecto.setVisible(false);
        cargarDatos();
    }

    private void cargarDatos() {
        cargarEstudiantes();
        cargarProyectos();
        cargarPreferencias();
        cargarNombresProyectosPreferidos();
    }

    private void cargarEstudiantes() {
        estudiantes = FXCollections.observableArrayList();
        try {
            List<Estudiante> estudiantesAux = EstudianteDAO.obtenerEstudiantesPendientesDeAsignacion();
            estudiantes.addAll(estudiantesAux);
            SortedList<Estudiante> estudiantesOrdenados = ordenarEstudiantes(estudiantes);
            listEstudiantes.setItems(estudiantesOrdenados);
        } catch (SQLException sqlex) {
            System.out.println("Error al obtener estudiantes: " + sqlex.getMessage());
            Utilidad.crearAlerta(Alert.AlertType.ERROR, "Error", "No se pudo cargar los Estudiantes");
        }
    }

    private SortedList<Estudiante> ordenarEstudiantes(ObservableList<Estudiante> estudiantes) {
        SortedList<Estudiante> estudiantesOrdenados = new SortedList<>(estudiantes);
        Comparator<Estudiante> comparador = Comparator.
                comparingInt(Estudiante::getSemestre).
                thenComparingDouble(Estudiante::getPromedio);
        estudiantesOrdenados.setComparator(comparador.reversed());
        return estudiantesOrdenados;
    }

    private void cargarProyectos() {
        proyectos = FXCollections.observableArrayList();
        try {
            List<Proyecto> proyectosAux = ProyectoDAO.obtenerProyectosDisponibles();
            proyectos.addAll(proyectosAux);
            listProyectos.setItems(proyectos);
        } catch (SQLException sqlex) {
            System.out.println("Error al obtener los proyectos" + sqlex.getMessage());
            Utilidad.crearAlerta(Alert.AlertType.ERROR, "Error", "No se pudo cargar los proyectos");
        }
    }

    private void cargarPreferencias() {
        try {
            int[] ids = obtenerIDsEstudiantes();
            preferencias = PreferenciaProyectoDAO.obtenerPreferencias(ids);
        } catch (SQLException sqlex) {
            System.out.println("Error al obtener los preferencias" + sqlex.getMessage());
            Utilidad.crearAlerta(
                    Alert.AlertType.ERROR,
                    "Error",
                    "No se pudo cargar los preferencias del Estudiante");
        }
    }

    private void cargarNombresProyectosPreferidos() {
        try {
            int[] ids = obtenerIDsProyectosPorPreferencia();
            proyectosPreferidos = ProyectoDAO.nombreProyectos(ids);
        } catch (SQLException sqlex) {
            System.out.println("Error al obtener los proyectos preferidos: "+sqlex.getMessage());
            Utilidad.crearAlerta(
                    Alert.AlertType.ERROR,
                    "Error",
                    "No se pudo cargar los proyectos preferidos del Estudiante");
        }
    }

    public void clicBtnSalir(ActionEvent actionEvent) {
        boolean confirmacion = Utilidad.crearAlertaConfirmacion(
                "¿Cancelar?", "Se perderá el progreso no guardado");
        if (confirmacion) {
            Utilidad.cerrarVentana(lbNombreEstudiante);
        }
    }

    public void clicBtnAsignar(ActionEvent actionEvent) {
        Proyecto proyecto = listProyectos.getSelectionModel().getSelectedItem();
        Estudiante estudiante = listEstudiantes.getSelectionModel().getSelectedItem();
        if (proyecto != null && estudiante != null) {
            boolean confirmacion = Utilidad.crearAlertaConfirmacion(
                    "Confirmar",
                    String.format("¿Asignar al Estudiante %s al Proyecto %s? Esta accion no se puede deshacer",
                            estudiante.getNombre(), proyecto.getNombre()));
            if (confirmacion) {
                asignarProyecto(estudiante, proyecto);
            }
        } else {
            Utilidad.crearAlerta(Alert.AlertType.INFORMATION,
                    "Notificación",
                    "Por favor seleccione un Estudiante y un Proyecto.");
        }
    }

    private void asignarProyecto(Estudiante estudiante, Proyecto proyecto) {
        try {
            ResultadoSQL resultadoAsignacion = ProyectoDAO.asignarProyecto(
                    proyecto.getIdProyecto(), estudiante.getIdEstudiante()
            );
            if (!resultadoAsignacion.isError()) {
                Utilidad.crearAlerta(
                        Alert.AlertType.INFORMATION,
                        "Exito",
                        "Asignación realizada exitosamente");
                cargarDatos();
                vboxPreferenciaProyecto.setVisible(false);
            } else {
                Utilidad.crearAlerta(Alert.AlertType.ERROR, "Error", resultadoAsignacion.getMensaje());
            }
        } catch (SQLException sqlex) {
            System.out.println("Error al asignar proyecto: " + sqlex.getMessage());
            Utilidad.crearAlerta(Alert.AlertType.ERROR,
                    "Error",
                    "Lo sentimos, por el momento no se pudo asignar el Proyecto, por favor intentelo más tarde");
        }
    }

    public void clicListEstudiantes(MouseEvent mouseEvent) {
        Estudiante estudianteSeleccionado = listEstudiantes.getSelectionModel().getSelectedItem();
        if (estudianteSeleccionado != null) {
            vboxPreferenciaProyecto.setVisible(true);
            lbNombreEstudiante.setText(estudianteSeleccionado.getNombre());
            mostrarPreferencias(estudianteSeleccionado.getIdEstudiante());
        }
    }

    private void mostrarPreferencias(int idEstudianteSeleccionado) {
        List<PreferenciaProyecto> preferenciasDelEstudiante = new ArrayList<>();
        for (PreferenciaProyecto preferencia : preferencias) {
            if (preferencia.getIdEstudiante() == idEstudianteSeleccionado) {
                preferenciasDelEstudiante.add(preferencia);
            }
        }
        if (!preferenciasDelEstudiante.isEmpty()) {
            for (PreferenciaProyecto preferencia : preferenciasDelEstudiante) {
                colocarPreferencia(preferencia);
            }
        } else {
            Utilidad.crearAlerta(
                    Alert.AlertType.WARNING,
                    "Notificacion",
                    "No hay preferencias registradas para este estudiante");
        }
    }

    private void colocarPreferencia(PreferenciaProyecto preferencia) {
        int numPreferencia = preferencia.getNumPreferencia();
        int idProyecto = preferencia.getIdProyecto();
        for (Proyecto preferido : proyectosPreferidos) {
            if (preferido.getIdProyecto() == idProyecto) {
                switch (numPreferencia) {
                    case 1:
                        txArPrimeraOpcion.setText(preferido.getNombre());
                        break;
                    case 2:
                        txArSegundaOpcion.setText(preferido.getNombre());
                        break;
                    case 3:
                        txArTerceraOpcion.setText(preferido.getNombre());
                        break;
                    default:
                        break;
                }
            }
        }
    }

    private int[] obtenerIDsEstudiantes() {
        int[] ids = new int[estudiantes.size()];
        for (int i = 0; i < estudiantes.size(); i++) {
            ids[i] = estudiantes.get(i).getIdEstudiante();
        }
        return ids;
    }

    private int[] obtenerIDsProyectosPorPreferencia() {
        int[] ids = new int[preferencias.size()];
        for (int i = 0; i < preferencias.size(); i++) {
            ids[i] = preferencias.get(i).getIdProyecto();
        }
        return ids;
    }
}
