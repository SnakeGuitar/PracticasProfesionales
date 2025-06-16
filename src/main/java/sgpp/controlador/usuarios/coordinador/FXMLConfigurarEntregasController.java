package sgpp.controlador.usuarios.coordinador;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import sgpp.modelo.beans.Periodo;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.expediente.documentoinicial.EntregaDocumentoInicialDAO;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.net.URL;
import java.sql.SQLException;
import java.util.List;
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

    private Periodo periodoActual;
    private EntregaDocumentoInicial entregaInicial;
    private EntregaDocumentoParcial entregasParcial;

    public void initialize(URL url, ResourceBundle rb) {
        recuperarEntregas();
        cargarEntregasEnCampos();
    }

    private void recuperarEntregas() {
        try {
            periodoActual = PeriodoDAO.obtenerPeriodoActual();
            entregaInicial = EntregaDocumentoInicialDAO.obtenerEntregasPorPeriodo(periodoActual.getIdPeriodo()).getFirst();
            cargarEntregasEnCampos();
        } catch (SQLException sqlex) {
            System.out.println("Error: " + sqlex.getMessage());
            Utilidad.crearAlerta(Alert.AlertType.ERROR, "Error", "No se pudo cargar las entregas");
        }
    }

    private void cargarEntregasEnCampos() {
        if (entregaInicial != null) {
          txFiAperturaInicial.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaInicial.getFechaApertura()));
          txFiLimiteInicial.setText(UtilidadFormatoDeDatos.localDateTimeToString(entregaInicial.getFechaLimite()));
        }
    }



    public void clicBtnCancelar(ActionEvent actionEvent) {
        Utilidad.getEscenarioComponente(txFiAperturaFinal).close();
    }

    public void clicBtnGuardar(ActionEvent actionEvent) {

    }
}
