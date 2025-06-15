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
import sgpp.dominio.ProyectoDM;
import sgpp.dominio.ResultadoValidacion;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.beans.ResponsableTecnico;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.modelo.dao.entidades.ResponsableTecnicoDAO;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.net.URL;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.ResourceBundle;

public class FXMLFormularioProyectoController implements Initializable {
    @FXML
    private Label lbNombreCU;
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
    private Label lbErrorFechaFin;
    @FXML
    private Button btnGuardar;

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
            lbNombreCU.setText("Actualizar Proyecto");
            btnGuardar.setText("Actualizar");
            cargarInformacionEdicion();
        }
    }

    private void cargarOrganizaciones() {
        organizaciones = FXCollections.observableArrayList();
        try {
            List<OrganizacionVinculada> organizacionesAux = OrganizacionVinculadaDAO.obtenerOrganizacionesVinculadas();
            organizaciones.addAll(organizacionesAux);
            comboOV.setItems(FXCollections.observableArrayList(organizaciones));
        } catch (SQLException sqlex) {
            Utilidad.crearAlerta(
                    Alert.AlertType.ERROR,
                    "Error inesperado",
                    "Lo sentimos, por el momento no se pudieron recuperar las organizaciones vinculadas");
            cerrarVentana();
        }
    }

    private void cargarResponsables(int idOrganizacion) {
        responsables = FXCollections.observableArrayList();
        try {
            List<ResponsableTecnico> responsablesAux = ResponsableTecnicoDAO.obtenerPorOrganizacion(idOrganizacion);
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
    }

    //Metodo listener para actualizar los responsables disponibles para seleccion
    private void seleccionarResponsables() {
        comboOV.valueProperty().addListener(new ChangeListener<OrganizacionVinculada>() {
            @Override
            public void changed(ObservableValue<? extends OrganizacionVinculada> observable, OrganizacionVinculada oldValue, OrganizacionVinculada newValue) {
                if (newValue != null) {
                    cargarResponsables(newValue.getIdOrganizacionVinculada());
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

            int indiceOV = obtenerIndiceEnComboOV(proyectoEdicion.getIdOrganizacionVinculada());
            System.out.println(indiceOV);
            comboOV.getSelectionModel().select(indiceOV);

            int indiceResponsable = obtenerIndiceEnComboResponsable(proyectoEdicion.getIdResponsable());
            System.out.println(indiceResponsable);
            comboResponsable.getSelectionModel().select(indiceResponsable);

            datePkFechaInicio.setValue(LocalDate.parse(proyectoEdicion.getFechaInicio()));
            datePkFechaFin.setValue(LocalDate.parse(proyectoEdicion.getFechaFin()));
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
        if (validarCamposVacios()) {
            if (validarDatosParaBD()) {

            }
        }
    }

    private void guardarProyecto() {
        Proyecto candidato = construirProyectoCandidato();
        if (validarProyecto(candidato)) {
            if (!esEdicion) {

            } else {

            }
        }
    }

    private boolean validarCamposVacios() {
        lbErrorNombre.setText("");
        lbErrorObjetivo.setText("");
        lbErrorMetodologia.setText("");
        lbErrorMaxParticipantes.setText("");
        lbErrorOV.setText("");
        lbErrorResponsable.setText("");
        lbErrorFechaInicio.setText("");
        lbErrorFechaFin.setText("");
        lbErrorFechaInicio.setText("");
        boolean validos = true;
        if (txFiNombre.getText().isEmpty()) {
            validos = false;
            lbErrorNombre.setText("*requerido");
        }
        if (txFiObjetivo.getText().isEmpty()) {
            validos = false;
            lbErrorObjetivo.setText("*requerido");
        }
        if (txFiMetodologia.getText().isEmpty()) {
            validos = false;
            lbErrorMetodologia.setText("*requerido");
        }
        if (txFiMaxParticipantes.getText().isEmpty()) {
            validos = false;
            lbErrorMaxParticipantes.setText("*requerido");
        }
        if (comboOV.getSelectionModel().getSelectedItem() == null) {
            validos = false;
            lbErrorOV.setText("*requerido");
        }
        if (comboResponsable.getSelectionModel().getSelectedItem() == null) {
            validos = false;
            lbErrorResponsable.setText("*requerido");
        }
        if (datePkFechaInicio.getValue() == null) {
            validos = false;
            lbErrorFechaInicio.setText("*requerido");
        }
        if (datePkFechaFin.getValue() == null) {
            validos = false;
            lbErrorFechaFin.setText("*requerido");
        }
        return validos;
    }

    private boolean validarDatosParaBD() {
        boolean validos = true;
        if (txFiNombre.getText().length() > 100) {
            validos = false;
            lbErrorNombre.setText("*demasiado largo");
        }
        if (txFiObjetivo.getText().length() > 100) {
            validos = false;
            lbErrorObjetivo.setText("*demasiado largo");
        }
        if (txFiMetodologia.getText().length() > 100) {
            validos = false;
            lbErrorMetodologia.setText("*demasiado largo");
        }
        if (!UtilidadFormatoDeDatos.esUnNumeroEntero(txFiMaxParticipantes.getText())) {
            validos = false;
            lbErrorMaxParticipantes.setText("*solo numeros enteros");
        }
        return validos;
    }

    private boolean validarProyecto(Proyecto proyecto) {
        ResultadoValidacion validacion = new ResultadoValidacion();
        validacion = ProyectoDM.validarParticipantes(
                proyecto.getNumeroMaximoParticipantes());
        if (!validacion.isValido()) {
            lbErrorMaxParticipantes.setText(validacion.getMensaje());
        }
        validacion = ProyectoDM.validarFechas(
                LocalDate.parse(proyecto.getFechaInicio()),
                LocalDate.parse(proyecto.getFechaFin()));
        if (!validacion.isValido()) {
            lbErrorFechaInicio.setText(validacion.getMensaje());
        }
        return validacion.isValido();
    }

    //Debe llamarse con datos previamente validados o podria lanzar NumberFormatException
    private Proyecto construirProyectoCandidato() {
        Proyecto proyecto = new Proyecto();
        proyecto.setNombre(txFiNombre.getText());
        proyecto.setObjetivoGeneral(txFiObjetivo.getText());
        proyecto.setMetodologia(txFiMetodologia.getText());
        proyecto.setNumeroMaximoParticipantes(Integer.parseInt(txFiMaxParticipantes.getText()));
        proyecto.setFechaInicio(datePkFechaInicio.getValue().toString());
        proyecto.setFechaFin(datePkFechaFin.getValue().toString());
        return proyecto;
    }

    private int obtenerIndiceEnComboOV(int idOrganizacion) {
        System.out.println(idOrganizacion);
        System.out.println(organizaciones.size());
        for (int i = 0; i < organizaciones.size(); i++) {
            if (organizaciones.get(i).getIdOrganizacionVinculada() == idOrganizacion) {
                return i;
            }
        }
        return 0;
    }

    private int obtenerIndiceEnComboResponsable(int idResponsable) {
        System.out.println(idResponsable);
        System.out.println(responsables.size());
        for (int i = 0; i < responsables.size(); i++) {
            if (responsables.get(i).getIdResponsable() == idResponsable) {
                return i;
            }
        }
        return 0;
    }

    private void cerrarVentana() {
        Utilidad.getEscenarioComponente(txFiNombre).close();
    }
}
