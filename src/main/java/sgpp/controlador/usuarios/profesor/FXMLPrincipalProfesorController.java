package sgpp.controlador.usuarios.profesor;

import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.utilidad.Utilidad;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class FXMLPrincipalProfesorController implements Initializable {
    private static final String RUTA_FXML_SELECCIONAR_ESTUDIANTE = "/sgpp/vista/usuarios/profesor/FXMLSeleccionarEstudiante.fxml";
    private static final String RUTA_FXML_VALIDAR_DOCUMENTO = "/sgpp/vista/usuarios/profesor/FXMLValidarDocumento.fxml";
    private static final String RUTA_FXML_VALIDAR_REPORTE = "/sgpp/vista/usuarios/profesor/FXMLValidarReporte.fxml";
    
    private int idProfesor;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
    }

    public void inicializarInformacion(int idProfesor) {
        this.idProfesor = idProfesor;
    }

    public void clicBtnExpedienteEstudiante(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_SELECCIONAR_ESTUDIANTE, "Seleccionar Estudiante");
    }

    public void clicBtnValidarDocumento(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_VALIDAR_DOCUMENTO, "Validar Documento");
    }

    public void clicBtnValidarReporte(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_VALIDAR_REPORTE, "Validar Reporte");   
    }

    public void blicBtnEvaluarPresentacion(ActionEvent actionEvent) {
        try {
            Stage escenarioBase = new Stage();
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(RUTA_FXML_SELECCIONAR_ESTUDIANTE));

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
