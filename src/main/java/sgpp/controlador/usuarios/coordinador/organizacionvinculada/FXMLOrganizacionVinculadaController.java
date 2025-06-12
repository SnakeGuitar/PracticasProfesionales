/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 10-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 11-06-2025
 * Descripción: Controlador para manejar las operaciones de la vista FXMLOrganizacionVinculada.fxml
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.coordinador.organizacionvinculada;

import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.dao.OrganizacionVinculadaDAO;
import sgpp.utilidad.Utilidad;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class FXMLOrganizacionVinculadaController implements Initializable {
    private static final String RUTA_FXML_REGISTRAR_OV = "/sgpp/vista/usuarios/coordinador/organizacionvinculada/FXMLRegistrarOV.fxml"; // Implementar
    private static final String RUTA_FXML_ACTUALIZAR_OV = "/sgpp/vista/usuarios/coordinador/organizacionvinculada/FXMLActualizarOV.fxml"; // Implementar
    private static final String RUTA_FXML_ELIMINAR_OV = "/sgpp/vista/usuarios/coordinador/organizacionvinculada/FXMLEliminarOV.fxml"; // Implementar

    private ObservableList<OrganizacionVinculada> listaOrganizaciones;

    @FXML
    private TableView<OrganizacionVinculada> tblOV;
    @FXML
    private TableColumn<OrganizacionVinculada, Integer> colId;
    @FXML
    private TableColumn<OrganizacionVinculada, String> colNombre;
    @FXML
    private TableColumn<OrganizacionVinculada, String> colSector;
    @FXML
    private TableColumn<OrganizacionVinculada, String> colCorreo;
    @FXML
    private TableColumn<OrganizacionVinculada, String> colTelefono;
    @FXML
    private TableColumn<OrganizacionVinculada, String> colDireccion;
    @FXML
    private TableColumn<OrganizacionVinculada, String> colCiudad;
    @FXML
    private TableColumn<OrganizacionVinculada, String> colEstado;

    @Override
    public void initialize(URL url, ResourceBundle resources) {
        // Initialization logic here
        configurarTabla();
        cargarDatosTabla();
    }

    private void configurarTabla() {
        colId.setCellValueFactory(new PropertyValueFactory<>("id"));
        colNombre.setCellValueFactory(new PropertyValueFactory<>("nombre"));
        colSector.setCellValueFactory(new PropertyValueFactory<>("sector"));
        colCorreo.setCellValueFactory(new PropertyValueFactory<>("correo"));
        colTelefono.setCellValueFactory(new PropertyValueFactory<>("telefono"));
        colDireccion.setCellValueFactory(new PropertyValueFactory<>("direccion"));
        colCiudad.setCellValueFactory(new PropertyValueFactory<>("ciudad"));
        colEstado.setCellValueFactory(new PropertyValueFactory<>("estado"));
    }

    private void cargarDatosTabla() {
        try {
            listaOrganizaciones = FXCollections.observableArrayList();
            ArrayList<OrganizacionVinculada> organizacionVinculadaDAO = OrganizacionVinculadaDAO.obtenerOrganizacionesVinculadas();
            listaOrganizaciones.addAll(organizacionVinculadaDAO);
            tblOV.setItems(listaOrganizaciones);
        } catch (SQLException e) {
            Utilidad.crearAlerta(Alert.AlertType.ERROR,
                    "Error al cargar organizaciones vinculadas",
                    "No se pudieron cargar los datos de las organizaciones vinculadas. Por favor, intente más tarde."
            );
            e.printStackTrace();

        }
    }

    @FXML
    public void clicBtnRegistrarOV(ActionEvent actionEvent) {
        Utilidad.crearEscenario(
                RUTA_FXML_REGISTRAR_OV,
                "Registrar Organización Vinculada");
        cargarDatosTabla(); // Recargar datos después de registrar una nueva organización
    }

    @FXML
    public void clicBtnActualizarOV(ActionEvent actionEvent) {
        Utilidad.crearEscenario(
                RUTA_FXML_ACTUALIZAR_OV,
                "Actualizar Organización Vinculada");
        cargarDatosTabla(); // Recargar datos después de actualizar una organización
    }

    @FXML
    public void clicBtnEliminarOV(ActionEvent actionEvent) {
    }

    @FXML
    public void clicBtnImprimirOV(ActionEvent actionEvent) {
    }


}
