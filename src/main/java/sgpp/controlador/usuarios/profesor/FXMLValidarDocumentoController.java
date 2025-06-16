package sgpp.controlador.usuarios.profesor;

import javafx.fxml.Initializable;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;

public class FXMLValidarDocumentoController implements Initializable {

    @FXML
    private TableView<?> tablaEntregas;
    @FXML
    private TableColumn<?, ?> colID;
    @FXML
    private TableColumn<?, ?> colEstudiante;
    @FXML
    private TableColumn<?, ?> colReporte;
    @FXML
    private TableColumn<?, ?> colFechaEntrega;
    @FXML
    private TableColumn<?, ?> colEstado;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // Inicialización del controlador
    }

    @FXML
    private void actualizarLista(ActionEvent event) {
    }
}
