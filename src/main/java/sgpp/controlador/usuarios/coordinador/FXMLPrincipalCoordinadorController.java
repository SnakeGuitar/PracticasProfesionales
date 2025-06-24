/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 10-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 11-06-2025
 * Descripción: Clase controlador para manejar las operaciones de la vista FXMLPrincipalCoordinador.fxml
 */

/*
 * Estado: TERMINADO
 * Modificaciones:
 * seth: carga el coordinador desde esta ventana a la principal de este
 */

package sgpp.controlador.usuarios.coordinador;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.input.MouseEvent;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.controlador.FXMLInicioSesionController;
import sgpp.modelo.IControladorPrincipal;
import sgpp.modelo.beans.Coordinador;
import sgpp.modelo.beans.Usuario;
import sgpp.modelo.dao.entidades.CoordinadorDAO;
import sgpp.utilidad.ResultadoFXML;
import sgpp.utilidad.UtilFXML;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

import static sgpp.utilidad.Utilidad.cerrarVentana;

public class FXMLPrincipalCoordinadorController implements Initializable, IControladorPrincipal {
    @FXML
    private Label lbNombreCoordinador;
    private Coordinador coordinador;

    private static final String RUTA_FXML_INICIAR_SESION = "/sgpp/vista/FXMLInicioSesion.fxml";
    private static final String RUTA_FXML_PROYECTO = "/sgpp/vista/usuarios/coordinador/proyecto/FXMLProyecto.fxml";
    private static final String RUTA_FXML_ORGANIZACION_VINCULDADA = "/sgpp/vista/usuarios/coordinador/organizacionvinculada/FXMLOrganizacionVinculada.fxml";
    private static final String RUTA_FXML_RESPONSABLE_TECNICO = "/sgpp/vista/usuarios/coordinador/responsabletecnico/FXMLPrincipalResponsableTecnico.fxml";
    private static final String RUTA_FXML_ASIGNAR_PROYECTO = "/sgpp/vista/usuarios/coordinador/proyecto/FXMLAsignarProyecto.fxml";
    private static final String RUTA_FXML_DOCUMENTOS_ASIGNACION = "/sgpp/vista/usuarios/coordinador/documentos/FXMLGenerarDocumentoAsignacion.fxml";
    private static final String RUTA_FXML_PROGRAMAR_ENTREGAS = "/sgpp/vista/usuarios/coordinador/FXMLConfigurarEntregas.fxml";

    @Override
    public void initialize(URL url, ResourceBundle resources) {
    }

    public void inicializarUsuario(Usuario sesion) {
        try {
            Coordinador coordinador = CoordinadorDAO.obtenerPorIdUsuario(sesion.getIdUsuario());
            if (coordinador != null) {
                this.coordinador = coordinador;
                lbNombreCoordinador.setText(String.format("Bienvenid@, %s",  coordinador.getNombre()));
            } else {
                Utilidad.crearAlertaAdvertencia(
                        "Notificación",
                        "Lo sentimos, su usuario existe pero no pudimos encontrar su perfil, comuniquese con el administrador");
                cerrarVentana(lbNombreCoordinador);
            }
        } catch (SQLException sqlex) {
            Utilidad.crearAlertaError(
                    "Error",
                    "Lo sentimos, de momento no se pudo iniciar sesion por favor intentelo más tarde");
            cerrarVentana(lbNombreCoordinador);
        }
    }

    public void clicBtnProyectos(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_PROYECTO, "Proyectos");
    }

    public void clicBtnOrganizacionVinculada(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_ORGANIZACION_VINCULDADA, "Organización Vinculada");
    }

    public void clicBtnResponsableTecnico(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_RESPONSABLE_TECNICO, "Responsable Tecnico");
    }

    public void clicBtnDocumentosAsignacion(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_DOCUMENTOS_ASIGNACION, "Generar Documentos de Asignación", coordinador);

    }

    public void clicBtnProgramarEntregas(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_PROGRAMAR_ENTREGAS, "Entregas de Practicas Profesionales");
    }

    public void clicBtnAsignarProyectos(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_ASIGNAR_PROYECTO, "Asignar Proyectos");
    }

    public void clicImgViCerrarSesion(MouseEvent mouseEvent) {
        boolean confirmacion = Utilidad.crearAlertaConfirmacion(
                "Cerrar Sesión", "¿Está seguro(a) que quiere cerrar sesión?");
        if (confirmacion) {
            new UtilFXML().abrirFXML(
                    RUTA_FXML_INICIAR_SESION,
                    "Sistema de Gestión de Prácticas Profesionales",
                    FXMLInicioSesionController.class);
            Utilidad.cerrarVentana(lbNombreCoordinador);
        }
    }
}
