package sgpp.controlador.usuarios.coordinador.proyecto;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.beans.ResponsableTecnico;

public class FXMLFormularioProyectoController {
    @FXML
    private TextField txFiNombre;
    @FXML
    private TextField txFiObjetivo;
    @FXML
    private TextField txFiMetodologia;
    @FXML
    private TextField txFiMaxParticipantes;
    @FXML
    private ComboBox<OrganizacionVinculada> comboOV;
    @FXML
    private ComboBox<ResponsableTecnico> comboResponsable;
    @FXML
    private DatePicker datePkFechaInicio;
    @FXML
    private DatePicker datePkFechaFin;
    @FXML
    private Label lbErrorNombre;
    @FXML
    private Label lbErrorObjetivo;
    @FXML
    private Label lbErrorMetodologia;
    @FXML
    private Label lbErrorMaxParticipantes;
    @FXML
    private Label lbErrorOV;
    @FXML
    private Label lbErrorResponsable;
    @FXML
    private Label lbErrorFechaInicio;
    @FXML
    private Label lbErrorFechaFIn;

    public void clicBtnCancelar(ActionEvent actionEvent) {
    }

    public void clicBtnGuardar(ActionEvent actionEvent) {
    }
}
