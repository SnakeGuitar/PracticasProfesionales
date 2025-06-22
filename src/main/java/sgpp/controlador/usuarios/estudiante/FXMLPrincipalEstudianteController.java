/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 13-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase controller para gestionar la vista principal del estudiante
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.estudiante;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Modality;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.controlador.usuarios.estudiante.documentopracticas.FXMLSubirDocumentoPracticasController;
import sgpp.modelo.IControladorPrincipal;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.Usuario;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.utilidad.Utilidad;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

import static sgpp.utilidad.Utilidad.cerrarVentana;

public class FXMLPrincipalEstudianteController implements Initializable, IControladorPrincipal {
    @FXML
    private Label lbNombreEstudiante;
    private Estudiante estudiante;

    private static final String RUTA_FXML_SUBIR_DOCUMENTO = "/sgpp/vista/usuarios/estudiante/documentopracticas/FXMLSubirDocumentoPracticas.fxml";
    private static final String RUTA_FXML_CONSULTAR_AVANCE = "";
    private static final String RUTA_FXML_LLENAR_AUTOEVALUACION = "/sgpp/vista/usuarios/estudiante/FXMLAutoevaluacionEstudiante.fxml";
    private static final String RUTA_FXML_FORMATO_EVALUACION = "";
    private static final String RUTA_FXML_SUBIR_REPORTE = "/sgpp/vista/usuarios/estudiante/FXMLEntregaReporteMensual.fxml";

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // Inicialización de la vista principal del estudiante
    }

    public void inicializarUsuario(Usuario sesion) {
        try {
            Estudiante estudiante = EstudianteDAO.obtenerPorIdUsuario(sesion.getIdUsuario());
            if (estudiante != null) {
                this.estudiante = estudiante;
                lbNombreEstudiante.setText(String.format("Bienvenid@, %s",  estudiante.getNombre()));
            } else {
                Utilidad.crearAlertaAdvertencia(
                        "Notificación",
                        "Lo sentimos, su usuario existe pero no pudimos encontrar su perfil, comuniquese con el administrador");
                cerrarVentana(lbNombreEstudiante);
            }
        } catch (SQLException sqlex) {
            Utilidad.crearAlertaError(
                    "Error",
                    "Lo sentimos, de momento no se pudo iniciar sesion por favor intentelo más tarde");
            cerrarVentana(lbNombreEstudiante);
        }
    }

    public void clicBtnReporte(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_SUBIR_REPORTE, "ReportesMensuales");
    }

    public void clicBtnFormatoEvaluacion(ActionEvent actionEvent) {

    }

    public void clicBtnAutoevaluacion(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_LLENAR_AUTOEVALUACION, "Llenar Autoevaluación");
    }

    public void clicBtnAvance(ActionEvent actionEvent) {
    }

    public void clicBtnSubirDocumento(ActionEvent actionEvent) {
        try {
            FXMLLoader cargador = new FXMLLoader(getClass().getResource(RUTA_FXML_SUBIR_DOCUMENTO));
            Parent vista = cargador.load();
            FXMLSubirDocumentoPracticasController controlador = cargador.getController();
            controlador.cargarEstudiante(estudiante);
            Stage escenario = new Stage();
            escenario.setScene(new Scene(vista));
            escenario.setTitle("Consultar Entregas");
            escenario.initModality(Modality.APPLICATION_MODAL);
            escenario.showAndWait();
        } catch (IOException ioex) {
            Utilidad.crearAlertaError("Error", "No se pudo cargar la ventana");
        }
    }

    public void clicBtnExpediente(ActionEvent actionEvent) {
    }
}