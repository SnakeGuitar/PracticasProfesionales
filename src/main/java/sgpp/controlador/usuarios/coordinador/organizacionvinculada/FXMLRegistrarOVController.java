/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 10-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 12-06-2025
 * Descripción: Controlador para manejar las operaciones de la vista FXMLRegistrarOV.fxml
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.coordinador.organizacionvinculada;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.utilidad.Utilidad;

import java.sql.SQLException;
import java.util.List;

import static sgpp.dominio.OrganizacionVinculadaDM.*;

public class FXMLRegistrarOVController implements javafx.fxml.Initializable {
    @FXML
    public TextField txfiNombre;
    @FXML
    public TextField txfiSector;
    @FXML
    private TextField txFiTelefono;
    @FXML
    private TextField txfiCorreo;
    @FXML
    private TextField txfiDireccion;
    @FXML
    private TextField txfiCiudad;
    @FXML
    private TextField txfiEstado;

    @Override
    public void initialize(java.net.URL url, java.util.ResourceBundle rb) {
    }

    @FXML
    public void clicBtnRegistrar(ActionEvent actionEvent) {
        if (validarCampos()) {
            try {
                String nombre = txfiNombre.getText();
                String sector = txfiSector.getText();
                String telefono = txFiTelefono.getText();
                String correo = txfiCorreo.getText();
                String direccion = txfiDireccion.getText();
                String ciudad = txfiCiudad.getText();
                String estado = txfiEstado.getText();

                if (!validarCampos()) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Campos incompletos",
                            "Por favor, complete todos los campos antes de continuar.");
                    return;
                }

                if (!validarLongitudNombre(nombre)) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Nombre demasiado largo",
                            "El nombre de la organización no puede exceder los 100 caracteres.");
                    return;
                }

                if (!verificarSector(sector)) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Sector inválido",
                            "El sector no es válido. Por favor, ingrese un sector existente (P.");
                    return;
                }

                if (!validarLongitudTelefono(telefono)) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Teléfono inválido",
                            "El teléfono debe contener exactamente 10 dígitos.");
                    return;
                } else if (!verificarFormatoTelefono(telefono)) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Formato de teléfono incorrecto",
                            "Por favor, ingrese un número de teléfono válido.");
                    return;
                }

                if (!validarLongitudCorreo(correo)) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Correo electrónico inválido",
                            "El correo electrónico debe tener un formato válido y no exceder los 100 caracteres.");
                    return;
                } else if (!verificarFormatoCorreo(correo)) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Formato de correo electrónico incorrecto",
                            "Por favor, ingrese un correo electrónico válido.");
                    return;
                }

                if (!validarLongitudDireccion(direccion)) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Dirección demasiado larga",
                            "La dirección de la organización no puede exceder los 100 caracteres.");
                    return;
                }

                if (!validarLongitudCiudad(ciudad)) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Ciudad demasiado larga",
                            "La ciudad de la organización no puede exceder los 50 caracteres.");
                    return;
                }

                if (!validarLongitudEstado(estado)) {
                    Utilidad.crearAlerta(Alert.AlertType.WARNING,
                            "Estado demasiado largo",
                            "El estado de la organización no puede exceder los 50 caracteres.");
                    return;
                }

                OrganizacionVinculada organizacion = new OrganizacionVinculada();

                organizacion.setNombre(nombre);
                organizacion.setSector(sector.trim());
                organizacion.setTelefono(telefono.trim());
                organizacion.setCorreo(correo.trim());
                organizacion.setDireccion(direccion.trim());
                organizacion.setCiudad(ciudad.trim());
                organizacion.setEstado(estado.trim());
                
                boolean registrado = OrganizacionVinculadaDAO.registrar(organizacion);

                if (registrado) {
                    Utilidad.crearAlerta(Alert.AlertType.INFORMATION,
                            "Organización vinculada registrada exitosamente.",
                            "La organización vinculada ha sido registrada correctamente.");
                    Stage stage = (Stage) txfiNombre.getScene().getWindow();
                    stage.close();
                } else {
                    Utilidad.crearAlerta(Alert.AlertType.ERROR,
                            "Error al registrar la organización vinculada.",
                            "No se pudo registrar la organización vinculada. Por favor, intente nuevamente.");
                }
            } catch (SQLException e) {
                Utilidad.crearAlerta(Alert.AlertType.ERROR,
                        "No hay conexión con la base de datos",
                        "Se ha perdido la conexión con la base de datos.");
            }
        }
    }

    @FXML
    public void clicBtnCancelar(ActionEvent actionEvent) {
        Stage stage = (Stage) txfiNombre.getScene().getWindow();
        stage.close();
    }

    private boolean validarCampos() {
        if (txfiNombre.getText().isEmpty() || txfiSector.getText().isEmpty() ||
            txFiTelefono.getText().isEmpty() || txfiCorreo.getText().isEmpty() ||
            txfiDireccion.getText().isEmpty() || txfiCiudad.getText().isEmpty() ||
            txfiEstado.getText().isEmpty()) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Todos los campos son obligatorios.",
                    "Por favor, complete todos los campos antes de continuar.");
            return false;
        }
        return true;
    }
}