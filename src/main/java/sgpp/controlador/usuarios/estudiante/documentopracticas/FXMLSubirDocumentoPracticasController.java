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
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.stage.Stage;

public class FXMLSubirDocumentoPracticasController implements javafx.fxml.Initializable {

    public TextArea txArDescripcionEntrega;
    public Label nombreArchivoDocumento;

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
}
