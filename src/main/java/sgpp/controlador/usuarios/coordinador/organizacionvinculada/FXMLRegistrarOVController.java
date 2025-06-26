/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 10-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 25-06-2025
 * Descripción: Controlador para manejar las operaciones de la vista FXMLRegistrarOV.fxml.
 *              Se encarga de validar los datos del formulario y mandar a llamar al DAO para registrar la OV
 */

/*
 * Estado: En progreso
 * Modificaciones: Se modularizaron los métodos
 *                 Se agregaron más validacionees para los campos
 *                 Se implementó javadocs en el controlador
 *                 Se implementó el uso de logger para hacer más robusto el manejo de errores
 */

package sgpp.controlador.usuarios.coordinador.organizacionvinculada;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.utilidad.EstadoMexico;
import sgpp.utilidad.Utilidad;

import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;

import static sgpp.controlador.usuarios.coordinador.organizacionvinculada.FXMLOrganizacionVinculadaController.*;
import static sgpp.dominio.OrganizacionVinculadaDM.*;

public class FXMLRegistrarOVController implements javafx.fxml.Initializable {
    private static final Logger LOGGER = Logger.getLogger(FXMLRegistrarOVController.class.getName());

    private static final String TITULO_CAMPOS_INCOMPLETOS = "Campos incompletos";
    private static final String MENSAJE_CAMPOS_INCOMPLETOS = "Por favor, complete todos los campos antes de continuar.";

    private static final String TITULO_REGISTRO_EXITOSO = "Organización vinculada registrada exitosamente";
    private static final String MENSAJE_REGISTRO_EXITOSO = "La organización vinculada ha sido registrada correctamente.";

    private static final String TITULO_ERROR_REGISTRO = "Error al registrar la organización vinculada";
    private static final String MENSAJE_ERROR_REGISTRO = "No se pudo registrar la organización vinculada. Por favor, intente nuevamente.";

    @FXML
    private TextField txfiNombre;
    @FXML
    private ComboBox<String> comboSector;
    @FXML
    private TextField txFiTelefono;
    @FXML
    private TextField txfiCorreo;
    @FXML
    private TextField txfiDireccion;
    @FXML
    private ComboBox<String> comboCiudad;
    @FXML
    private ComboBox<String> comboEstado;

    OrganizacionVinculada organizacionVinculada;

    @Override
    public void initialize(java.net.URL url, java.util.ResourceBundle rb) {
        configurarComboBoxes();
        configurarListeners();
        LOGGER.info("Controlador inicializado y ComboBoxes configurados");
    }

    public void configurarComboBoxes() {
        try {
            configurarComboSector();
            configurarComboEstado();
            configurarComboCiudad();
            LOGGER.info("ComboBoxes configurados exitosamente");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error al configurar ComboBoxes", e);
            mostrarErrorConfiguracion();
        }
    }

    public void configurarComboSector() {
        ObservableList<String> sectores = FXCollections.observableArrayList(
                "PUBLICO", "PRIVADO", "SOCIAL"
        );
        comboSector.setItems(sectores);
        comboSector.setPromptText("Seleccione un sector");
    }

    public void configurarComboEstado() {
        ObservableList<String> estados = FXCollections.observableArrayList(
                EstadoMexico.obtenerTodosLosNombres()
        );
        comboEstado.setItems(estados);
        comboEstado.setPromptText("Seleccione un estado");
    }

    public void configurarComboCiudad() {
        comboCiudad.setItems(FXCollections.observableArrayList());
        comboCiudad.setPromptText("Primero seleccione un estado");
        comboCiudad.setDisable(true); // Deshabilitado hasta que se seleccione un estado
    }

    private void configurarListeners() {
        // Listener para el ComboBox de estado
        comboEstado.setOnAction(event -> manejarCambioEstado());

        // Listener para limpiar ciudad cuando se cambie el estado
        comboEstado.valueProperty().addListener((observable, oldValue, newValue) -> {
            if (newValue == null || !newValue.equals(oldValue)) {
                limpiarSeleccionCiudad();
            }
        });
    }

    private void manejarCambioEstado() {
        String estadoSeleccionado = comboEstado.getValue();

        if (estadoSeleccionado == null || estadoSeleccionado.trim().isEmpty()) {
            deshabilitarComboCiudad();
            return;
        }

        try {
            cargarCiudadesPorEstado(estadoSeleccionado);
            habilitarComboCiudad();
            LOGGER.info("Ciudades cargadas para el estado: " + estadoSeleccionado);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error al cargar ciudades para el estado: " + estadoSeleccionado, e);
            mostrarErrorCargaCiudades();
            deshabilitarComboCiudad();
        }
    }

    private void cargarCiudadesPorEstado(String nombreEstado) {
        EstadoMexico.buscarPorNombre(nombreEstado)
                .ifPresentOrElse(
                        estado -> {
                            ObservableList<String> ciudades = FXCollections.observableArrayList(
                                    estado.getCiudades()
                            );
                            comboCiudad.setItems(ciudades);
                            comboCiudad.setPromptText("Seleccione una ciudad");
                        },
                        () -> {
                            LOGGER.warning("Estado no encontrado: " + nombreEstado);
                            comboCiudad.setItems(FXCollections.observableArrayList());
                            comboCiudad.setPromptText("Estado no válido");
                        }
                );
    }

    private void habilitarComboCiudad() {
        comboCiudad.setDisable(false);
    }

    private void limpiarSeleccionCiudad() {
        comboCiudad.setValue(null);
    }

    private void deshabilitarComboCiudad() {
        comboCiudad.setDisable(true);
        comboCiudad.setItems(FXCollections.observableArrayList());
        comboCiudad.setValue(null);
        comboCiudad.setPromptText("Primero seleccione un estado");
    }

    @FXML
    public void clicBtnRegistrar(ActionEvent actionEvent) {
        try {
            if (procesarRegistro()) {
                cerrarVentana();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error de base de datos al registrar organización", e);
            Utilidad.mostrarErrorBD(true, e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error inesperado al registrar organización", e);
            mostrarErrorGenerico();
        }
    }

    @FXML
    public void clicBtnCancelar(ActionEvent actionEvent) {
        cerrarVentana();
    }

    /**
     * Procesa el registro de la organización vinculada.
     * @return true si el registro fue exitoso, false en caso contrario
     * @throws SQLException si hay problemas con la base de datos
     */
    private boolean procesarRegistro() throws SQLException {
        if (!validarTodosCampos()) {
            return false;
        }

        OrganizacionVinculada organizacion = crearOrganizacionDesdeFormulario();
        boolean registrado = OrganizacionVinculadaDAO.registrar(organizacion);

        if (registrado) {
            mostrarRegistroExitoso();
            return true;
        } else {
            mostrarErrorRegistro();
            return false;
        }
    }

    /**
     * Crea una instancia de OrganizacionVinculada con los datos del formulario.
     * @return OrganizacionVinculada con los datos del formulario
     */
    private OrganizacionVinculada crearOrganizacionDesdeFormulario() {
        OrganizacionVinculada organizacion = new OrganizacionVinculada();

        organizacion.setNombre(obtenerTextoLimpio(txfiNombre));
        organizacion.setSector(comboSector.getValue() != null ? comboSector.getValue() : "");
        organizacion.setTelefono(obtenerTextoLimpio(txFiTelefono));
        organizacion.setCorreo(obtenerTextoLimpio(txfiCorreo));
        organizacion.setDireccion(obtenerTextoLimpio(txfiDireccion));
        organizacion.setCiudad(comboCiudad.getValue() != null ? comboCiudad.getValue() : "");
        organizacion.setEstado(comboEstado.getValue() != null ? comboEstado.getValue() : "");

        return organizacion;
    }

    /**
     * Obtiene el texto de un campo de texto y lo limpia de espacios.
     * @param textField el campo de texto
     * @return el texto limpio o cadena vacía si es null
     */
    private String obtenerTextoLimpio(TextField textField) {
        return textField.getText() != null ? textField.getText().trim() : "";
    }

    /**
     * Valida todos los campos del formulario.
     * @return true si todos los campos son válidos, false en caso contrario
     */
    private boolean validarTodosCampos() {
        return validarCamposObligatorios() &&
                validarFormatosYLongitudes();
    }

    /**
     * Valida que todos los campos obligatorios estén completos.
     * @return true si todos los campos están completos, false en caso contrario
     */
    private boolean validarCamposObligatorios() {
        if (algunCampoVacio()) {
            mostrarAlertaCamposIncompletos();
            return false;
        }
        return true;
    }

    /**
     * Verifica si algún campo está vacío.
     * @return true si algún campo está vacío, false en caso contrario
     */
    private boolean algunCampoVacio() {
        return obtenerTextoLimpio(txfiNombre).isEmpty() ||
                comboSector.getValue() == null ||
                obtenerTextoLimpio(txFiTelefono).isEmpty() ||
                obtenerTextoLimpio(txfiCorreo).isEmpty() ||
                obtenerTextoLimpio(txfiDireccion).isEmpty() ||
                comboCiudad.getValue() == null ||
                comboEstado.getValue() == null;
    }

    /**
     * Valida los formatos y longitudes de todos los campos.
     * @return true si todos los formatos son válidos, false en caso contrario
     */
    private boolean validarFormatosYLongitudes() {
        return validarNombre() &&
                validarSector() &&
                validarTelefono() &&
                validarCorreo() &&
                validarDireccion() &&
                validarCiudadYEstado();
    }

    private boolean validarNombre() {
        String nombre = obtenerTextoLimpio(txfiNombre);
        if (!validarLongitudNombre(nombre)) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Nombre demasiado largo",
                    "El nombre de la organización no puede exceder los 100 caracteres.");
            return false;
        }
        return true;
    }

    private boolean validarSector() {
        String sector = comboSector.getValue();
        if (sector == null || !verificarSector(sector)) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Sector inválido",
                    "Por favor, seleccione un sector válido.");
            return false;
        }
        return true;
    }

    private boolean validarTelefono() {
        String telefono = obtenerTextoLimpio(txFiTelefono);
        if (!validarLongitudTelefono(telefono)) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Teléfono inválido",
                    "El teléfono debe contener exactamente 10 dígitos.");
            return false;
        }
        if (!verificarFormatoTelefono(telefono)) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Formato de teléfono incorrecto",
                    "Por favor, ingrese un número de teléfono válido.");
            return false;
        }
        return true;
    }

    private boolean validarCorreo() {
        String correo = obtenerTextoLimpio(txfiCorreo);
        if (!validarLongitudCorreo(correo)) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Correo electrónico inválido",
                    "El correo electrónico debe tener un formato válido y no exceder los 100 caracteres.");
            return false;
        }
        if (!verificarFormatoCorreo(correo)) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Formato de correo electrónico incorrecto",
                    "Por favor, ingrese un correo electrónico válido.");
            return false;
        }
        return true;
    }

    private boolean validarDireccion() {
        String direccion = obtenerTextoLimpio(txfiDireccion);
        if (!validarLongitudDireccion(direccion)) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Dirección demasiado larga",
                    "La dirección de la organización no puede exceder los 100 caracteres.");
            return false;
        }
        return true;
    }

    private boolean validarCiudadYEstado() {
        String estado = comboEstado.getValue();
        String ciudad = comboCiudad.getValue();

        if (estado != null && !validarLongitudEstado(estado)) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Estado inválido",
                    "El estado seleccionado no es válido.");
            return false;
        }

        if (ciudad != null && !validarLongitudCiudad(ciudad)) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Ciudad inválida",
                    "La ciudad seleccionada no es válida.");
            return false;
        }

        return true;
    }

    // Métodos para mostrar alertas
    private void mostrarAlertaCamposIncompletos() {
        Utilidad.crearAlerta(Alert.AlertType.WARNING, TITULO_CAMPOS_INCOMPLETOS, MENSAJE_CAMPOS_INCOMPLETOS);
    }

    private void mostrarRegistroExitoso() {
        Utilidad.crearAlerta(Alert.AlertType.INFORMATION, TITULO_REGISTRO_EXITOSO, MENSAJE_REGISTRO_EXITOSO);
    }

    private void mostrarErrorRegistro() {
        Utilidad.crearAlerta(Alert.AlertType.ERROR, TITULO_ERROR_REGISTRO, MENSAJE_ERROR_REGISTRO);
    }

    private void cerrarVentana() {
        Utilidad.cerrarVentana(txfiNombre);
    }
}