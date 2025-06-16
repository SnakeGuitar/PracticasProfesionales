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
import javafx.fxml.Initializable;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.util.ResourceBundle;

public class FXMLPrincipalEstudianteController implements Initializable {
    private static final String RUTA_FXML_CONSULTAR_ENTREGAS = "/sgpp/vista/usuarios/estudiante/documentopracticas/FXMLConsultarExpediente.fxml";
    private static final String RUTA_FXML_CONSULTAR_AVANCE = "";
    private static final String RUTA_FXML_LLENAR_AUTOEVALUACION = "/sgpp/vista/usuarios/estudiante/FXMLAutoevaluacionEstudiante.fxml";
    private static final String RUTA_FXML_FORMATO_EVALUACION = "";
    private static final String RUTA_FXML_SUBIR_REPORTE = "/sgpp/vista/usuarios/estudiante/FXMLEntregaReporteMensual.fxml";

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // Inicialización de la vista principal del estudiante
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

    public void clicBtnExpediente(ActionEvent actionEvent) {
        Utilidad.crearEscenario(RUTA_FXML_CONSULTAR_ENTREGAS, "Consultar Entregas");

    }
}
