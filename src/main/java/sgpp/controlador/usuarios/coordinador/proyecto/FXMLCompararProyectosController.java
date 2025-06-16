/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada: 21:15
 * Fecha de la última modificación: 14-06-2025 20:32
 * Descripción: Clase para mostrar la tabla utilizada en el CU02, su resultado se obtiene mediante un getter
 */

/*
 * Estado: Terminado - Pruebas Superficiales realizadas
 * Modificaciones: cambiado el metodo de validarProyecto para que se muestren todos los mensajes de error
 */

package sgpp.controlador.usuarios.coordinador.proyecto;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.stage.Stage;
import sgpp.modelo.beans.Proyecto;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.util.ResourceBundle;

public class FXMLCompararProyectosController implements Initializable {
    @FXML
    private Label lbViejoNombre;
    @FXML
    private Label lbNuevoNombre;
    @FXML
    private Label lbViejoObjetivo;
    @FXML
    private Label lbNuevoObjetivo;
    @FXML
    private Label lbViejaMetodologia;
    @FXML
    private Label lbNuevaMetodologia;
    @FXML
    private Label lbViejoMaxParticipantes;
    @FXML
    private Label lbNuevoMaxParticipantes;
    @FXML
    private Label lbViejaOV;
    @FXML
    private Label lbNuevaOV;
    @FXML
    private Label lbViejoResponsable;
    @FXML
    private Label lbNuevoResponsable;
    @FXML
    private Label lbViejaFechaInicio;
    @FXML
    private Label lbNuevaFechaInicio;
    @FXML
    private Label lbViejaFechaFin;
    @FXML
    private Label lbNuevaFechaFin;

    private boolean confirmacion;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        this.confirmacion = false;
    }

    public void cargarDatos(Proyecto viejo, Proyecto nuevo) {
        configurarCierre();
        lbViejoNombre.setText(viejo.getNombre());
        lbNuevoNombre.setText(nuevo.getNombre());
        lbViejoObjetivo.setText(viejo.getObjetivoGeneral());
        lbNuevoObjetivo.setText(nuevo.getObjetivoGeneral());
        lbViejaMetodologia.setText(viejo.getMetodologia());
        lbNuevaMetodologia.setText(nuevo.getMetodologia());
        lbViejoMaxParticipantes.setText(String.valueOf(viejo.getNumeroMaximoParticipantes()));
        lbNuevoMaxParticipantes.setText(String.valueOf(nuevo.getNumeroMaximoParticipantes()));
        lbViejaOV.setText(viejo.getNombreOV());
        lbNuevaOV.setText(nuevo.getNombreOV());
        lbViejoResponsable.setText(viejo.getNombreResponsable());
        lbNuevoResponsable.setText(nuevo.getNombreResponsable());
        lbViejaFechaInicio.setText(viejo.getFechaInicio());
        lbNuevaFechaInicio.setText(nuevo.getFechaInicio());
        lbViejaFechaFin.setText(viejo.getFechaFin());
        lbNuevaFechaFin.setText(nuevo.getFechaFin());
    }

    private void configurarCierre() {
        Stage stage = Utilidad.getEscenarioComponente(lbNuevaFechaFin);
        stage.setOnCloseRequest(event -> {
            confirmacion = false;
        });
    }

    public boolean getConfirmacion() {
        return confirmacion;
    }

    @FXML
    private void clicBtnSi(ActionEvent actionEvent) {
        confirmacion = true;
        Utilidad.getEscenarioComponente(lbNuevaFechaFin).close();
    }

    @FXML
    private void clicBtnNo(ActionEvent actionEvent) {
        confirmacion = false;
        Utilidad.getEscenarioComponente(lbNuevaFechaFin).close();
    }
}