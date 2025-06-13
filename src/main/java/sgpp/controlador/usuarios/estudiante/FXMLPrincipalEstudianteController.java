package sgpp.controlador.usuarios.estudiante;

import javafx.event.ActionEvent;
import sgpp.utilidad.Utilidad;

public class FXMLPrincipalEstudianteController implements javafx.fxml.Initializable {
    private static final String RUTA_FXML_SUBIR_DOCUMENTO = "/sgpp/vista/usuarios/estudiante/documentopracticas/FXMLSubirDocumentoPracticas.fxml";
    private static final String RUTA_FXML_CONSULTAR_AVANCE = "";
    private static final String RUTA_FXML_LLENAR_AUTOEVALUACION = "";
    private static final String RUTA_FXML_FORMATO_EVALUACION = "";
    private static final String RUTA_FXML_SUBIR_REPORTE = "";

    @Override
    public void initialize(java.net.URL url, java.util.ResourceBundle rb) {
        // Inicialización de la vista principal del estudiante
    }

    public void clicBtnReporte(ActionEvent actionEvent) {
    }

    public void clicBtnFormatoEvaluacion(ActionEvent actionEvent) {
    }

    public void clicBtnAutoevaluacion(ActionEvent actionEvent) {
    }

    public void clicBtnAvance(ActionEvent actionEvent) {
    }

    public void clicBtnDocumentos(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_SUBIR_DOCUMENTO, "Subir Documento de Prácticas");

    }
}
