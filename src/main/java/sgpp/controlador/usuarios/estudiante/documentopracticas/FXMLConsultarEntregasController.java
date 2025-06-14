/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 13-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 13-06-2025
 * Descripción: Clase controller para consultar entregas de documentos de prácticas
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.estudiante.documentopracticas;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;

public class FXMLConsultarEntregasController implements javafx.fxml.Initializable {

    @FXML
    private ListView listViewEntregas;
    @FXML
    private Label lblDocumentoEntregar;
    @FXML
    private Label lbldescripcion;
    @FXML
    private Label lblFechaInicio;
    @FXML
    private Label lblFechaFin;

    @Override
    public void initialize(java.net.URL url, java.util.ResourceBundle rb) {
        // Inicialización de la vista para subir documentos de prácticas
    }

    public void clicBtnSubirDocumento(ActionEvent actionEvent) {
    }
}
