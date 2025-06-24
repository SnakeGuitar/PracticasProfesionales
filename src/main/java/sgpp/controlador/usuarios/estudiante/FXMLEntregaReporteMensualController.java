/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 16-06-2025
 * Descripción: Controlador para seleccionar/entregar PDF de reportes mensuales.
 */
package sgpp.controlador.usuarios.estudiante;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.stage.FileChooser;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.expediente.reporte.EntregaReporteMensual;
import sgpp.modelo.dao.entidades.PeriodoDAO;
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
import java.util.*;

public class FXMLEntregaReporteMensualController implements Initializable {

    @FXML private Label lblFechas1, lblFechas2, lblFechas3, lblFechas4;
    @FXML private Label lblEstado1, lblEstado2, lblEstado3, lblEstado4;
    @FXML private Button btnSubir1, btnSubir2, btnSubir3, btnSubir4;
    @FXML private Label lblArchivoSeleccionado;
    @FXML private TextField tfHoras;

    private Estudiante estudiante;

    private int idPeriodo;
    private final Map<Integer, EntregaReporteMensual> entregas = new HashMap<>();
    private File archivoSeleccionado;

    private static final DateTimeFormatter DF = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        idPeriodo = cargarPeriodo();
        // Aquí NO se llama cargarFechasReportes porque se necesita primero el estudiante
    }

    public void inicializarEstudiante(Estudiante estudiante) {
        this.estudiante = estudiante;
        cargarFechasReportes();
    }

    private int cargarPeriodo() {
        try {
            return PeriodoDAO.obtenerPeriodoActual().getIdPeriodo();
        } catch (SQLException e) {
            Utilidad.crearAlertaError("Error", "No se pudo obtener el periodo activo.");
            return 0;
        }
    }

    private void desactivarTodo() {
        btnSubir1.setDisable(true);
        btnSubir2.setDisable(true);
        btnSubir3.setDisable(true);
        btnSubir4.setDisable(true);
        lblEstado1.setText("Sin periodo activo");
        lblEstado2.setText("Sin periodo activo");
        lblEstado3.setText("Sin periodo activo");
        lblEstado4.setText("Sin periodo activo");
    }

    private void cargarFechasReportes() {
        if (estudiante == null || idPeriodo <= 0) {
            desactivarTodo();
            return;
        }

        for (int i = 1; i <= 4; i++) {
            EntregaReporteMensual entrega = EntregaReporteMensualDAO.obtenerEntregaPorEstudiante(i, idPeriodo, estudiante.getIdEstudiante());
            if (entrega == null) continue;

            entregas.put(i, entrega);

            Label lblFechas = switch (i) {
                case 1 -> lblFechas1;
                case 2 -> lblFechas2;
                case 3 -> lblFechas3;
                case 4 -> lblFechas4;
                default -> null;
            };

            Label lblEstado = switch (i) {
                case 1 -> lblEstado1;
                case 2 -> lblEstado2;
                case 3 -> lblEstado3;
                case 4 -> lblEstado4;
                default -> null;
            };

            Button btn = switch (i) {
                case 1 -> btnSubir1;
                case 2 -> btnSubir2;
                case 3 -> btnSubir3;
                case 4 -> btnSubir4;
                default -> null;
            };

            if (lblFechas != null && lblEstado != null && btn != null) {
                lblFechas.setText("Apertura: " + DF.format(entrega.getFechaApertura()) +
                        " | Límite: " + DF.format(entrega.getFechaLimite()));

                LocalDateTime ahora = LocalDateTime.now();
                if (ahora.isBefore(entrega.getFechaApertura())) {
                    lblEstado.setText("Estado: Pendiente");
                    btn.setDisable(true);
                } else if (ahora.isAfter(entrega.getFechaLimite())) {
                    lblEstado.setText("Estado: Cerrado");
                    btn.setDisable(true);
                } else {
                    try {
                        boolean entregado = ReporteMensualDAO.yaFueEntregado(entrega.getIdEntregaReporte());
                        if (entregado) {
                            lblEstado.setText("Estado: Entregado");
                            btn.setDisable(true);
                        } else {
                            lblEstado.setText("Estado: Abierto");
                            btn.setDisable(false);
                        }
                    } catch (SQLException e) {
                        lblEstado.setText("Estado: Error al consultar");
                        btn.setDisable(true);
                    }
                }
            }
        }
    }

    @FXML
    private void seleccionarPDF() {
        FileChooser fc = new FileChooser();
        fc.setTitle("Seleccionar archivo PDF");
        fc.getExtensionFilters().add(new FileChooser.ExtensionFilter("PDF", "*.pdf"));
        File f = fc.showOpenDialog(null);
        if (f != null) {
            archivoSeleccionado = f;
            lblArchivoSeleccionado.setText("Seleccionado: " + f.getName());
        } else {
            lblArchivoSeleccionado.setText("Ningún archivo seleccionado");
        }
    }

    @FXML private void subirReporte1() { subirReporte(1); }
    @FXML private void subirReporte2() { subirReporte(2); }
    @FXML private void subirReporte3() { subirReporte(3); }
    @FXML private void subirReporte4() { subirReporte(4); }

    private void subirReporte(int numReporte) {
        EntregaReporteMensual entrega = entregas.get(numReporte);
        if (entrega == null) {
            Utilidad.crearAlertaAdvertencia("Error", "No se encontró información del reporte.");
            return;
        }

        if (archivoSeleccionado == null) {
            Utilidad.crearAlertaAdvertencia("Sin archivo", "Selecciona un archivo PDF.");
            return;
        }

        int horas;
        try {
            horas = Integer.parseInt(tfHoras.getText().trim());
            if (horas < 1 || horas > 160) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            Utilidad.crearAlertaAdvertencia("Horas inválidas", "Escribe un número entre 1 y 160.");
            return;
        }

        try {
            byte[] pdf = Files.readAllBytes(archivoSeleccionado.toPath());

            boolean ok = ReporteMensualDAO.insertar(entrega.getIdEntregaReporte(), horas, pdf);
            if (ok) {
                EntregaReporteMensualDAO.marcarComoEntregado(entrega.getIdEntregaReporte());
                Utilidad.crearAlertaInformacion("Éxito", "Reporte subido correctamente.");
                archivoSeleccionado = null;
                tfHoras.clear();
                lblArchivoSeleccionado.setText("Ningún archivo seleccionado");
                cargarFechasReportes();
            } else {
                Utilidad.crearAlertaAdvertencia("Fallo", "No se pudo subir el reporte.");
            }

        } catch (IOException | SQLException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    @FXML
    private void clicBtnRegresar() {
        Utilidad.cerrarVentana(lblArchivoSeleccionado);
    }
}
