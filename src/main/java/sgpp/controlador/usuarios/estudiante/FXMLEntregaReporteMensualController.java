/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 16-06-2025
 * Descripción: Controlador para seleccionar/entregar PDF de reportes mensuales.
 */

package sgpp.controlador.usuarios.estudiante;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.stage.FileChooser;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaReporteMensual;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaReporteMensualDAO;
import sgpp.modelo.dao.expediente.documentoparcial.ReporteMensualDAO;
import sgpp.utilidad.Utilidad;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ResourceBundle;

public class FXMLEntregaReporteMensualController implements Initializable {

    @FXML private Button btnReporte1, btnReporte2, btnReporte3, btnReporte4;
    @FXML private Label  lblFechas, lblArchivoSeleccionado;
    @FXML private TextField tfHoras;

    private final int ID_ESTUDIANTE = 4;
    private final int ID_PERIODO    = 4;
    private EntregaReporteMensual entregaSeleccionada;
    private File archivoSeleccionado;

    private static final DateTimeFormatter DF =
            DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        lblFechas.setText("Selecciona un reporte para ver su apertura y límite de entrega");
    }

    @FXML private void btnReporte1(ActionEvent e){ manejarEntrega(1); }
    @FXML private void btnReporte2(ActionEvent e){ manejarEntrega(2); }
    @FXML private void btnReporte3(ActionEvent e){ manejarEntrega(3); }
    @FXML private void btnReporte4(ActionEvent e){ manejarEntrega(4); }

    @FXML
    private void seleccionarPDF(ActionEvent e){
        FileChooser fc = new FileChooser();
        fc.setTitle("Seleccionar archivo PDF");
        fc.getExtensionFilters().add(new FileChooser.ExtensionFilter("PDF","*.pdf"));
        File f = fc.showOpenDialog(null);
        if(f!=null){
            archivoSeleccionado = f;
            lblArchivoSeleccionado.setText("Seleccionado: "+f.getName());
        }else{
            lblArchivoSeleccionado.setText("Ningún archivo seleccionado");
        }
    }

    @FXML
    private void subirReporte(ActionEvent e) throws SQLException {
        if(entregaSeleccionada == null){
            Utilidad.crearAlertaAdvertencia("Sin entrega", "Primero selecciona un reporte abierto.");
            return;
        }

        if(archivoSeleccionado == null){
            Utilidad.crearAlertaAdvertencia("Sin archivo", "Selecciona un archivo PDF.");
            return;
        }

        if(ReporteMensualDAO.yaFueEntregado(entregaSeleccionada.getIdEntregaReporte())){
            Utilidad.crearAlertaAdvertencia("Ya entregado", "Ya has entregado este reporte.");
            return;
        }

        int horas;
        try {
            horas = Integer.parseInt(tfHoras.getText().trim());
            if(horas < 1 || horas > 160) throw new NumberFormatException();
        } catch(NumberFormatException ex) {
            Utilidad.crearAlertaAdvertencia("Horas inválidas", "Escribe un número entre 1 y 160.");
            return;
        }

        try {
            byte[] pdf = Files.readAllBytes(archivoSeleccionado.toPath());

            boolean ok = ReporteMensualDAO.insertar(entregaSeleccionada.getIdEntregaReporte(), horas, pdf);

            if(ok){
                // Actualizar fecha_entrega
                EntregaReporteMensualDAO.marcarComoEntregado(entregaSeleccionada.getIdEntregaReporte());

                Utilidad.crearAlertaInformacion("Éxito", "Reporte subido correctamente.");
                archivoSeleccionado = null;
                tfHoras.clear();
                lblArchivoSeleccionado.setText("Ningún archivo seleccionado");
            } else {
                Utilidad.crearAlertaAdvertencia("Fallo", "No se pudo subir el reporte.");
            }

        } catch(IOException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    private void manejarEntrega(int num){
        EntregaReporteMensual er =
                EntregaReporteMensualDAO.obtenerEntrega(num, ID_PERIODO);
        if(er == null){
            Utilidad.crearAlertaAdvertencia("Sin datos",
                    "No se encontró información para el reporte #"+num);
            return;
        }

        entregaSeleccionada = er;
        lblFechas.setText("Apertura: "+DF.format(er.getFechaApertura())
                +"  |  Límite: "+DF.format(er.getFechaLimite()));

        LocalDateTime ahora = LocalDateTime.now();

        if(ahora.isBefore(er.getFechaApertura())){
            Utilidad.crearAlertaAdvertencia("Pendiente", "La entrega aún no abre.");
            entregaSeleccionada = null;
        } else if(ahora.isAfter(er.getFechaLimite())){
            Utilidad.crearAlertaAdvertencia("Cerrada", "La entrega ya cerró.");
            entregaSeleccionada = null;
        } else {
            Utilidad.crearAlertaInformacion("Abierta", "Puedes subir tu reporte.");
        }
    }

    @FXML
    private void btnRegresar(ActionEvent event) {
    }
}
