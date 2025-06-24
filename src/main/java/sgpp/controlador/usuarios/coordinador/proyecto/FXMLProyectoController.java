/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 14-06-2025
 * Fecha de la última versión aprobada: 15-06-2025 18:49
 * Fecha de la última modificación: 15-06-2025 18:49
 * Descripción: Controlador para la ventana de administracion de proyectos
 */

/*
 * Estado: Terminada
 * Modificaciones: Se corrigio una falta de ortografia en un Alert
 */

package sgpp.controlador.usuarios.coordinador.proyecto;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Modality;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.dao.entidades.ProyectoDAO;
import sgpp.utilidad.Utilidad;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.List;
import java.util.ResourceBundle;

public class FXMLProyectoController implements Initializable {
    @FXML
    private TableView<Proyecto> tblProyecto;
    @FXML
    private TableColumn<Proyecto, String> colNombre;
    @FXML
    private TableColumn<Proyecto, String> colObjetivoGeneral;
    @FXML
    private TableColumn<Proyecto, String> colMetodologia;
    @FXML
    private TableColumn<Proyecto, String> colNombreOV;
    @FXML
    private TableColumn<Proyecto, String> colNombreResponsable;
    @FXML
    private TableColumn<Proyecto, Integer> colMaxParticipantes;
    @FXML
    private TableColumn<Proyecto, String> colFechaInicio;
    @FXML
    private TableColumn<Proyecto, String> colFechaFin;

    private final String RUTA_FXML_FORMULARIO_PROYECTO = "/sgpp/vista/usuarios/coordinador/proyecto/FXMLFormularioProyecto.fxml";
    private ObservableList<Proyecto> proyectos;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        configurarTabla();
        cargarInformacion();
    }

    private void configurarTabla() {
        colNombre.setCellValueFactory(new PropertyValueFactory<Proyecto, String>("nombre"));
        colObjetivoGeneral.setCellValueFactory(new PropertyValueFactory<Proyecto, String>("objetivoGeneral"));
        colMetodologia.setCellValueFactory(new PropertyValueFactory<Proyecto, String>("metodologia"));
        colMaxParticipantes.setCellValueFactory(new PropertyValueFactory<Proyecto, Integer>("numeroMaximoParticipantes"));
        colNombreOV.setCellValueFactory(new PropertyValueFactory<Proyecto, String>("nombreOV"));
        colNombreResponsable.setCellValueFactory(new PropertyValueFactory<Proyecto, String>("nombreResponsable"));
        colFechaInicio.setCellValueFactory(new PropertyValueFactory<Proyecto, String>("fechaInicio"));
        colFechaFin.setCellValueFactory(new PropertyValueFactory<Proyecto, String>("fechaFin"));
    }

    private void cargarInformacion() {
        try {
            proyectos = FXCollections.observableArrayList();
            List<Proyecto> proyectosAux = ProyectoDAO.obtenerProyectos();
            proyectos.addAll(proyectosAux);
            tblProyecto.setItems(proyectos);
        } catch (SQLException sqlex) {
            Utilidad.crearAlerta(
                    Alert.AlertType.ERROR,
                    "Error de datos",
                    "Lo sentimos, debido a un error inesperado no se pudo recuperar la informacion de los proyectos"
            );
            Utilidad.cerrarVentana(tblProyecto);
        }
    }

    public void clicBtnRegistrar(ActionEvent actionEvent) {
        irAFormularioProyecto(false, null);
        cargarInformacion();
    }

    public void clicBtnActualizar(ActionEvent actionEvent) {
        Proyecto proyectoSeleccionado = tblProyecto.getSelectionModel().getSelectedItem();
        if (proyectoSeleccionado != null) {
            irAFormularioProyecto(true, proyectoSeleccionado);
        } else {
            Utilidad.crearAlerta(
                    Alert.AlertType.INFORMATION,
                    "Seleccione requerida",
                    "Por favor seleccione un proyecto primero"
            );
        }
    }

    private void irAFormularioProyecto(boolean esEdicion, Proyecto proyectoEdicion) {
        try {
            Stage escenaFormulario = new Stage();
            FXMLLoader loader = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(RUTA_FXML_FORMULARIO_PROYECTO));
            Parent vista = loader.load();
            FXMLFormularioProyectoController controlador = loader.getController();
            Scene nuevaEscena = new Scene(vista);
            escenaFormulario.setScene(nuevaEscena);
            escenaFormulario.setTitle(!esEdicion ? "Registrar Proyecto" : "Actualizar Proyecto");
            escenaFormulario.initModality(Modality.APPLICATION_MODAL);
            controlador.inicializarInformacion(esEdicion, proyectoEdicion);
            escenaFormulario.showAndWait();
            cargarInformacion();
        } catch (IOException ioex) {
            Utilidad.crearAlerta(
                    Alert.AlertType.ERROR,
                    "Error",
                    "Lo sentimos, no se pudo abrir el formulario del proyecto"
            );
        }
    }
}
