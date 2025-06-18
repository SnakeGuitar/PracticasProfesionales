package sgpp.controlador.usuarios.coordinador.proyecto;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.ListView;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.entidades.ProyectoDAO;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.sql.SQLException;
import java.util.List;
import java.util.ResourceBundle;

public class FXMLAsignarProyectoController implements Initializable {
    @FXML
    public ListView<Estudiante> listEstudiantes;
    @FXML
    public ListView<Proyecto> listProyectos;

    private ObservableList<Estudiante> estudiantes;
    private ObservableList<Proyecto> proyectos;

    public void initialize(URL url, ResourceBundle rb) {
        cargarEstudiantes();
        cargarProyectos();
    }

    private void cargarEstudiantes() {
        estudiantes = FXCollections.observableArrayList();
        try {
            List<Estudiante> estudiantesAux = EstudianteDAO.obtenerEstudiantesPendientesDeAsignacion();
            estudiantes.addAll(estudiantesAux);
            listEstudiantes.setItems(estudiantes);
        } catch (SQLException sqlex) {
            System.out.println("Error al obtener estudiantes: " + sqlex.getMessage());
            Utilidad.crearAlerta(Alert.AlertType.ERROR, "Error", "No se pudo cargar los Estudiantes");
        }
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

    public void clicBtnSalir(ActionEvent actionEvent) {
        boolean confirmacion = Utilidad.crearAlertaConfirmacion(
                "¿Cancelar?", "Se perderá el progreso no guardado");
        if (confirmacion) {
            Utilidad.getEscenarioComponente(listProyectos).close();
        }
    }

    public void clicBtnAsignar(ActionEvent actionEvent) {
    }
}
