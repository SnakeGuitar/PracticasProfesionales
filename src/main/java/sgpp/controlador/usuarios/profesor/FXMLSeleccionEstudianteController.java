package sgpp.controlador.usuarios.profesor;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.Periodo;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.utilidad.Utilidad;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class FXMLSeleccionEstudianteController implements Initializable {
    private static final String RUTA_FXML_EXPEDIENTE_PROFESOR = "/sgpp/vista/usuarios/profesor/FXMLExpedienteProfesor.fxml";
    private static final String RUTA_FXML_RUBRICA_PRESENTACION = "/sgpp/vista/usuarios/profesor/FXMLCriteriosPresentacion.fxml";

    @FXML
    public Button btnRefrescar;

    @FXML
    public Button btnRegresar;

    @FXML
    public Button btnConsultar;

    @FXML
    public TableView<Estudiante> tblEstudiantes;

    @FXML
    public TableColumn colMatricula;

    @FXML
    public TableColumn colNombre;

    private ObservableList<Estudiante> estudiantes;

    private boolean irRubrica;

    private int idProfesor;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        configurarTabla();
        cargarInformacion();
    }

    public void prepararParaRubrica(int idProfesor) {
        if(idProfesor != 0) {
            irRubrica = true;
            this.idProfesor = idProfesor;

            btnConsultar.setText("Evaluar");
        }
    }

    private void configurarTabla() {
        colMatricula.setCellValueFactory(new PropertyValueFactory("matricula"));
        colNombre.setCellValueFactory(new PropertyValueFactory("nombre"));
    }

    private void cargarInformacion() {
        try {
            estudiantes = FXCollections.observableArrayList();
            ArrayList<Estudiante> estudiantesDAO = EstudianteDAO.obtenerEstudiantes();
            estudiantes.addAll(estudiantesDAO);
            tblEstudiantes.setItems(estudiantes);
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    private void irExpedienteEstudiante(int idEstudiante, int idPeriodo) {
        try {
            Stage escenarioBase = Utilidad.getEscenarioComponente(btnConsultar);
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(
                            RUTA_FXML_EXPEDIENTE_PROFESOR));

            Parent vista = cargador.load();

            FXMLExpedienteProfesorController controlador = cargador.getController();
            controlador.inicializarInformacion(idEstudiante, idPeriodo);

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle("Expediente de Estudiante");
            escenarioBase.show();
        } catch (IOException excepcion) {
            Utilidad.mostrarError(true, excepcion,
                    "Error al cargar expediente",
                    "No se pudo cargar la ventana del expediente");
        }
    }

    private void irRubricaPresentacion(int idEstudiante, int idProfesor, int idPeriodo) {
        try {
            Stage escenarioBase = Utilidad.getEscenarioComponente(btnConsultar);
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(
                            RUTA_FXML_RUBRICA_PRESENTACION));

            Parent vista = cargador.load();

            FXMLCriteriosPresentacionController controlador = cargador.getController();
            controlador.inicializarInformacion(idEstudiante, idProfesor, idPeriodo);

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle("Criterios de Presentación");
            escenarioBase.show();
        } catch (IOException excepcion) {
            Utilidad.mostrarError(true, excepcion,
                    "Error al cargar criterios",
                    "No se pudo cargar la ventana de criterios");
        }
    }

    private void mostrarAlertaSeleccionEstudiante() {
        Utilidad.crearAlertaAdvertencia("Selecciona un estudiante",
                "Selecciona un estudiante para continuar.");
    }

    private Estudiante obtenerEstudianteDeTabla() {
        return tblEstudiantes.getSelectionModel().getSelectedItem();
    }

    public void btnClicRefrescar(ActionEvent actionEvent) {
        cargarInformacion();
    }

    public void btnClicRegresar(ActionEvent actionEvent) {
        Utilidad.cerrarVentana(btnConsultar);
    }

    public void btnClicConsultar(ActionEvent actionEvent) throws SQLException {
        int idEstudiante = obtenerEstudianteDeTabla().getIdEstudiante();
        int idPeriodo = PeriodoDAO.obtenerPeriodoActual().getIdPeriodo();

        if(idEstudiante != 0) {
            if(irRubrica) { // Si la selección del estudiante es para evaluar presentación.
                irRubricaPresentacion(idEstudiante, idProfesor, idPeriodo);
            } else { // Si es para ver expediente.
                irExpedienteEstudiante(idEstudiante, idPeriodo);
            }
        } else {
            mostrarAlertaSeleccionEstudiante();
        }
    }
}
