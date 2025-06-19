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
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.entidades.PreferenciaProyectoDAO;
import sgpp.modelo.dao.entidades.ProyectoDAO;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.sql.SQLException;
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
    private TextArea txSegundaOpcion;
    @FXML
    private TextArea txArTerceraOpcion;

    private ObservableList<Estudiante> estudiantes;
    private ObservableList<Proyecto> proyectos;
    private ObservableList<PreferenciaProyecto> preferencias;

    public void initialize(URL url, ResourceBundle rb) {
        vboxPreferenciaProyecto.setVisible(false);
        cargarEstudiantes();
        cargarProyectos();
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

    private void cargarPreferencias(int idEstudiante) {
        preferencias = FXCollections.observableArrayList();
        try {
            List<PreferenciaProyecto> preferenciasAux = PreferenciaProyectoDAO.obtenerPreferenciasDelEstudiante(idEstudiante);
            preferencias.addAll(preferenciasAux);
            //TODO?
        } catch (SQLException sqlex) {
            System.out.println("Error al obtener los preferencias" + sqlex.getMessage());
            Utilidad.crearAlerta(Alert.AlertType.ERROR, "Error", "No se pudo cargar los preferencias del Estudiante");
        }
    }

    public void clicBtnSalir(ActionEvent actionEvent) {
        boolean confirmacion = Utilidad.crearAlertaConfirmacion(
                "¿Cancelar?", "Se perderá el progreso no guardado");
        if (confirmacion) {
            Utilidad.getEscenarioComponente(listProyectos).close();
        }
    }

    public void clicBtnAsignar(ActionEvent actionEvent) {
    }

    public void clicListEstudiantes(MouseEvent mouseEvent) {
        Estudiante estudianteSeleccionado = listEstudiantes.getSelectionModel().getSelectedItem();
        if (estudianteSeleccionado != null) {
            cargarPreferencias(estudianteSeleccionado.getIdEstudiante());
        }
    }

    private void mostrarPreferencias(List<PreferenciaProyecto> preferencias) {
        if (preferencias != null && !preferencias.isEmpty()) {

        } else {
            Utilidad.crearAlerta(
                    Alert.AlertType.WARNING,
                    "Notificacion",
                    "No hay preferencias registradas para este Estudiante");
        }
    }
}
