/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 14-06-2025
 * Fecha de la última versión aprobada: 21:15
 * Fecha de la última modificación: 15-06-2025 20:32
 * Descripción: Controlador para el formulario utlizado en los CU01 y CU02
 */

/*
 * Estado: Terminado - Pruebas Superficiales realizadas
 * Modificaciones: cambiado el metodo de validarProyecto para que se muestren todos los mensajes de error
 */

package sgpp.controlador.usuarios.coordinador.proyecto;

import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Modality;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.dominio.ProyectoDM;
import sgpp.dominio.ResultadoValidacion;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.beans.ResponsableTecnico;
import sgpp.modelo.dao.ResultadoSQL;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.modelo.dao.entidades.ProyectoDAO;
import sgpp.modelo.dao.entidades.ResponsableTecnicoDAO;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.io.IOException;
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
    private TextArea txArObjetivo;
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

    private final String RUTA_FXML_COMPARAR_PROYECTOS = "/sgpp/vista/usuarios/coordinador/proyecto/FXMLCompararProyectos.fxml";
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
            txArObjetivo.setText(proyectoEdicion.getObjetivoGeneral());
            txFiMetodologia.setText(proyectoEdicion.getMetodologia());
            txFiMaxParticipantes.setText(String.valueOf(proyectoEdicion.getNumeroMaximoParticipantes()));

            int indiceOV = obtenerIndiceEnComboOV(proyectoEdicion.getIdOrganizacionVinculada());
            comboOV.getSelectionModel().select(indiceOV);

            int indiceResponsable = obtenerIndiceEnComboResponsable(proyectoEdicion.getIdResponsable());
            comboResponsable.getSelectionModel().select(indiceResponsable);

            datePkFechaInicio.setValue(LocalDate.parse(proyectoEdicion.getFechaInicio()));
            datePkFechaFin.setValue(LocalDate.parse(proyectoEdicion.getFechaFin()));
        }
    }

    public void clicBtnCancelar(ActionEvent actionEvent) {
        boolean cancelar = Utilidad.confirmarCancelar();

        if (cancelar) {
            cerrarVentana();
        }
    }

    public void clicBtnGuardar(ActionEvent actionEvent) {
        if (validarCamposVacios()) {
            if (validarDatosParaBD()) {
                guardarProyecto();
            }
        }
    }

    private void guardarProyecto() {
        Proyecto candidato = construirProyectoCandidato();
        if (validarProyecto(candidato)) {
            if (!esEdicion) {
                registrar(candidato);
            } else {
                actualizar(candidato);
            }
        }
    }

    private void registrar(Proyecto candidato) {
        ResultadoSQL resultado = new ResultadoSQL();
        resultado = ProyectoDAO.registrar(candidato);
        if(!resultado.isError()) {
            Utilidad.crearAlerta(Alert.AlertType.INFORMATION, "Exito", resultado.getMensaje());
            cerrarVentana();
        } else {
            Utilidad.crearAlerta(Alert.AlertType.ERROR, "Error", resultado.getMensaje());
        }
    }

    private void actualizar(Proyecto candidato) {
        ResultadoSQL resultado = new ResultadoSQL();
        boolean confirmacion = irATablaComparacion(candidato);
        if (confirmacion) {
            resultado = ProyectoDAO.actualizar(candidato);
            if(!resultado.isError()) {
                Utilidad.crearAlerta(Alert.AlertType.INFORMATION, "Exito", resultado.getMensaje());
                cerrarVentana();
            } else {
                Utilidad.crearAlerta(Alert.AlertType.ERROR, "Error", resultado.getMensaje());
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
        if (txArObjetivo.getText().isEmpty()) {
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
        if (txArObjetivo.getText().length() > 100) {
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
        int numErrores = 0;
        ResultadoValidacion validacion = new ResultadoValidacion();
        validacion = ProyectoDM.validarParticipantes(
                proyecto.getNumeroMaximoParticipantes());
        if (!validacion.isValido()) {
            lbErrorMaxParticipantes.setText(validacion.getMensaje());
            numErrores++;
        }
        LocalDate fechaInicio = LocalDate.parse(proyecto.getFechaInicio());
        LocalDate fechaFin = LocalDate.parse(proyecto.getFechaFin());
        validacion = ProyectoDM.validarFechaInicio(fechaInicio, fechaFin);
        if (!validacion.isValido()) {
            lbErrorFechaInicio.setText(validacion.getMensaje());
            numErrores++;
        }
        validacion = ProyectoDM.validarFechaFin(fechaInicio, fechaFin);
        if (!validacion.isValido()) {
            lbErrorFechaFin.setText(validacion.getMensaje());
            numErrores++;
        }
        return (numErrores == 0);
    }

    //Debe llamarse con datos previamente validados o podria lanzar NumberFormatException
    private Proyecto construirProyectoCandidato() {
        Proyecto proyecto = new Proyecto();
        proyecto.setNombre(txFiNombre.getText());
        proyecto.setObjetivoGeneral(txArObjetivo.getText());
        proyecto.setMetodologia(txFiMetodologia.getText());
        proyecto.setNumeroMaximoParticipantes(Integer.parseInt(txFiMaxParticipantes.getText()));
        proyecto.setFechaInicio(datePkFechaInicio.getValue().toString());
        proyecto.setFechaFin(datePkFechaFin.getValue().toString());
        proyecto.setIdOrganizacionVinculada(
                comboOV.getSelectionModel().getSelectedItem().getIdOrganizacionVinculada());
        proyecto.setIdResponsable(
                comboResponsable.getSelectionModel().getSelectedItem().getIdResponsable());
        if (esEdicion) {
            proyecto.setIdProyecto(proyectoEdicion.getIdProyecto());
            proyecto.setNombreOV(comboOV.getSelectionModel().getSelectedItem().getNombre());
            proyecto.setNombreResponsable(comboResponsable.getSelectionModel().getSelectedItem().getNombre());
        }
        return proyecto;
    }

    private boolean irATablaComparacion(Proyecto candidato) {
        try {
            Stage escenaFormulario = new Stage();
            FXMLLoader loader = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(RUTA_FXML_COMPARAR_PROYECTOS));
            Parent vista = loader.load();
            FXMLCompararProyectosController controlador = loader.getController();
            Scene nuevaEscena = new Scene(vista);
            escenaFormulario.setScene(nuevaEscena);
            escenaFormulario.setTitle("Confirmar");
            escenaFormulario.initModality(Modality.APPLICATION_MODAL);
            controlador.cargarDatos(proyectoEdicion, candidato);
            escenaFormulario.showAndWait();
            return controlador.getConfirmacion();
        } catch (IOException ioex) {
            Utilidad.crearAlerta(
                    Alert.AlertType.ERROR,
                    "Error",
                    "Lo sentimos, no se pudo abrir el formulario del proyecto"
            );
        }
        return false;
    }

    private int obtenerIndiceEnComboOV(int idOrganizacion) {
        for (int i = 0; i < organizaciones.size(); i++) {
            if (organizaciones.get(i).getIdOrganizacionVinculada() == idOrganizacion) {
                return i;
            }
        }
        return 0;
    }

    private int obtenerIndiceEnComboResponsable(int idResponsable) {
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
