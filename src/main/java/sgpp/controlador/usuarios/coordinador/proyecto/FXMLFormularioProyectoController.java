/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 14-06-2025
 * Fecha de la última versión aprobada:S/F
 * Fecha de la última modificación: 14-06-2025 10:03
 * Descripción: Controlador para el formulario utlizado en los CU01 y CU02
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.coordinador.proyecto;

import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.beans.ResponsableTecnico;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.sql.SQLException;
import java.util.List;
import java.util.ResourceBundle;

public class FXMLFormularioProyectoController implements Initializable {
    @FXML
    private TextField txFiNombre;
    @FXML
    private TextField txFiObjetivo;
    @FXML
    private TextField txFiMetodologia;
    @FXML
    private TextField txFiMaxParticipantes;
    @FXML
    private ComboBox<OrganizacionVinculada> comboOV;
    @FXML
    private ComboBox<ResponsableTecnico> comboResponsable;
    @FXML
    private DatePicker datePkFechaInicio;
    @FXML
    private DatePicker datePkFechaFin;
    @FXML
    private Label lbErrorNombre;
    @FXML
    private Label lbErrorObjetivo;
    @FXML
    private Label lbErrorMetodologia;
    @FXML
    private Label lbErrorMaxParticipantes;
    @FXML
    private Label lbErrorOV;
    @FXML
    private Label lbErrorResponsable;
    @FXML
    private Label lbErrorFechaInicio;
    @FXML
    private Label lbErrorFechaFIn;

    private ObservableList<OrganizacionVinculada> organizaciones;
    private ObservableList<ResponsableTecnico> responsables;

    private Proyecto proyectoEdicion;
    private boolean esEdicion;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarOrganizaciones();
        seleccionarResponsables();
    }

    public void inicializarInformacion(boolean esEdicion, Proyecto proyectoEdicion) {
        this.proyectoEdicion = proyectoEdicion;
        this.esEdicion = esEdicion;
        if (esEdicion) {
            cargarInformacionEdicion();
        }
    }

    private void cargarOrganizaciones() {
        organizaciones = FXCollections.observableArrayList();
        try {
            List<OrganizacionVinculada> organizacionesAux = OrganizacionVinculadaDAO.obtenerOrganizacionesVinculadas();
            organizacionesAux.addAll(organizaciones);
            comboOV.setItems(FXCollections.observableArrayList(organizacionesAux));
        } catch (SQLException sqlex) {
            Utilidad.crearAlerta(
                    Alert.AlertType.ERROR,
                    "Error inesperado",
                    "Lo sentimos, por el momento no se pudieron recuperar las organizaciones vinculadas");
            cerrarVentana();
        }
    }

    private void cargarResponsables() {
        responsables = FXCollections.observableArrayList();
        /*
        try {
            //WAIT
            List<ResponsableTecnico> responsablesAux = ResponsableTecnicoDAO.obtenerResponsables();
            responsables.addAll(responsablesAux);
            comboResponsable.setItems(responsables);
        } catch (SQLException sqlex) {
            Utilidad.crearAlerta(
                    Alert.AlertType.ERROR,
                    "Error inesperado",
                    "Lo sentimos, por el momento no se pudieron recuperar los responsables técnicos"
            );
            cerrarVentana();
        }
         */
    }

    //Metodo listener para actualizar los responsables disponibles para seleccion
    private void seleccionarResponsables() {
        comboOV.valueProperty().addListener(new ChangeListener<OrganizacionVinculada>() {
            @Override
            public void changed(ObservableValue<? extends OrganizacionVinculada> observable, OrganizacionVinculada oldValue, OrganizacionVinculada newValue) {
                if (newValue != null) {
                    cargarResponsables();
                }
            }
        });
    }

    private void cargarInformacionEdicion() {
        if(proyectoEdicion != null) {
            txFiNombre.setText(proyectoEdicion.getNombre());
            txFiObjetivo.setText(proyectoEdicion.getObjetivoGeneral());
            txFiMetodologia.setText(proyectoEdicion.getMetodologia());
            txFiMaxParticipantes.setText(String.valueOf(proyectoEdicion.getNumeroMaximoParticipantes()));
            comboOV.getSelectionModel().select(proyectoEdicion.getIdOrganizacionVinculada());
            comboResponsable.getSelectionModel().select(proyectoEdicion.getIdResponsable());
        }
    }

    public void clicBtnCancelar(ActionEvent actionEvent) {
        boolean cancelar = Utilidad.crearAlertaConfirmacion(
                "¿Cancelar?",
                "Se perderá el progreso no guardado"
        );
        if (cancelar) {
            cerrarVentana();
        }
    }

    public void clicBtnGuardar(ActionEvent actionEvent) {

    }

    private void cerrarVentana() {
        Utilidad.getEscenarioComponente(txFiNombre).close();
    }
}
