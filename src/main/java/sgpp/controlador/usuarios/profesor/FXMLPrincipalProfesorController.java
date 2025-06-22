package sgpp.controlador.usuarios.profesor;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.modelo.IControladorPrincipal;
import sgpp.modelo.beans.Profesor;
import sgpp.modelo.beans.Usuario;
import sgpp.modelo.dao.entidades.ProfesorDAO;
import sgpp.utilidad.Utilidad;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

import static sgpp.utilidad.Utilidad.cerrarVentana;

public class FXMLPrincipalProfesorController implements Initializable, IControladorPrincipal {
    @FXML
    private Label lbNombreProfesor;
    private Profesor profesor;

    private static final String RUTA_FXML_SELECCION_ESTUDIANTE = "/sgpp/vista/usuarios/profesor/FXMLSeleccionEstudiante.fxml";
    private static final String RUTA_FXML_VALIDAR_DOCUMENTO = "/sgpp/vista/usuarios/profesor/FXMLValidarDocumento.fxml";
    private static final String RUTA_FXML_VALIDAR_REPORTE = "/sgpp/vista/usuarios/profesor/FXMLValidarReporte.fxml";

    private int idProfesor;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
    }

    @Override
    public void inicializarUsuario(Usuario sesion) {
        try {
            Profesor profesor = ProfesorDAO.obtenerPorIdUsuario(sesion.getIdUsuario());
            if (profesor != null) {
                this.profesor = profesor;
                this.idProfesor = profesor.getIdProfesor();
                lbNombreProfesor.setText(String.format("Bienvenid@, %s",  profesor.getNombre()));
            } else {
                Utilidad.crearAlertaAdvertencia(
                        "Notificación",
                        "Lo sentimos, su usuario existe pero no pudimos encontrar su perfil, comuniquese con el administrador");
                cerrarVentana(lbNombreProfesor);
            }
        } catch (SQLException sqlex) {
            Utilidad.crearAlertaError(
                    "Error",
                    "Lo sentimos, de momento no se pudo iniciar sesion por favor intentelo más tarde");
            cerrarVentana(lbNombreProfesor);
        }
    }

    public void clicBtnExpedienteEstudiante(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_SELECCION_ESTUDIANTE, "Seleccionar Estudiante");
    }

    public void clicBtnValidarDocumento(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_VALIDAR_DOCUMENTO, "Validar Documento");
    }

    public void clicBtnValidarReporte(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_VALIDAR_REPORTE, "Validar Reporte");   
    }

    public void clicBtnEvaluarPresentacion(ActionEvent actionEvent) {
        try {
            Stage escenarioBase = new Stage();
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(RUTA_FXML_SELECCION_ESTUDIANTE));

            Parent vista = cargador.load();

            FXMLSeleccionEstudianteController controlador = cargador.getController();
            controlador.prepararParaRubrica(idProfesor);

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle("Seleccionar Estudiante");
            escenarioBase.show();
        } catch (IOException excepcion) {
            Utilidad.mostrarError(true, excepcion,
                    "Error al cargar lista de estudiantes",
                    "No se pudo cargar la ventana de lista de estudiantes");
        }
    }
}
