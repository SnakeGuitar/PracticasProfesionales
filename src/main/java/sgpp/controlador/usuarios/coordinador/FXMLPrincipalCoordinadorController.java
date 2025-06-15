/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 10-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 11-06-2025
 * Descripción: Clase controlador para manejar las operaciones de la vista FXMLPrincipalCoordinador.fxml
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.coordinador;

import javafx.event.ActionEvent;
import javafx.fxml.Initializable;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.util.ResourceBundle;

public class FXMLPrincipalCoordinadorController implements Initializable {

    private static final String RUTA_FXML_PROYECTO = "/sgpp/vista/usuarios/coordinador/proyecto/FXMLProyecto.fxml";
    private static final String RUTA_FXML_ORGANIZACION_VINCULDADA = "/sgpp/vista/usuarios/coordinador/organizacionvinculada/FXMLOrganizacionVinculada.fxml";
    private static final String RUTA_FXML_RESPONSABLE_TECNICO = "/sgpp/vista/usuarios/coordinador/responsabletecnico/FXMLPrincipalResponsableTecnico.fxml"; // implementar
    private static final String RUTA_FXML_DOCUMENTOS_ASIGNACION = "/sgpp/vista/usuarios/coordinador/"; // implementar
    private static final String RUTA_FXML_PROGRAMAR_ENTREGAS = "/sgpp/vista/usuarios/coordinador/"; // implementar

    @Override
    public void initialize(URL url, ResourceBundle resources) {
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
    }

    public void clicBtnProgramarEntregas(ActionEvent actionEvent) {
    }
}
