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
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.expediente.Documento;
import sgpp.modelo.dao.expediente.documentoinicial.DocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.DocumentoParcialDAO;
import sgpp.modelo.dao.expediente.documentofinal.DocumentoFinalDAO;

import java.net.URL;
import java.sql.SQLException;
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

    private ObservableList<Documento> documentos;

    private int idEstudiante, idPeriodo;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        try {
            cargarInformacion();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void inicializarInformacion(int idEstudiante, int idPeriodo) {
        this.idEstudiante = idEstudiante;
        this.idPeriodo = idPeriodo;
    }

    private void cargarInformacion() throws SQLException {
        documentos = FXCollections.observableArrayList();

        ArrayList<Documento> documentosDAO = new ArrayList<>();

        // TODO: Obtener y pasar ID de Estudiante y Periodo
        documentosDAO.addAll(DocumentoInicialDAO.obtenerDocumentosInicialesPorExpediente(idEstudiante, idPeriodo));
        documentosDAO.addAll(DocumentoParcialDAO.obtenerDocumentosParcialesPorExpediente(idEstudiante, idPeriodo));
        documentosDAO.addAll(DocumentoFinalDAO.obtenerDocumentosFinalesPorExpediente(idEstudiante, idPeriodo));

        documentos.addAll(documentosDAO);

        listDocumentosExpediente.setItems(documentos);
    }

    public void btnClicRegresar(ActionEvent actionEvent) {
        // TODO
    }

    public void btnClicBorrar(ActionEvent actionEvent) {
    }

    public void btnClicActualizar(ActionEvent actionEvent) {
    }

    public void btnClicDescargar(ActionEvent actionEvent) {
    }
}
