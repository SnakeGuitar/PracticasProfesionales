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
import javafx.stage.Modality;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.controlador.usuarios.FXMLExpedienteEstudianteController;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.expediente.presentacion.RubricaPresentacionDAO;
import sgpp.utilidad.Impresora;
import sgpp.utilidad.Utilidad;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class FXMLSeleccionEstudianteController implements Initializable {
    private static final String RUTA_FXML_EXPEDIENTE_ESTUDIANTE = "/sgpp/vista/usuarios/FXMLExpedienteEstudiante.fxml";
    private static final String RUTA_FXML_RUBRICA_PRESENTACION = "/sgpp/vista/usuarios/profesor/FXMLCriteriosPresentacion.fxml";

    @FXML
    public Button btnRegresar;
    @FXML
    public Button btnConsultar;
    @FXML
    public TableView<Estudiante> tblEstudiantes;
    @FXML
    public TableColumn<Estudiante, String> colMatricula;
    @FXML
    public TableColumn<Estudiante, String> colNombre;
    private ObservableList<Estudiante> estudiantes;

    private boolean irRubrica = false;
    private int idProfesor = 0;

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
            int idPeriodoActual = PeriodoDAO.obtenerPeriodoActual().getIdPeriodo();
            estudiantes = FXCollections.observableArrayList();
            ArrayList<Estudiante> estudiantesDAO = EstudianteDAO.obtenerEstudiantesPorPeriodo(idPeriodoActual);
            estudiantes.addAll(estudiantesDAO);
            tblEstudiantes.setItems(estudiantes);
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    private void irExpedienteEstudiante(Estudiante estudiante) {
        try {
            Stage escenarioBase = Utilidad.getEscenarioComponente(btnConsultar);
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(
                            RUTA_FXML_EXPEDIENTE_ESTUDIANTE));

            Parent vista = cargador.load();

            FXMLExpedienteEstudianteController controlador = cargador.getController();
            controlador.inicializarInformacion(estudiante);

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle("Expediente de Estudiante");
            escenarioBase.show();
        } catch (IOException | SQLException ioex) {
            Utilidad.mostrarError(
                    true, ioex,
                    "Error al cargar expediente",
                    "No se pudo cargar la ventana del expediente");
        }
    }

    private void irRubricaPresentacion(int idEstudiante, int idProfesor) {
        try {
            Stage escenarioBase = new Stage();
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(
                            RUTA_FXML_RUBRICA_PRESENTACION));

            Parent vista = cargador.load();

            FXMLCriteriosPresentacionController controlador = cargador.getController();
            controlador.inicializarInformacion(idEstudiante, idProfesor);

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle("Criterios de Presentación");
            escenarioBase.initModality(Modality.APPLICATION_MODAL);
            escenarioBase.show();
        } catch (IOException | SQLException excepcion) {
            Utilidad.mostrarError(true, excepcion,
                    "Error al cargar criterios",
                    "No se pudo cargar la ventana de criterios");
        }
    }

    private void definirSiguienteVentana() throws SQLException {
        Estudiante estudianteSeleccionado = obtenerEstudianteDeTabla();

        if(estudianteSeleccionado != null) {
            int idEstudiante = estudianteSeleccionado.getIdEstudiante();

            if(irRubrica) { // Si la selección del estudiante es para evaluar presentación.
                RubricaPresentacion rubrica = RubricaPresentacionDAO.obtenerPorEstudiante(idEstudiante);

                if(rubrica == null) {
                    irRubricaPresentacion(idEstudiante, idProfesor);
                } else {
                    boolean descargar = Utilidad.crearAlertaConfirmacion("Rúbrica encontrada",
                            "El estudiante ya cuenta con una rúbrica de presentación evaluada.\n" +
                                    "¿Deseas descargarla?");
                    if(descargar) {
                        Impresora.descargarRubrica(rubrica, btnConsultar, idEstudiante);
                    }
                }
            } else { // Si es para ver expediente.
                irExpedienteEstudiante(estudianteSeleccionado);
            }
        } else {
            Utilidad.crearAlertaError("Error", "No se pudo recuperar el periodo");
        }
    }

    private Estudiante obtenerEstudianteDeTabla() {
        return tblEstudiantes.getSelectionModel().getSelectedItem();
    }

    private void verificarSeleccion() throws SQLException {
        if(obtenerEstudianteDeTabla() != null) {
            definirSiguienteVentana();
        } else {
            Utilidad.crearAlertaAdvertencia("Selecciona un estudiante",
                    "Selecciona un estudiante para continuar.");
        }
    }

    public void btnClicRegresar(ActionEvent actionEvent) {
        Utilidad.cerrarVentana(btnConsultar);
    }

    public void btnClicConsultar(ActionEvent actionEvent) throws SQLException {
        verificarSeleccion();
    }
}
