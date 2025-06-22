package sgpp.controlador.usuarios;

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
import sgpp.modelo.dao.expediente.ExpedienteDAO;
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

public class FXMLExpedienteEstudianteController implements Initializable {
    @FXML
    public Button btnRegresar;
    @FXML
    public ListView<Documento> listDocumentosExpediente;
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

    }

    public void inicializarInformacion(Estudiante estudiante, int idPeriodo) {
        this.idEstudiante = estudiante.getIdEstudiante();
        this.idPeriodo = idPeriodo;
        lbNombreEstudiante.setText(estudiante.getNombre());
        int horasAcumuladas = 0;
        try {
             horasAcumuladas = ExpedienteDAO.obtenerPorId(idEstudiante, idPeriodo).getHorasAcumuladas();
        } catch (SQLException sqlex) {
            Utilidad.crearAlertaAdvertencia(
                    "Notificación",
                    "Lo sentimos, no fue posible recuperar las horas acumuladas del estudiante");
        }
        lbHorasAcumuladas.setText(String.valueOf(horasAcumuladas));

        cargarIdsEntrega();
        cargarInformacion();
    }

    private void cargarIdsEntrega() {
        try {
            EntregaDocumentoInicial entregaInicial = EntregaDocumentoInicialDAO.obtenerEntregaDisponible(
                    idEstudiante, idPeriodo);
            EntregaDocumentoParcial entregaParcial = EntregaDocumentoParcialDAO.obtenerEntregaDisponible(
                    idEstudiante, idPeriodo);
            EntregaDocumentoFinal entregaFinal = EntregaDocumentoFinalDAO.obtenerEntregaDisponible(
                    idEstudiante, idPeriodo);
            if (entregaInicial != null) {
                idEntregaDocInicial = entregaInicial.getIdEntregaDocumentoInicial();
            }
            if (entregaParcial != null) {
                idEntregaDocParcial = entregaParcial.getIdEntregaDocumentoParcial();
            }
            if (entregaFinal != null) {
                idEntregaDocFinal = entregaFinal.getIdEntregaDocumentoFinal();
            }
        } catch (SQLException e) {
            Utilidad.crearAlertaError("Error", "Lo sentimos, no hay entregas programadas para este estudiante");
        }
    }

    private void cargarInformacion() {
        System.out.println("#cargando informacion#");
        System.out.println(idEstudiante);
        System.out.println(idPeriodo);
        System.out.println(idEntregaDocInicial);
        System.out.println(idEntregaDocParcial);
        System.out.println(idEntregaDocFinal);
        documentos = FXCollections.observableArrayList();

        ArrayList<Documento> documentosDAO = new ArrayList<>();
        try {
            documentosDAO.addAll(DocumentoInicialDAO.obtenerDocumentosInicialesPorExpediente(idEntregaDocInicial));
            documentosDAO.addAll(DocumentoParcialDAO.obtenerDocumentosParcialesPorExpediente(idEntregaDocParcial));
            documentosDAO.addAll(DocumentoFinalDAO.obtenerDocumentosFinalesPorExpediente(idEntregaDocFinal));
        } catch (SQLException sqlex) {
            Utilidad.crearAlertaAdvertencia(
                    "Notificación",
                    "Lo sentimos, no fue posible recuperar algunos de los documentos del estudiante");
        }
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
