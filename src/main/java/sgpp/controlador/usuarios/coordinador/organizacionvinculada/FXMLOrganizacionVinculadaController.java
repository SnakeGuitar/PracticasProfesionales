/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 10-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 13-06-2025
 * Descripción: Controlador para manejar las operaciones de la vista FXMLOrganizacionVinculada.fxml
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.coordinador.organizacionvinculada;

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
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.utilidad.Utilidad;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ResourceBundle;

public class FXMLOrganizacionVinculadaController implements Initializable {
    // CONSTANTES PARA ERRORES GENERALES
    private static final String TITULO_ERROR_GENERICO = "Error inesperado";
    private static final String MENSAJE_ERROR_GENERICO = "Ha ocurrido un error inesperado. Por favor, intente nuevamente.";

    private static final String TITULO_ERROR_CONFIGURACION = "Error de configuración";
    private static final String MENSAJE_ERROR_CONFIGURACION = "Error al configurar los elementos de la interfaz. Por favor, reinicie la aplicación.";

    private static final String TITULO_ERROR_CARGA_CIUDADES = "Error al cargar ciudades";
    private static final String MENSAJE_ERROR_CARGA_CIUDADES = "No se pudieron cargar las ciudades para el estado seleccionado. Por favor, intente nuevamente.";

    private static final String RUTA_FXML_REGISTRAR_OV = "/sgpp/vista/usuarios/coordinador/organizacionvinculada/FXMLRegistrarOV.fxml";
    private static final String RUTA_FXML_ACTUALIZAR_OV = "/sgpp/vista/usuarios/coordinador/organizacionvinculada/FXMLActualizarOV.fxml";

    @FXML
    private TableView<OrganizacionVinculada> tblOV;
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

    /**
     * Configura las columnas de la tabla para mostrar los datos de las organizaciones vinculadas.
     * Utiliza PropertyValueFactory para enlazar las propiedades de los objetos OrganizacionVinculada
     * con las columnas de la tabla.
     */
    private void configurarTabla() {
        colNombre.setCellValueFactory(new PropertyValueFactory<>("nombre"));
        colSector.setCellValueFactory(new PropertyValueFactory<>("sector"));
        colCorreo.setCellValueFactory(new PropertyValueFactory<>("correo"));
        colTelefono.setCellValueFactory(new PropertyValueFactory<>("telefono"));
        colDireccion.setCellValueFactory(new PropertyValueFactory<>("direccion"));
        colCiudad.setCellValueFactory(new PropertyValueFactory<>("ciudad"));
        colEstado.setCellValueFactory(new PropertyValueFactory<>("estado"));
    }

    /**
     * Carga los datos de las organizaciones vinculadas en la tabla.
     * Utiliza el DAO para obtener los datos y los muestra en la tabla.
     */
    private void cargarDatosTabla() {
        try {
            ObservableList<OrganizacionVinculada> listaOrganizaciones = FXCollections.observableArrayList();
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

    /**
     * Maneja el evento de clic en el botón "Registrar OV".
     * Abre una nueva ventana para registrar una nueva organización vinculada.
     *
     * @param actionEvent el evento de acción del botón "Registrar OV"
     */
    @FXML
    public void clicBtnRegistrarOV(ActionEvent actionEvent) {
        Utilidad.crearEscenario(
                RUTA_FXML_REGISTRAR_OV,
                "Registrar Organización Vinculada");
        cargarDatosTabla(); // Recargar datos después de registrar una nueva organización
    }

    /**
     * Maneja el evento de clic en el botón "Actualizar OV".
     * Abre una ventana modal para actualizar la organización vinculada seleccionada.
     *
     * @param actionEvent el evento de acción del botón "Actualizar OV"
     */
    @FXML
    public void clicBtnActualizarOV(ActionEvent actionEvent) {
        OrganizacionVinculada organizacion = tblOV.getSelectionModel().getSelectedItem();

        if (organizacion == null) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Selección requerida",
                    "Por favor, seleccione una organización vinculada para actualizar.");
            return;
        }

        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(getClass().getResource(RUTA_FXML_ACTUALIZAR_OV));
            Parent root = loader.load();

            FXMLActualizarOVController controlador = loader.getController();
            controlador.inicializarDatos(organizacion);

            Stage stage = new Stage();
            stage.setTitle("Actualizar Organización Vinculada");
            stage.setScene(new Scene(root));
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.setResizable(false);
            stage.showAndWait();

            cargarDatosTabla(); // Recargar datos después de actualizar una organización

        } catch (IOException e) {
            Utilidad.crearAlerta(Alert.AlertType.ERROR,
                    "Error de interfaz",
                    "No se pudo cargar la vista de actualización de organización vinculada.");
            e.printStackTrace();
        }
    }

    /**
     * Maneja el evento de clic en el botón "Eliminar OV".
     * Actualmente no implementa ninguna acción.
     *
     * @param actionEvent el evento de acción del botón "Eliminar OV"
     */
    @FXML
    public void clicBtnEliminarOV(ActionEvent actionEvent) {
    }


    /**
     * Cierra la ventana actual sin realizar ninguna acción.
     *
     * @param actionEvent el evento de acción del botón "Cancelar"
     */
    public void clicBtnCancelar(ActionEvent actionEvent) {
        Utilidad.cerrarVentana(tblOV);
    }

    /**
     * Muestra un mensaje de error genérico.
     */
    public static void mostrarErrorGenerico() {
        Utilidad.crearAlerta(Alert.AlertType.ERROR, TITULO_ERROR_GENERICO, MENSAJE_ERROR_GENERICO);
    }

    /**
     * Muestra un mensaje de error al configurar los elementos de la interfaz.
     */
    public static void mostrarErrorConfiguracion() {
        Utilidad.crearAlerta(Alert.AlertType.ERROR, TITULO_ERROR_CONFIGURACION, MENSAJE_ERROR_CONFIGURACION);
    }

    /**
     * Muestra un mensaje de error al cargar las ciudades.
     */
    public static void mostrarErrorCargaCiudades() {
        Utilidad.crearAlerta(Alert.AlertType.ERROR, TITULO_ERROR_CARGA_CIUDADES, MENSAJE_ERROR_CARGA_CIUDADES);
    }
}
