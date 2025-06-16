package sgpp.controlador.usuarios.coordinador;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import sgpp.modelo.beans.Periodo;
import sgpp.modelo.beans.expediente.documentofinal.EntregaDocumentoFinal;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.expediente.documentofinal.EntregaDocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentoinicial.EntregaDocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaDocumentoParcialDAO;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.net.URL;
import java.sql.SQLException;
import java.time.LocalDateTime;
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
    private List<EntregaDocumentoInicial> entregasIniciales;
    private EntregaDocumentoInicial entregaInicial;
    private List<EntregaDocumentoParcial> entregasParciales;
    private EntregaDocumentoParcial entregaParcial;
    private List<EntregaDocumentoFinal> entregasFinales;
    private EntregaDocumentoFinal entregaFinal;

    public void initialize(URL url, ResourceBundle rb) {
        recuperarEntregas();
        cargarEntregasEnCampos();
    }

    private void recuperarEntregas() {
        try {
            periodoActual = PeriodoDAO.obtenerPeriodoActual();
            entregasIniciales = EntregaDocumentoInicialDAO.obtenerEntregasPorPeriodo(periodoActual.getIdPeriodo());
            entregasParciales = EntregaDocumentoParcialDAO.obtenerEntregasPorPeriodo(periodoActual.getIdPeriodo());
            entregasFinales = EntregaDocumentoFinalDAO.obtenerEntregasPorPeriodo(periodoActual.getIdPeriodo());
            cargarEntregasIndividuales();
            cargarEntregasEnCampos();
        } catch (SQLException sqlex) {
            System.out.println("Error: " + sqlex.getMessage());
            Utilidad.crearAlerta(Alert.AlertType.ERROR, "Error", "No se pudo cargar las entregas");
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
        configurarEntregasIniciales();
    }

    private void configurarEntregasIniciales() {
        int numCamposLlenos = validarCamposVacios(txFiAperturaInicial, lbErrorAperturaInicial, txFiLimiteInicial, lbErrorLimiteInicial);
        if (numCamposLlenos == 2) {
            boolean formatoValido = validarFormatoDeCampos(txFiAperturaInicial, lbErrorAperturaInicial, txFiLimiteInicial, lbErrorLimiteInicial);
            if (formatoValido) {
                EntregaDocumentoInicial candidata = construirEntregaInicialCandidata();

            }
        }
    }

    //Para este CU, que los campos estan vacios es valido, pero solo si ambos estan vacios
    // 0-> Ambos vacios
    // 1 -> Al menos uno tiene datos
    // 2 -> Ambos tienen datos
    private int validarCamposVacios(TextField txFiFechaApertura, Label lbErrorApertura, TextField txFiFechaLimite, Label lbErrorLimite) {
        String textoApertura = txFiFechaApertura.getText();
        String textoLimite = txFiFechaLimite.getText();
        if(!textoApertura.isEmpty() && !textoLimite.isEmpty()) {
            return 2;
        } else {
            if(textoApertura.isEmpty() && textoLimite.isEmpty()) {
                return 0;
            }
            if (textoApertura.isEmpty()) {
                lbErrorApertura.setText("¨*requerido");
                return 1;
            } else {
                lbErrorLimite.setText("*requerido");
                return 1;
            }
        }
    }

    //Considera que esten vacios como un formato valido
    private boolean validarFormatoDeCampos(TextField txFiFechaApertura, Label errorApertura, TextField txFiFechaLimite, Label errorLimite) {
        boolean valido = false;
        int numCampo = 1;
        try {
            LocalDateTime.parse(txFiFechaApertura.getText());
            numCampo = 2;
            LocalDateTime.parse(txFiFechaLimite.getText());
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

    private EntregaDocumentoInicial construirEntregaInicialCandidata() {
        return null;
    }
}
