package sgpp.controlador.usuarios.coordinador;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import sgpp.dominio.EntregaDM;
import sgpp.dominio.ResultadoValidacion;
import sgpp.modelo.beans.Periodo;
import sgpp.modelo.beans.expediente.EntregaDocumento;
import sgpp.modelo.beans.expediente.documentofinal.EntregaDocumentoFinal;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;
import sgpp.modelo.beans.expediente.reporte.EntregaReporteMensual;
import sgpp.modelo.dao.ResultadoSQL;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.expediente.documentofinal.EntregaDocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentoinicial.EntregaDocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaDocumentoParcialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaReporteMensualDAO;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.net.URL;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ResourceBundle;

public class FXMLConfigurarEntregasController implements Initializable {
    @FXML
    private TextField txFiAperturaInicial;
    @FXML
    private Label lbErrorAperturaInicial;
    @FXML
    private TextField txFiLimiteInicial;
    @FXML
    private Label lbErrorLimiteInicial;
    @FXML
    private TextField txFiAperturaParcial;
    @FXML
    private Label lbErrorAperturaParcial;
    @FXML
    private TextField txFiLimiteParcial;
    @FXML
    private Label lbErrorLimiteParcial;
    @FXML
    private TextField txFiAperturaFinal;
    @FXML
    private Label lbErrorAperturaFinal;
    @FXML
    private TextField txFiLimiteFinal;
    @FXML
    private Label lbErrorLimiteFinal;
    @FXML
    private TextField txFiAperturaReporteUno;
    @FXML
    private Label lbErrorAperturaReporteUno;
    @FXML
    private TextField txFiLimiteReporteUno;
    @FXML
    private Label lbErrorLimiteReporteUno;
    @FXML
    private TextField txFiAperturaReporteDos;
    @FXML
    private Label lbErrorAperturaReporteDos;
    @FXML
    private TextField txFiLimiteReporteDos;
    @FXML
    private Label lbErrorLimiteReporteDos;
    @FXML
    private TextField txFiAperturaReporteTres;
    @FXML
    private Label lbErrorAperturaReporteTres;
    @FXML
    private TextField txFiLimiteReporteTres;
    @FXML
    private Label lbErrorLimiteReporteTres;
    @FXML
    private TextField txFiAperturaReporteCuatro;
    @FXML
    private Label lbErrorAperturaReporteCuatro;
    @FXML
    private TextField txFiLimiteReporteCuatro;
    @FXML
    private Label lbErrorLimiteReporteCuatro;

    private final int NUM_REPORTE_UNO = 1;
    private final int NUM_REPORTE_DOS = 2;
    private final int NUM_REPORTE_TRES = 3;
    private final int NUM_REPORTE_CUATRO = 4;
    private int idPeriodo;
    private EntregaDocumentoInicial entregaInicial;
    private EntregaDocumentoParcial entregaParcial;
    private EntregaDocumentoFinal entregaFinal;
    private EntregaReporteMensual entregaReporteUno;
    private EntregaReporteMensual entregaReporteDos;
    private EntregaReporteMensual entregaReporteTres;
    private EntregaReporteMensual entregaReporteCuatro;

    public void initialize(URL url, ResourceBundle rb) {
        recuperarEntregas();
        cargarEntregasEnCampos();
    }

    private void recuperarEntregas() {
        try {
            Periodo periodoActual = PeriodoDAO.obtenerPeriodoActual();
            idPeriodo = periodoActual.getIdPeriodo();
            entregaInicial = EntregaDocumentoInicialDAO.obtenerPrimeraEntregaPorPeriodo(idPeriodo);
            entregaParcial = EntregaDocumentoParcialDAO.obtenerPrimeraEntregaPorPeriodo(idPeriodo);
            entregaFinal = EntregaDocumentoFinalDAO.obtenerPrimeraEntregaPorPeriodo(idPeriodo);
            entregaReporteUno = EntregaReporteMensualDAO.
                    obtenerPrimeraEntregaPorPeriodo(1, idPeriodo);
            entregaReporteDos = EntregaReporteMensualDAO.
                    obtenerPrimeraEntregaPorPeriodo(2, idPeriodo);
            entregaReporteTres = EntregaReporteMensualDAO.
                    obtenerPrimeraEntregaPorPeriodo(3, idPeriodo);
            entregaReporteCuatro = EntregaReporteMensualDAO.
                    obtenerPrimeraEntregaPorPeriodo(4, idPeriodo);
            cargarEntregasEnCampos();
        } catch (SQLException sqlex) {
            System.out.println("Error: " + sqlex.getMessage());
            Utilidad.crearAlertaError("Error", "No se pudo cargar las entregas");
        }
    }

    private void cargarEntregasEnCampos() {
        if (entregaInicial != null) {
          txFiAperturaInicial.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaInicial.getFechaApertura()));
          txFiLimiteInicial.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaInicial.getFechaLimite()));
        }
        if (entregaParcial != null) {
            txFiAperturaParcial.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaParcial.getFechaApertura()));
            txFiLimiteParcial.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaParcial.getFechaLimite()));
        }
        if (entregaFinal != null) {
            txFiAperturaFinal.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaFinal.getFechaApertura()));
            txFiLimiteFinal.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaFinal.getFechaLimite()));
        }
        if (entregaReporteUno != null) {
            txFiAperturaReporteUno.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaReporteUno.getFechaApertura()));
            txFiLimiteReporteUno.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaReporteUno.getFechaLimite()));
        }
        if (entregaReporteDos != null) {
            txFiAperturaReporteDos.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaReporteDos.getFechaApertura()));
            txFiLimiteReporteDos.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaReporteDos.getFechaLimite()));
        }
        if (entregaReporteTres != null) {
            txFiAperturaReporteTres.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaReporteTres.getFechaApertura()));
            txFiLimiteReporteTres.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaReporteTres.getFechaLimite()));
        }
        if (entregaReporteCuatro != null) {
            txFiAperturaReporteCuatro.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaReporteCuatro.getFechaApertura()));
            txFiLimiteReporteCuatro.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaReporteCuatro.getFechaLimite()));
        }
    }

    public void clicBtnCancelar(ActionEvent actionEvent) {
        boolean confirmacion = Utilidad.crearAlertaConfirmacion(
                "¿Cancelar?",
                "Se perdera el progreso no guardado");
        if (confirmacion) {
            Utilidad.getEscenarioComponente(txFiAperturaFinal).close();
        }
    }

    public void clicBtnGuardar(ActionEvent actionEvent) {
        limpiarEtiquetas();
        //Primero se valida que todas las fechas ingresadas se pueden configurar
        boolean inicialExito = configurarEntregaInicial();
        System.out.println(inicialExito);
        if (!inicialExito) {
            return;
        }
        boolean parcialExito = configurarEntregaParcial();
        System.out.println(parcialExito);
        if (!parcialExito) {
            return;
        }
        boolean finalExito = configurarEntregaFinal();
        if (!finalExito) {
            return;
        }
        boolean reporteUnoExito = configurarEntregaReporteUno();
        if (!reporteUnoExito) {
            return;
        }
        boolean reporteDosExito = configurarEntregaReporteDos();
        if (!reporteDosExito) {
            return;
        }
        boolean reporteTresExito = configurarEntregaReporteTres();
        if (!reporteTresExito) {
            return;
        }
        boolean reporteCuatroExito = configurarEntregaReporteCuatro();
        if (!reporteCuatroExito) {
            return;
        }
        //Si todas fueron validas,
        programarEntregasIniciales();
        programarEntregasParciales();
        programarEntregasFinales();
        programarEntregasReportes();
    }

    private boolean configurarEntregaInicial() {
        EntregaDocumentoInicial candidata = (EntregaDocumentoInicial) validarEntrega(
                TipoEntrega.INICIAL, null, txFiAperturaInicial, lbErrorAperturaInicial, txFiLimiteInicial, lbErrorLimiteInicial);
        if (candidata != null) {
            this.entregaInicial = candidata;
            return true;
        } else {
            this.entregaInicial = null;
            return false;
        }
    }

    private void programarEntregasIniciales() {
        try {
            ResultadoSQL resultado = EntregaDocumentoInicialDAO.programarEntregas(entregaInicial, idPeriodo);
            if (!resultado.isError()) {
                Utilidad.crearAlertaInformacion("Exito", "Entregas iniciales programadas exitosamente");
            } else {
                Utilidad.crearAlertaError("Error",
                        "Lo sentimos, por el momento no fue posible configurar las entregas iniciales");
            }
        } catch (SQLException sqlex) {
            System.out.println("Error: " + sqlex.getMessage());
            Utilidad.crearAlertaError(
                    "Error",
                    sqlex.getMessage()
            );
        }
    }

    private boolean configurarEntregaParcial() {
        EntregaDocumentoParcial candidata = (EntregaDocumentoParcial) validarEntrega(
                TipoEntrega.PARCIAL, entregaInicial, txFiAperturaParcial, lbErrorAperturaParcial, txFiLimiteParcial, lbErrorLimiteParcial
        );
        if (candidata != null) {
            this.entregaParcial = candidata;
            return true;
        } else {
            this.entregaParcial = null;
            return false;
        }
    }

    private void programarEntregasParciales() {
        try {
            ResultadoSQL resultado = EntregaDocumentoParcialDAO.programarEntregas(entregaParcial, idPeriodo);
            if (!resultado.isError()) {
                Utilidad.crearAlertaInformacion("Exito", "Entregas parciales programadas exitosamente");
            } else {
                Utilidad.crearAlertaError(
                        "Error",
                        "Lo sentimos, por el momento no fue posible configurar las entregas parciales");
            }
        } catch (SQLException sqlex) {
            System.out.println("Error: " + sqlex.getMessage());
            Utilidad.crearAlertaError("Error", sqlex.getMessage());
        }
    }

    private boolean configurarEntregaFinal() {
        EntregaDocumentoFinal candidata = (EntregaDocumentoFinal) validarEntrega(
                TipoEntrega.FINAL, entregaParcial, txFiAperturaFinal, lbErrorAperturaFinal, txFiLimiteFinal, lbErrorLimiteFinal
        );
        if (candidata != null) {
            this.entregaFinal = candidata;
            return true;
        } else {
            this.entregaFinal = null;
            return false;
        }
    }

    private void programarEntregasFinales() {
        try {
            ResultadoSQL resultado = EntregaDocumentoFinalDAO.programarEntregas(entregaFinal, idPeriodo);
            if (!resultado.isError()) {
                Utilidad.crearAlertaInformacion("Exito", "Entregas finales programadas exitosamente");
            } else {
                Utilidad.crearAlertaError(
                        "Error",
                        "Lo sentimos, por el momento no fue posible configurar las entregas parciales");
            }
        } catch (SQLException sqlex) {
            System.out.println("Error: " + sqlex.getMessage());
            Utilidad.crearAlertaError("Error", sqlex.getMessage());
        }
    }

    private boolean configurarEntregaReporteUno() {
        EntregaReporteMensual candidato = validarEntregaReporte(
                NUM_REPORTE_UNO,null, txFiAperturaReporteUno, lbErrorAperturaReporteUno, txFiLimiteReporteUno, lbErrorLimiteReporteUno
        );
        if (candidato != null) {
            candidato.setNumReporte(NUM_REPORTE_UNO);
            this.entregaReporteUno = candidato;
            System.out.println("La entrega uno es valida");
            System.out.println("fecha de apertura "+entregaReporteUno.getFechaApertura());
            System.out.println("fecha limite "+entregaReporteUno.getFechaLimite());
            return true;
        } else {
            this.entregaReporteUno = null;
            return false;
        }
    }

    private boolean configurarEntregaReporteDos() {
        System.out.println(entregaReporteUno.getFechaLimite().toString());
        EntregaReporteMensual candidato = validarEntregaReporte(
                NUM_REPORTE_DOS, entregaReporteUno, txFiAperturaReporteDos, lbErrorAperturaReporteDos, txFiLimiteReporteDos, lbErrorLimiteReporteDos
        );
        if (candidato != null) {
            candidato.setNumReporte(NUM_REPORTE_DOS);
            this.entregaReporteDos = candidato;
            return true;
        } else {
            this.entregaReporteDos = null;
            return false;
        }
    }

    private boolean configurarEntregaReporteTres() {
        EntregaReporteMensual candidato = validarEntregaReporte(
                NUM_REPORTE_TRES, entregaReporteDos, txFiAperturaReporteTres, lbErrorAperturaReporteTres, txFiLimiteReporteTres, lbErrorLimiteReporteTres
        );
        if (candidato != null) {
            candidato.setNumReporte(NUM_REPORTE_TRES);
            this.entregaReporteTres = candidato;
            return true;
        } else {
            this.entregaReporteTres = null;
            return false;
        }
    }

    private boolean configurarEntregaReporteCuatro() {
        EntregaReporteMensual candidato = validarEntregaReporte(
                NUM_REPORTE_CUATRO, entregaReporteTres, txFiAperturaReporteCuatro, lbErrorAperturaReporteCuatro, txFiLimiteReporteCuatro, lbErrorLimiteReporteCuatro
        );
        if (candidato != null) {
            candidato.setNumReporte(NUM_REPORTE_CUATRO);
            this.entregaReporteCuatro = candidato;
            return true;
        } else {
            this.entregaReporteCuatro = null;
            return false;
        }
    }

    private void programarEntregasReportes() {
        try {
            ResultadoSQL resultado = new ResultadoSQL();
            resultado = EntregaReporteMensualDAO.programarEntregas(entregaReporteUno, idPeriodo);
            if (resultado.isError()) {
                Utilidad.crearAlertaError("Error", "Lo sentimos no se pudo programar la entrega del reporte uno");
            }
            resultado = EntregaReporteMensualDAO.programarEntregas(entregaReporteDos, idPeriodo);
            if (resultado.isError()) {
                Utilidad.crearAlertaError("Error", "Lo sentimos no se pudo programar la entrega del reporte dos");
            }
            resultado = EntregaReporteMensualDAO.programarEntregas(entregaReporteTres, idPeriodo);
            if (resultado.isError()) {
                Utilidad.crearAlertaError("Error", "Lo sentimos no se pudo programar la entrega del reporte tres");
            }
            resultado = EntregaReporteMensualDAO.programarEntregas(entregaReporteCuatro, idPeriodo);
            if (resultado.isError()) {
                Utilidad.crearAlertaError("Error", "Lo sentimos no se pudo programar la entrega del reporte cuatro");
            }
        } catch (SQLException sqlex) {
            System.out.println("Error: " + sqlex.getMessage());
            Utilidad.crearAlertaError("Error", sqlex.getMessage());
        }
    }

    private EntregaDocumento validarEntrega(TipoEntrega tipo, EntregaDocumento entregaPrevia, TextField txFiFechaApertura, Label errorApertura, TextField txFiFechaLimite, Label errorLimite) {
        ResultadoValidacion validacion = new ResultadoValidacion();
        EntregaDocumento candidata = null;
        boolean formatoValido = validarFormatoDeFechas(txFiFechaApertura, errorApertura, txFiFechaLimite, errorLimite);
        if (formatoValido) {
            candidata = construirEntregaCandidata(tipo);
            validacion = EntregaDM.esUnRangoCorrecto(candidata);
            if (!validacion.isValido()) {
                errorApertura.setText("*fecha invalida");
                Utilidad.crearAlerta(Alert.AlertType.WARNING, "Error", validacion.getMensaje());
                return null; //No fue valida, no proceder a la siguiente validacion
            }
            if (!tipo.equals(TipoEntrega.INICIAL)) {
                validacion = EntregaDM.validarRespectoAEntregaPrevia(entregaPrevia, candidata);
                if (!validacion.isValido()) {
                    errorApertura.setText("*fecha invalida");
                    Utilidad.crearAlerta(Alert.AlertType.WARNING, "Error", validacion.getMensaje());
                }
            }
        }
        return (validacion.isValido() ? candidata : null);
    }

    private EntregaReporteMensual validarEntregaReporte(int numReporte, EntregaReporteMensual entregaPrevia, TextField txFiFechaApertura, Label errorApertura, TextField txFiFechaLimite, Label errorLimite) {
        ResultadoValidacion validacion = new ResultadoValidacion();
        EntregaReporteMensual candidato = null;
        boolean formatoValido = validarFormatoDeFechas(txFiFechaApertura, errorApertura, txFiFechaLimite, errorLimite);
        if (formatoValido) {
            candidato = construirEntregaReporte(numReporte);
            validacion = EntregaDM.esUnRangoCorrecto(candidato);
            if (!validacion.isValido()) {
                errorApertura.setText("*fecha invalida");
                Utilidad.crearAlerta(Alert.AlertType.WARNING, "Error", validacion.getMensaje());
                return null; //No fue valida, no proceder a la siguiente validacion
            }
            if (candidato != null && entregaPrevia != null) {
                validacion = EntregaDM.validarRespectoAEntregaPrevia(entregaPrevia, candidato);
                if (!validacion.isValido()) {
                    errorApertura.setText("*fecha invalida");
                    Utilidad.crearAlerta(Alert.AlertType.WARNING, "Error", validacion.getMensaje());
                }
            }
        }
        return (validacion.isValido() ? candidato : null);
    }

    private boolean validarFormatoDeFechas(TextField txFiFechaApertura, Label errorApertura, TextField txFiFechaLimite, Label errorLimite) {
        boolean formatoValido = false;
        int numCamposLlenos = contarCamposLlenos(txFiFechaApertura, errorApertura, txFiFechaLimite, errorLimite);
        if (numCamposLlenos == 2) {
            formatoValido = validarFormatoDeCampos(txFiFechaApertura, errorApertura, txFiFechaLimite, errorLimite);
        }
        return (numCamposLlenos == 2 && formatoValido);
    }

    private boolean validarFormatoDeCampos(TextField txFiFechaApertura, Label errorApertura, TextField txFiFechaLimite, Label errorLimite) {
        boolean valido = false;
        int numCampo = 1;
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            LocalDateTime.parse(txFiFechaApertura.getText(), formatter);
            numCampo = 2;
            LocalDateTime.parse(txFiFechaLimite.getText(), formatter);
            valido = true;
        } catch (DateTimeParseException ex) {
            switch (numCampo) {
                case 1:
                    errorApertura.setText("*no es una fecha valida");
                    break;
                case 2:
                    errorLimite.setText("*no es una fecha valida");
            }
        }
        return valido;
    }

    private int contarCamposLlenos(TextField txFiFechaApertura, Label lbErrorApertura, TextField txFiFechaLimite, Label lbErrorLimite) {
        String textoApertura = txFiFechaApertura.getText();
        String textoLimite = txFiFechaLimite.getText();
        if(!textoApertura.isEmpty() && !textoLimite.isEmpty()) {
            return 2;
        } else {
            if(textoApertura.isEmpty() && textoLimite.isEmpty()) {
                lbErrorApertura.setText("¨*requerido");
                lbErrorLimite.setText("*requerido");
                return 0;
            }
            if (textoApertura.isEmpty()) {
                lbErrorApertura.setText("¨*requerido");
            } else {
                lbErrorLimite.setText("*requerido");
            }
            return 1;
        }
    }

    private EntregaDocumento construirEntregaCandidata(TipoEntrega tipo) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        switch (tipo) {
            case INICIAL:
                EntregaDocumentoInicial candidataInicial = new EntregaDocumentoInicial();
                candidataInicial.setFechaApertura(LocalDateTime.parse(txFiAperturaInicial.getText(), formatter));
                candidataInicial.setFechaLimite(LocalDateTime.parse(txFiLimiteInicial.getText(), formatter));
                return candidataInicial;
            case PARCIAL:
                EntregaDocumentoParcial candidataParcial = new EntregaDocumentoParcial();
                candidataParcial.setFechaApertura(LocalDateTime.parse(txFiAperturaParcial.getText(), formatter));
                candidataParcial.setFechaLimite(LocalDateTime.parse(txFiLimiteParcial.getText(), formatter));
                return candidataParcial;
            case FINAL:
                EntregaDocumentoFinal candidataFinal = new EntregaDocumentoFinal();
                candidataFinal.setFechaApertura(LocalDateTime.parse(txFiAperturaFinal.getText(), formatter));
                candidataFinal.setFechaLimite(LocalDateTime.parse(txFiLimiteFinal.getText(), formatter));
                return candidataFinal;
            default:
                return null;
        }
    }

    private EntregaReporteMensual construirEntregaReporte(int numReporte) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        EntregaReporteMensual entrega = null;
        switch (numReporte) {
            case 1:
                entrega = new EntregaReporteMensual();
                entrega.setFechaApertura(LocalDateTime.parse(txFiAperturaReporteUno.getText(), formatter));
                entrega.setFechaLimite(LocalDateTime.parse(txFiLimiteReporteUno.getText(), formatter));
                return entrega;
            case 2:
                entrega = new EntregaReporteMensual();
                entrega.setFechaApertura(LocalDateTime.parse(txFiAperturaReporteDos.getText(), formatter));
                entrega.setFechaLimite(LocalDateTime.parse(txFiLimiteReporteDos.getText(), formatter));
                return entrega;
            case 3:
                entrega = new EntregaReporteMensual();
                entrega.setFechaApertura(LocalDateTime.parse(txFiAperturaReporteTres.getText(), formatter));
                entrega.setFechaLimite(LocalDateTime.parse(txFiLimiteReporteTres.getText(), formatter));
                return entrega;
            case 4:
                entrega = new EntregaReporteMensual();
                entrega.setFechaApertura(LocalDateTime.parse(txFiAperturaReporteCuatro.getText(), formatter));
                entrega.setFechaLimite(LocalDateTime.parse(txFiLimiteReporteCuatro.getText(), formatter));
                return entrega;
            default:
                return null;
        }
    }

    private enum TipoEntrega {
        INICIAL,
        PARCIAL,
        FINAL
    }

    private void limpiarEtiquetas() {
        lbErrorAperturaInicial.setText("");
        lbErrorLimiteInicial.setText("");
        lbErrorAperturaParcial.setText("");
        lbErrorLimiteParcial.setText("");
        lbErrorAperturaFinal.setText("");
        lbErrorLimiteFinal.setText("");
        lbErrorAperturaReporteUno.setText("");
        lbErrorLimiteReporteUno.setText("");
        lbErrorAperturaReporteDos.setText("");
        lbErrorLimiteReporteDos.setText("");
        lbErrorAperturaReporteTres.setText("");
        lbErrorLimiteReporteTres.setText("");
        lbErrorAperturaReporteCuatro.setText("");
        lbErrorLimiteReporteCuatro.setText("");
    }
}