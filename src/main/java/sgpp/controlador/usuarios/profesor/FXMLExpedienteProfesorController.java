package sgpp.controlador.usuarios.profesor;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.cell.PropertyValueFactory;
import sgpp.modelo.beans.expediente.Documento;

import java.net.URL;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class FXMLExpedienteProfesorController implements Initializable {
    @FXML
    public Button btnRegresar;

    @FXML
    public ListView listDocumentosExpediente;

    @FXML
    public Label lbNombreEstudiante;

    @FXML
    public Label lbHorasAcumuladas;

    @FXML
    public Button btnBorrar;

    @FXML
    public Button btnActualizar;

    @FXML
    public Button btnDescargar;

    // private ObservableList<Documento> documentos;

    @Override
    public void initialize(URL url, ResourceBundle rb) {

    }

    private void configurarLista() {
        // TODO
    }

    private void cargarInformacion() {
        // TODO
    }

    public void btnClicRegresar(ActionEvent actionEvent) {
    }

    public void btnClicBorrar(ActionEvent actionEvent) {
    }

    public void btnClicActualizar(ActionEvent actionEvent) {
    }

    public void btnClicDescargar(ActionEvent actionEvent) {
    }
}
