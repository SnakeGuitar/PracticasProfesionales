/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 11-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 25-06-2025
 * Descripción: Controlador para manejar las operaciones de la vista FXMLActualizarOV.fxml
 *              Se encarga de validar los datos del formulario y mandar a llamar al DAO para actualizar la OV
 */

/*
 * Estado: Completado
 * Modificaciones: Se corrigieron los errores de referencias a campos inexistentes
 *                 Se implementaron validaciones completas similares al controlador de registro
 *                 Se agregó manejo de ComboBoxes para estados y ciudades
 *                 Se implementó javadocs y logger para manejo robusto de errores
 *                 Se detectan cambios antes de actualizar
 */

package sgpp.controlador.usuarios.coordinador.organizacionvinculada;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.utilidad.EstadoMexico;
import sgpp.utilidad.Utilidad;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import static sgpp.controlador.usuarios.coordinador.organizacionvinculada.FXMLOrganizacionVinculadaController.*;
import static sgpp.dominio.OrganizacionVinculadaDM.*;

public class FXMLActualizarOVController implements javafx.fxml.Initializable {
    private static final Logger LOGGER = Logger.getLogger(FXMLActualizarOVController.class.getName());

    private static final String TITULO_ACTUALIZACION_EXITOSA = "Organización vinculada actualizada exitosamente";
    private static final String MENSAJE_ACTUALIZACION_EXITOSA = "La organización vinculada ha sido actualizada correctamente.";

    private static final String TITULO_ERROR_ACTUALIZACION = "Error al actualizar la organización vinculada";
    private static final String MENSAJE_ERROR_ACTUALIZACION = "No se pudo actualizar la organización vinculada. Por favor, intente nuevamente.";

    private static final String TITULO_SIN_CAMBIOS = "Sin cambios detectados";
    private static final String MENSAJE_SIN_CAMBIOS = "No se han detectado cambios en los datos de la organización vinculada.";

    private static final String TITULO_CAMPOS_INCOMPLETOS = "Campos incompletos";
    private static final String MENSAJE_CAMPOS_INCOMPLETOS = "Por favor, complete todos los campos antes de continuar.";

    @FXML
    private TextField txfiNombre;
    @FXML
    private ComboBox<String> comboSector;
    @FXML
    private TextField txfiCorreo;
    @FXML
    private TextField txFiTelefono;
    @FXML
    private TextField txfiDireccion;
    @FXML
    private ComboBox<String> comboCiudad;
    @FXML
    private ComboBox<String> comboEstado;

    private OrganizacionVinculada organizacionVinculada;

    @Override
    public void initialize(java.net.URL url, java.util.ResourceBundle rb) {
        configurarComboBoxes();
        configurarListeners();
        LOGGER.info("Controlador de actualización inicializado");
    }

    /**
     * Configura todos los ComboBoxes del formulario.
     */
    private void configurarComboBoxes() {
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

    /**
     * Configura el ComboBox de sectores.
     */
    private void configurarComboSector() {
        ObservableList<String> sectores = FXCollections.observableArrayList(
                "PUBLICO", "PRIVADO", "SOCIAL"
        );
        comboSector.setItems(sectores);
        comboSector.setPromptText("Seleccione un sector");
    }

    /**
     * Configura el ComboBox de estados.
     */
    private void configurarComboEstado() {
        ObservableList<String> estados = FXCollections.observableArrayList(
                EstadoMexico.obtenerTodosLosNombres()
        );
        comboEstado.setItems(estados);
        comboEstado.setPromptText("Seleccione un estado");
    }

    /**
     * Configura el ComboBox de ciudades.
     */
    private void configurarComboCiudad() {
        comboCiudad.setItems(FXCollections.observableArrayList());
        comboCiudad.setPromptText("Primero seleccione un estado");
        comboCiudad.setDisable(true);
    }

    /**
     * Configura los listeners para los ComboBoxes.
     */
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

    /**
     * Maneja el cambio de estado seleccionado.
     */
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

    /**
     * Carga las ciudades correspondientes al estado seleccionado.
     * @param nombreEstado el nombre del estado seleccionado
     */
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

    /**
     * Habilita el ComboBox de ciudades.
     */
    private void habilitarComboCiudad() {
        comboCiudad.setDisable(false);
    }

    /**
     * Limpia la selección de ciudad.
     */
    private void limpiarSeleccionCiudad() {
        comboCiudad.setValue(null);
    }

    /**
     * Deshabilita el ComboBox de ciudades.
     */
    private void deshabilitarComboCiudad() {
        comboCiudad.setDisable(true);
        comboCiudad.setItems(FXCollections.observableArrayList());
        comboCiudad.setValue(null);
        comboCiudad.setPromptText("Primero seleccione un estado");
    }

    /**
     * Inicializa los datos de la organización vinculada en el formulario en caso de edición.
     * @param organizacion la organización vinculada a mostrar
     */
    public void inicializarDatos(OrganizacionVinculada organizacion) {
        if (organizacion != null) {
            this.organizacionVinculada = organizacion;

            // Llenar los campos con los datos existentes
            txfiNombre.setText(organizacion.getNombre());
            txfiCorreo.setText(organizacion.getCorreo());
            txFiTelefono.setText(organizacion.getTelefono());
            txfiDireccion.setText(organizacion.getDireccion());

            // Configurar ComboBoxes con los valores existentes
            comboSector.setValue(organizacion.getSector());
            comboEstado.setValue(organizacion.getEstado());

            // Cargar ciudades para el estado actual y seleccionar la ciudad
            if (organizacion.getEstado() != null && !organizacion.getEstado().isEmpty()) {
                cargarCiudadesPorEstado(organizacion.getEstado());
                habilitarComboCiudad();
                comboCiudad.setValue(organizacion.getCiudad());
            }

            LOGGER.info("Datos de organización vinculada inicializados en el formulario");
        }
    }

    /**
     * Maneja el evento de clic en el botón cancelar.
     * @param actionEvent el evento de acción
     */
    @FXML
    public void clicBtnCancelar(ActionEvent actionEvent) {
        cerrarVentana();
    }

    /**
     * Maneja el evento de clic en el botón actualizar.
     * @param actionEvent el evento de acción
     */
    @FXML
    public void clicBtnActualizar(ActionEvent actionEvent) {
        try {
            if (procesarActualizacion()) {
                cerrarVentana();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error de base de datos al actualizar organización", e);
            Utilidad.mostrarErrorBD(true, e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error inesperado al actualizar organización", e);
            mostrarErrorGenerico();
        }
    }

    /**
     * Procesa la actualización de la organización vinculada.
     * @return true si la actualización fue exitosa, false en caso contrario
     * @throws SQLException si hay problemas con la base de datos
     */
    private boolean procesarActualizacion() throws SQLException {
        if (!validarTodosCampos()) {
            return false;
        }

        OrganizacionVinculada organizacionActualizada = crearOrganizacionDesdeFormulario();

        // Verificar si hay cambios
        if (!hayCanmbios(organizacionActualizada)) {
            mostrarSinCambios();
            return false;
        }

        boolean actualizado = OrganizacionVinculadaDAO.actualizar(organizacionActualizada);

        if (actualizado) {
            mostrarActualizacionExitosa();
            return true;
        } else {
            mostrarErrorActualizacion();
            return false;
        }
    }

    /**
     * Crea una instancia de OrganizacionVinculada con los datos del formulario.
     * @return OrganizacionVinculada con los datos del formulario
     */
    private OrganizacionVinculada crearOrganizacionDesdeFormulario() {
        OrganizacionVinculada organizacion = new OrganizacionVinculada();

        organizacion.setIdOrganizacionVinculada(organizacionVinculada.getIdOrganizacionVinculada());
        organizacion.setNombre(obtenerTextoLimpio(txfiNombre));
        organizacion.setSector(comboSector.getValue() != null ? comboSector.getValue() : "");
        organizacion.setCorreo(obtenerTextoLimpio(txfiCorreo));
        organizacion.setTelefono(obtenerTextoLimpio(txFiTelefono));
        organizacion.setDireccion(obtenerTextoLimpio(txfiDireccion));
        organizacion.setCiudad(comboCiudad.getValue() != null ? comboCiudad.getValue() : "");
        organizacion.setEstado(comboEstado.getValue() != null ? comboEstado.getValue() : "");

        return organizacion;
    }

    /**
     * Verifica si hay cambios entre la organización original y la actualizada.
     * @param organizacionActualizada la organización con los nuevos datos
     * @return true si hay cambios, false en caso contrario
     */
    private boolean hayCanmbios(OrganizacionVinculada organizacionActualizada) {
        return !organizacionVinculada.getNombre().equals(organizacionActualizada.getNombre()) ||
                !organizacionVinculada.getSector().equals(organizacionActualizada.getSector()) ||
                !organizacionVinculada.getCorreo().equals(organizacionActualizada.getCorreo()) ||
                !organizacionVinculada.getTelefono().equals(organizacionActualizada.getTelefono()) ||
                !organizacionVinculada.getDireccion().equals(organizacionActualizada.getDireccion()) ||
                !organizacionVinculada.getCiudad().equals(organizacionActualizada.getCiudad()) ||
                !organizacionVinculada.getEstado().equals(organizacionActualizada.getEstado());
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

    /**
     * Valida el campo nombre.
     * @return true si el nombre es válido, false en caso contrario
     */
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

    /**
     * Valida el campo sector.
     * @return true si el sector es válido, false en caso contrario
     */
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

    /**
     * Valida el campo teléfono.
     * @return true si el teléfono es válido, false en caso contrario
     */
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

    /**
     * Valida el campo correo electrónico.
     * @return true si el correo es válido, false en caso contrario
     */
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

    /**
     * Valida el campo dirección.
     * @return true si la dirección es válida, false en caso contrario
     */
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

    /**
     * Valida los campos de ciudad y estado.
     * @return true si la ciudad y estado son válidos, false en caso contrario
     */
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

    private void mostrarActualizacionExitosa() {
        Utilidad.crearAlerta(Alert.AlertType.INFORMATION, TITULO_ACTUALIZACION_EXITOSA, MENSAJE_ACTUALIZACION_EXITOSA);
    }

    private void mostrarErrorActualizacion() {
        Utilidad.crearAlerta(Alert.AlertType.ERROR, TITULO_ERROR_ACTUALIZACION, MENSAJE_ERROR_ACTUALIZACION);
    }

    private void mostrarSinCambios() {
        Utilidad.crearAlerta(Alert.AlertType.INFORMATION, TITULO_SIN_CAMBIOS, MENSAJE_SIN_CAMBIOS);
    }

    private void cerrarVentana() {
        Stage stage = (Stage) txfiNombre.getScene().getWindow();
        stage.close();
    }
}