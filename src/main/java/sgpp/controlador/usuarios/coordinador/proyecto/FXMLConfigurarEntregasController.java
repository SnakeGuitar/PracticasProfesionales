package sgpp.controlador.usuarios.coordinador.proyecto;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TextField;
import sgpp.modelo.beans.Periodo;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.util.ResourceBundle;

public class FXMLConfigurarEntregasController implements Initializable {
    @FXML
    private TextField txFiAperturaInicial;
    @FXML
    private TextField txFiLimiteInicial;
    @FXML
    private TextField txFiAperturaParcial;
    @FXML
    private TextField txFiLimiteParcial;
    @FXML
    private TextField txFiAperturaFinal;
    @FXML
    private TextField txFiLimiteFinal;
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

    private Periodo periodActual;
    private EntregaDocumentoInicial entregasIniciales;
    private EntregaDocumentoParcial entregasParciales;

    public void initialize(URL url, ResourceBundle rb) {
        cargarEntregas();
    }

    private void cargarEntregas() {

    }

    public void clicBtnCancelar(ActionEvent actionEvent) {
        Utilidad.getEscenarioComponente(txFiAperturaFinal).close();
    }

    public void clicBtnGuardar(ActionEvent actionEvent) {

    }
}
