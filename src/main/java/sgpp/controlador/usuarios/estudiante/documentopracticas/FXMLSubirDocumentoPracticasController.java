/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 13-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase controller para subir documentos de prácticas
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.estudiante.documentopracticas;

import javafx.event.ActionEvent;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.stage.Stage;

public class FXMLSubirDocumentoPracticasController implements javafx.fxml.Initializable {

    public TextArea txArDescripcionEntrega;
    public Label nombreArchivoDocumento;
    public Button btnCartaAceptacion;
    public Button btnCronograma;
    public Button btnOficioAsignacion;
    public Button btnHorarioUV;
    public Button btnConstanciaSeguro;
    public Label lblFechas;
    public Label lblFechas1;
    public Button btnReporteParcial;
    public Button btnEvaluacionParcialOV;
    public Label lblFechas2;
    public Button btnReporteFinal;
    public Button btnAutoevaluacion;
    public Button btnEvaluacionFinalOV;
    public Button btnCartaLiberacion;
    public Label lblFechas3;

    @Override
    public void initialize(java.net.URL url, java.util.ResourceBundle rb) {
        // Inicialización de la vista para subir documentos de prácticas
    }

    public void clicBtnEntregarDocumento(ActionEvent actionEvent) {
    }

    public void clicBtnCancelar(ActionEvent actionEvent) {
         Stage stage = (Stage) nombreArchivoDocumento.getScene().getWindow();
         stage.close();
    }

    public void clicBtnSeleccionarDocumento(ActionEvent actionEvent) {

    }

    public void btnCartaAceptacion(ActionEvent actionEvent) {
    }

    public void btnCronograma(ActionEvent actionEvent) {
    }

    public void btnOficioAsignacion(ActionEvent actionEvent) {
    }

    public void btnHorarioUV(ActionEvent actionEvent) {
    }

    public void btnConstanciaSeguro(ActionEvent actionEvent) {
    }

    public void btnReporteParcial(ActionEvent actionEvent) {
    }

    public void btnEvaluacionParcialOV(ActionEvent actionEvent) {
    }

    public void btnReporteFinal(ActionEvent actionEvent) {
    }

    public void btnAutoevaluacion(ActionEvent actionEvent) {
    }

    public void btnEvaluacionFinalOV(ActionEvent actionEvent) {
    }

    public void btnCartaLiberacion(ActionEvent actionEvent) {
    }

    public void seleccionarPDF(ActionEvent actionEvent) {
    }

    public void subirReporte(ActionEvent actionEvent) {
    }
}
