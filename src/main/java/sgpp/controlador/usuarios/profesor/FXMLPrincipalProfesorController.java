package sgpp.controlador.usuarios.profesor;

import javafx.event.ActionEvent;
import javafx.fxml.Initializable;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.util.ResourceBundle;

public class FXMLPrincipalProfesorController implements Initializable {
    private static final String RUTA_FXML_EXPEDIENTE_ESTUDIANTE = "/sgpp/vista/usuarios/profesor/FXMLExpedienteProfesor.fxml";
    private static final String RUTA_FXML_VALIDAR_DOCUMENTO = "/sgpp/vista/usuarios/profesor/FXMLValidarDocumento.fxml";
    


    @Override
    public void initialize(URL url, ResourceBundle rb) {
    }

    public void clicBtnExpedienteEstudiante(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_EXPEDIENTE_ESTUDIANTE, "Expediente Estudiante");
    }

    public void clicBtnValidarDocumento(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_VALIDAR_DOCUMENTO, "Validar Documento");
    }

    public void clicBtnValidarReporte(ActionEvent actionEvent) {
    }
}
