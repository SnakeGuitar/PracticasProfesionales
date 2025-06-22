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
import sgpp.modelo.beans.expediente.documentofinal.EntregaDocumentoFinal;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;
import sgpp.modelo.dao.expediente.documentofinal.EntregaDocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentoinicial.DocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoinicial.EntregaDocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.DocumentoParcialDAO;
import sgpp.modelo.dao.expediente.documentofinal.DocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaDocumentoParcialDAO;
import sgpp.utilidad.Utilidad;

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
    public Button btnDescargar;

    private ObservableList<Documento> documentos;

    private int idEstudiante;
    private int idPeriodo;
    private int idEntregaDocInicial;
    private int idEntregaDocParcial;
    private int idEntregaDocFinal;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        try {
            cargarInformacion();
            cargarIdsEntrega();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void inicializarInformacion(int idEstudiante, int idPeriodo) {
        this.idEstudiante = idEstudiante;
        this.idPeriodo = idPeriodo;
    }

    private void cargarIdsEntrega() {
        try {
            System.out.println(idEstudiante);
            System.out.println(idPeriodo);
            EntregaDocumentoInicial entregaInicial = EntregaDocumentoInicialDAO.obtenerEntregaDisponible(
                    idEstudiante, idPeriodo);
            EntregaDocumentoParcial entregaParcial = EntregaDocumentoParcialDAO.obtenerEntregaDisponible(
                    idEstudiante, idPeriodo);
            EntregaDocumentoFinal entregaFinal = EntregaDocumentoFinalDAO.obtenerEntregaDisponible(
                    idEstudiante, idPeriodo);
        } catch (SQLException e) {
            Utilidad.crearAlertaError("Error", "Lo sentimos, no hay entregas programadas para este estudiante");
        }
    }

    private void cargarInformacion() throws SQLException {
        listDocumentosExpediente.setCellFactory(new PropertyValueFactory("tipo"));

        documentos = FXCollections.observableArrayList();

        ArrayList<Documento> documentosDAO = new ArrayList<>();
        documentosDAO.addAll(DocumentoInicialDAO.obtenerDocumentosInicialesPorExpediente(idEntregaDocInicial));
        documentosDAO.addAll(DocumentoParcialDAO.obtenerDocumentosParcialesPorExpediente(idEntregaDocParcial));
        documentosDAO.addAll(DocumentoFinalDAO.obtenerDocumentosFinalesPorExpediente(idEntregaDocFinal));

        documentos.addAll(documentosDAO);

        listDocumentosExpediente.setItems(documentos);
    }

    public void btnClicRegresar(ActionEvent actionEvent) {
        Utilidad.cerrarVentana(lbNombreEstudiante);
    }

    public void btnClicDescargar(ActionEvent actionEvent) {
        // TODO: Averiguar cómo descargar documentos
    }
}
