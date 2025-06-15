/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 14-06-2025
 * Fecha de la última versión aprobada:S/F
 * Fecha de la última modificación: 14-06-2025 6:49
 * Descripción: Controlador para la ventana de administracion de proyectos
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.coordinador.proyecto;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.stage.Stage;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.dao.entidades.ProyectoDAO;
import sgpp.utilidad.Utilidad;

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
            sqlex.printStackTrace();
            Utilidad.crearAlerta(
                    Alert.AlertType.ERROR,
                    "Error de datos",
                    "Lo sentimos, debido a un error inesperado no se pudo recuperar la informacion de los proyectos"
            );
            cerrarVentana();
        }
    }

    public void cerrarVentana() {
        Utilidad.getEscenarioComponente(tblProyecto).close();
    }

    public void clicBtnRegistrar(ActionEvent actionEvent) {

    }

    public void clicBtnActualizar(ActionEvent actionEvent) {
    }
}
