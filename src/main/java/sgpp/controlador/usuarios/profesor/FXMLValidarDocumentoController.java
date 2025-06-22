package sgpp.controlador.usuarios.profesor;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;

import java.net.URL;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

public class FXMLValidarDocumentoController implements Initializable {
    public TableView tblEntregas;
    public TableColumn colEstudiante;
    public TableColumn colDocumento;
    public TableColumn colFechaEntrega;
    public TableColumn colEstado;
    public Label lbNombreProfesor;

    private static final int ID_PERIODO = 4;
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    private ObservableList<EntregaDocumentoInicial> da = FXCollections.observableArrayList();
    private ObservableList<EntregaDocumentoParcial> datosDocumentosParciales = FXCollections.observableArrayList();
    private ObservableList<EntregaDocumentoInicial> datosDocumentosFinales = FXCollections.observableArrayList();
    private Map<Integer, String> mapa_estudiantes = new HashMap<>();


    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }

    public void clicBtnActualizarLista(ActionEvent actionEvent) {
    }

    public void clicBtnValidar(ActionEvent actionEvent) {
    }

    public void clicBtnRechazar(ActionEvent actionEvent) {
    }

    public void clicBtnCancelar(ActionEvent actionEvent) {
    }

    public void clicBtnVerIniciales(ActionEvent actionEvent) {
    }

    public void clicBtnVerParciales(ActionEvent actionEvent) {
    }

    public void clicBtnVerFinales(ActionEvent actionEvent) {
    }
}
