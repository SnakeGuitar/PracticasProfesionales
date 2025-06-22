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
import javafx.scene.input.MouseEvent;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
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

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
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

    private Estudiante estudiante;
    private int idEstudiante;
    private int idPeriodo;
    private int idEntregaDocInicial;
    private int idEntregaDocParcial;
    private int idEntregaDocFinal;

    @Override
    public void initialize(URL url, ResourceBundle rb) {

    }

    public void inicializarInformacion(Estudiante estudiante, int idPeriodo) {
        this.estudiante = estudiante;
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

    public void clicListDocumentos(MouseEvent mouseEvent) {
        if (listDocumentosExpediente.getSelectionModel().getSelectedItem() != null) {
            btnDescargar.setDisable(false);
        }
    }

    public void btnClicDescargar(ActionEvent actionEvent) {
        Documento documento = listDocumentosExpediente.getSelectionModel().getSelectedItem();
        if (documento != null) {
            if (documento.getDocumento() != null) {
                descargarArchivo(documento);
            } else {
                Utilidad.crearAlertaAdvertencia(
                        "Error",
                        "No se pudo descargar este archivo por que no tiene contenido"
                );
            }
        } else {
            Utilidad.crearAlertaInformacion(
                    "Accion Requerida",
                    "Primero seleccione un documento");
        }
    }

    private void descargarArchivo(Documento documento) {
        try {
            FileChooser fileChooser = new FileChooser();
            fileChooser.setTitle("Descargar documento");

            //Generar un nombre apropiado
            String nombreSugerido = String.format(
                    "%s_%s.pdf",
                    documento.toString().replace(" ", "_"),
                    estudiante.getNombre().replace(" ", "_"));
            //Configurar el filechooser
            fileChooser.setInitialFileName(nombreSugerido);
            fileChooser.getExtensionFilters().add(
                    new FileChooser.ExtensionFilter("Documento PDF", "*.pdf"));

            Stage stage = Utilidad.getEscenarioComponente(lbNombreEstudiante);
            File destino = fileChooser.showSaveDialog(stage);

            //Guardar el archivo en el destino
            try (FileOutputStream fos = new FileOutputStream(destino)) {
                fos.write(documento.getDocumento());
            }
            Utilidad.crearAlertaInformacion(
                    "Exito",
                    "Documento descargado exitosamente a: \n"+destino.getAbsolutePath()
            );
        } catch (IOException ioex) {
            Utilidad.crearAlertaError(
                    "Error",
                    "Lo sentimos, no fue posible descargar el documento, intentelo más  tarde");
        }
    }
}
