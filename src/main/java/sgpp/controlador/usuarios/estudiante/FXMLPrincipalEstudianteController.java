/*
 * Autor original: Luis Donaldo
 * Último autor: Abel Yong
 * Fecha de creación: 13-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 22-06-2025
 * Descripción: Clase controller para gestionar la vista principal del estudiante
 */

/*
 * Estado: En progreso
 * Modificaciones: Eliminados metodos sin utilizar
 */

package sgpp.controlador.usuarios.estudiante;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.input.MouseEvent;
import javafx.stage.Modality;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.controlador.FXMLInicioSesionController;
import sgpp.controlador.usuarios.FXMLExpedienteEstudianteController;
import sgpp.controlador.usuarios.estudiante.documentopracticas.FXMLSubirDocumentoPracticasController;
import sgpp.modelo.IControladorPrincipal;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.Usuario;
import sgpp.modelo.beans.expediente.documentofinal.AutoEvaluacion;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.expediente.documentofinal.AutoEvaluacionDAO;
import sgpp.utilidad.UtilFXML;
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

    private static final String RUTA_FXML_INICIAR_SESION = "/sgpp/vista/FXMLInicioSesion.fxml";
    private static final String RUTA_FXML_SUBIR_DOCUMENTO = "/sgpp/vista/usuarios/estudiante/documentopracticas/FXMLSubirDocumentoPracticas.fxml";
    private static final String RUTA_FXML_CONSULTAR_AVANCE = "/sgpp/vista/usuarios/FXMLExpedienteEstudiante.fxml";
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

    private void irAutoevaluacion() {
        try {
            Stage escenarioBase = new Stage();
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(RUTA_FXML_LLENAR_AUTOEVALUACION));

            Parent vista = cargador.load();

            FXMLAutoevaluacionEstudianteController controlador = cargador.getController();
            controlador.inicializarInformacion(estudiante);

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle("Expediente de estudiante");
            escenarioBase.initModality(Modality.APPLICATION_MODAL);
            escenarioBase.show();
        } catch (IOException | SQLException excepcion) {
            Utilidad.mostrarError(true, excepcion,
                    "Error al cargar autoevaluación",
                    "No se pudo cargar la ventana de autoevaluación");
        }
    }

    public void clicBtnReporte(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_SUBIR_REPORTE, "ReportesMensuales");
    }

    public void clicBtnAutoevaluacion(ActionEvent actionEvent) throws SQLException {
        AutoEvaluacion autoEvaluacion = AutoEvaluacionDAO.obtenerPorIdEstudiante(estudiante.getIdEstudiante());

        if(autoEvaluacion == null) {
            irAutoevaluacion();
        } else {
            Utilidad.crearAlertaAdvertencia("Autoevaluación encontrada",
                    "El estudiante ya cuenta con una autoevaluación.");
        }
    }

    public void clicBtnAvance(ActionEvent actionEvent) {
        try {
            Stage escenarioBase = new Stage();
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(RUTA_FXML_CONSULTAR_AVANCE));

            Parent vista = cargador.load();

            int idPeriodo = PeriodoDAO.obtenerPeriodoActual().getIdPeriodo();

            FXMLExpedienteEstudianteController controlador = cargador.getController();
            controlador.inicializarInformacion(estudiante, idPeriodo);

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle("Expediente de estudiante");
            escenarioBase.show();
        } catch (IOException | SQLException excepcion) {
            Utilidad.mostrarError(true, excepcion,
                    "Error al cargar lista de estudiantes",
                    "No se pudo cargar la ventana de lista de estudiantes");
        }
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

    public void clicImgViCerrarSesion(MouseEvent mouseEvent) {
        boolean confirmacion = Utilidad.crearAlertaConfirmacion(
                "Cerrar Sesión", "¿Está seguro(a) que quiere cerrar sesión?");
        if (confirmacion) {
            new UtilFXML().abrirFXML(
                    RUTA_FXML_INICIAR_SESION,
                    "Sistema de Gestión de Prácticas Profesionales",
                    FXMLInicioSesionController.class);
            Utilidad.getEscenarioComponente(lbNombreEstudiante).close();
        }
    }
}