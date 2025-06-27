/*
 * Autor original: Diego Iván Enríquez Morales
 * Último autor: Abel Yong
 * Fecha de creación: 15-06-2025
 * Descripción: Controlador para seleccionar y descargar documentos del expediente de un estudiante.
 */

package sgpp.controlador.usuarios;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.input.MouseEvent;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.expediente.Documento;
import sgpp.modelo.beans.expediente.documentofinal.EntregaDocumentoFinal;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;
import sgpp.modelo.beans.expediente.reporte.EntregaReporteMensual;
import sgpp.modelo.beans.expediente.reporte.ReporteMensual;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.expediente.ExpedienteDAO;
import sgpp.modelo.dao.expediente.documentofinal.DocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentofinal.EntregaDocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentoinicial.DocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoinicial.EntregaDocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.DocumentoParcialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaDocumentoParcialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaReporteMensualDAO;
import sgpp.modelo.dao.expediente.documentoparcial.ReporteMensualDAO;
import sgpp.utilidad.Utilidad;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

public class FXMLExpedienteEstudianteController {
    private static final String RUTA_FXML_SELECCION_ESTUDIANTE = "/sgpp/vista/usuarios/profesor/FXMLSeleccionEstudiante.fxml";

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
    private int idEntregaReporteUno;
    private int idEntregaReporteDos;
    private int idEntregaReporteTres;
    private int idEntregaReporteCuatro;

    public void inicializarInformacion(Estudiante estudiante) throws SQLException {
        this.estudiante = estudiante;
        this.idEstudiante = estudiante.getIdEstudiante();
        this.idPeriodo = PeriodoDAO.obtenerPeriodoActual().getIdPeriodo();;

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
        final int NUM_REPORTE_UNO = 1;
        final int NUM_REPORTE_DOS = 2;
        final int NUM_REPORTE_TRES = 3;
        final int NUM_REPORTE_CUATRO = 4;

        try {
            EntregaDocumentoInicial entregaInicial = EntregaDocumentoInicialDAO.obtenerEntregaDisponible(
                    idEstudiante, idPeriodo);

            EntregaDocumentoParcial entregaParcial = EntregaDocumentoParcialDAO.obtenerEntregaDisponible(
                    idEstudiante, idPeriodo);

            EntregaDocumentoFinal entregaFinal = EntregaDocumentoFinalDAO.obtenerEntregaDisponible(
                    idEstudiante, idPeriodo);

            EntregaReporteMensual entregaReporteUno = EntregaReporteMensualDAO.obtenerEntregaReporteDisponible(
                    idEstudiante, idPeriodo, NUM_REPORTE_UNO
            );

            EntregaReporteMensual entregaReporteDos = EntregaReporteMensualDAO.obtenerEntregaReporteDisponible(
                    idEstudiante, idPeriodo, NUM_REPORTE_DOS
            );

            EntregaReporteMensual entregaReporteTres = EntregaReporteMensualDAO.obtenerEntregaReporteDisponible(
                    idEstudiante, idPeriodo, NUM_REPORTE_TRES
            );

            EntregaReporteMensual entregaReporteCuatro = EntregaReporteMensualDAO.obtenerEntregaReporteDisponible(
                    idEstudiante, idPeriodo, NUM_REPORTE_CUATRO
            );

            if (entregaInicial != null) {
                idEntregaDocInicial = entregaInicial.getIdEntregaDocumentoInicial();
            }

            if (entregaParcial != null) {
                idEntregaDocParcial = entregaParcial.getIdEntregaDocumentoParcial();
            }

            if (entregaFinal != null) {
                idEntregaDocFinal = entregaFinal.getIdEntregaDocumentoFinal();
            }

            if (entregaReporteUno != null) {
                idEntregaReporteUno = entregaReporteUno.getIdEntregaReporte();
            }

            if (entregaReporteDos != null) {
                idEntregaReporteDos = entregaReporteDos.getIdEntregaReporte();
            }

            if (entregaReporteTres != null) {
                idEntregaReporteTres = entregaReporteTres.getIdEntregaReporte();
            }

            if (entregaReporteCuatro != null) {
                idEntregaReporteCuatro = entregaReporteCuatro.getIdEntregaReporte();
            }
        } catch (SQLException e) {
            Utilidad.crearAlertaError("Error", "Lo sentimos, no hay entregas programadas para este estudiante");
        }
    }

    private void cargarInformacion() {
        documentos = FXCollections.observableArrayList();
        ArrayList<Documento> documentosDAO = new ArrayList<>();

        try {
            //Entregas generales
            documentosDAO.addAll(DocumentoInicialDAO.obtenerDocumentosInicialesPorExpediente(idEntregaDocInicial));
            documentosDAO.addAll(DocumentoParcialDAO.obtenerDocumentosParcialesPorExpediente(idEntregaDocParcial));
            documentosDAO.addAll(DocumentoFinalDAO.obtenerDocumentosFinalesPorExpediente(idEntregaDocFinal));

            //Reportes mensuales
            ReporteMensual reporteUno = ReporteMensualDAO.obtenerReportePorExpediente(idEntregaReporteUno);
            if (reporteUno != null) {
                documentosDAO.add(reporteUno);
            }

            ReporteMensual reporteDos = ReporteMensualDAO.obtenerReportePorExpediente(idEntregaReporteDos);
            if (reporteDos != null) {
                documentosDAO.add(reporteDos);
            }

            ReporteMensual reporteTres = ReporteMensualDAO.obtenerReportePorExpediente(idEntregaReporteTres);
            if (reporteTres != null) {
                documentosDAO.add(reporteTres);
            }

            ReporteMensual reporteCuatro = ReporteMensualDAO.obtenerReportePorExpediente(idEntregaReporteCuatro);
            if (reporteCuatro != null) {
                documentosDAO.add(reporteCuatro);
            }
        } catch (SQLException sqlex) {
            Utilidad.crearAlertaAdvertencia(
                    "Notificación",
                    "Lo sentimos, no fue posible recuperar algunos de los documentos del estudiante");
        }
        documentos.addAll(documentosDAO);

        listDocumentosExpediente.setItems(documentos);
    }

    public void clicBtnRegresar(ActionEvent actionEvent) {
        Utilidad.crearEscenarioSimple(RUTA_FXML_SELECCION_ESTUDIANTE, "Seleccionar Estudiante");
        Utilidad.cerrarVentana(btnRegresar);
    }

    //Requerido para que el boton descargar se habilite, no borrar
    public void clicListDocumentos(MouseEvent mouseEvent) {
        if (listDocumentosExpediente.getSelectionModel().getSelectedItem() != null) {
            btnDescargar.setDisable(false);
        }
    }

    public void clicBtnDescargar(ActionEvent actionEvent) {
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
                    documento.toString().replace(" ", "_").replace("-", ""),
                    estudiante.getNombre().replace(" ", "_"));
            //Configurar el filechooser
            fileChooser.setInitialFileName(nombreSugerido);
            fileChooser.getExtensionFilters().add(
                    new FileChooser.ExtensionFilter("Documento PDF", "*.pdf"));

            Stage stage = Utilidad.getEscenarioComponente(lbNombreEstudiante);
            File destino = fileChooser.showSaveDialog(stage);

            //Proceder si se selecciono una ubicacion
            if (destino != null) {
                //Guardar el archivo en el destino
                try (FileOutputStream fos = new FileOutputStream(destino)) {
                    fos.write(documento.getDocumento());
                }
                Utilidad.crearAlertaInformacion(
                        "Exito",
                        "Documento descargado exitosamente a: \n"+destino.getAbsolutePath()
                );
            }
        } catch (IOException ioex) {
            Utilidad.crearAlertaError(
                    "Error de descarga",
                    "No fue posible descargar el documento. Inténtelo más  tarde.");
        }
    }
}
