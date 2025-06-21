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
import sgpp.modelo.dao.ResultadoSQL;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.expediente.documentofinal.EntregaDocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentoinicial.EntregaDocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaDocumentoParcialDAO;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.net.URL;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
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
    private TextField txFiLimiteReporteUno;
    @FXML
    private TextField txFiAperturaReporteDos;
    @FXML
    private TextField txFiLimiteReporteDos;
    @FXML
    private TextField txFiAperturaReporteTres;
    @FXML
    private TextField txFiLimiteReporteTres;
    @FXML
    private TextField txFiAperturaReporteCuatro;
    @FXML
    private TextField txFiLimiteReporteCuatro;

    private Periodo periodoActual;
    private int idPeriodo;
    private List<EntregaDocumentoInicial> entregasIniciales;
    private EntregaDocumentoInicial entregaInicial;
    private List<EntregaDocumentoParcial> entregasParciales;
    private EntregaDocumentoParcial entregaParcial;
    private List<EntregaDocumentoFinal> entregasFinales;
    private EntregaDocumentoFinal entregaFinal;
    private boolean ignorarParciales;

    public void initialize(URL url, ResourceBundle rb) {
        recuperarEntregas();
        cargarEntregasEnCampos();
    }

    private void recuperarEntregas() {
        try {
            periodoActual = PeriodoDAO.obtenerPeriodoActual();
            idPeriodo = periodoActual.getIdPeriodo();
            entregasIniciales = EntregaDocumentoInicialDAO.obtenerEntregasPorPeriodo(idPeriodo);
            entregasParciales = EntregaDocumentoParcialDAO.obtenerEntregasPorPeriodo(idPeriodo);
            entregasFinales = EntregaDocumentoFinalDAO.obtenerEntregasPorPeriodo(idPeriodo);
            cargarEntregasIndividuales();
            cargarEntregasEnCampos();
        } catch (SQLException sqlex) {
            System.out.println("Error: " + sqlex.getMessage());
            Utilidad.crearAlertaError("Error", "No se pudo cargar las entregas");
        }
    }

    private void cargarEntregasIndividuales() {
        if (entregasIniciales != null && !entregasIniciales.isEmpty()) {
            entregaInicial = entregasIniciales.getFirst();
        }
        if (entregasParciales != null && !entregasParciales.isEmpty()) {
            entregaParcial = entregasParciales.getFirst();
        }
        if (entregasFinales != null && !entregasFinales.isEmpty()) {
            entregaFinal = entregasFinales.getFirst();
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
        programarEntregasIniciales();
        programarEntregasParciales();
        programarEntregasFinales();
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
                Utilidad.crearAlertaError("Error", "Lo sentimos, por el momento no fue posible configurar las entregas iniciales");
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
    }
}