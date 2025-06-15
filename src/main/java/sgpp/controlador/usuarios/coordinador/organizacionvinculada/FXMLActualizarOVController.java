/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 11-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 13-06-2025
 * Descripción: Controlador para manejar las operaciones de la vista FXMLActualizarOV.fxml
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

public class FXMLActualizarOVController implements javafx.fxml.Initializable {

    @FXML
    private TextField txfiNombre;
    @FXML
    private TextField txfiSector;
    @FXML
    private TextField txfiCorreo;
    @FXML
    private TextField txFiTelefono;
    @FXML
    private TextField txfiDireccion;
    @FXML
    private TextField txfiCiudad;
    @FXML
    private TextField txfiEstado;

    OrganizacionVinculada organizacionVinculada;

    @Override
    public void initialize(java.net.URL url, java.util.ResourceBundle rb) {

    }

    public void inicializarDatos(OrganizacionVinculada organizacion) {
        if (organizacion != null) {
            this.organizacionVinculada = organizacion;
            txfiNombre.setText(organizacion.getNombre());
            txfiSector.setText(organizacion.getSector());
            txfiCorreo.setText(organizacion.getCorreo());
            txFiTelefono.setText(organizacion.getTelefono());
            txfiDireccion.setText(organizacion.getDireccion());
            txfiCiudad.setText(organizacion.getCiudad());
            txfiEstado.setText(organizacion.getEstado());
        }
    }

    public void clicBtnCancelar(ActionEvent actionEvent) {
        Stage stage = (Stage) txfiNombre.getScene().getWindow();
        stage.close();
    }

    public void clicBtnActualizar(ActionEvent actionEvent) {
        if (validarCampos()) {
            try {
                OrganizacionVinculada organizacionActualizada = new OrganizacionVinculada();
                organizacionActualizada.setId(organizacionVinculada.getId());
                organizacionActualizada.setNombre(txfiNombre.getText());
                organizacionActualizada.setSector(txfiSector.getText().trim());
                organizacionActualizada.setCorreo(txfiCorreo.getText().trim());
                organizacionActualizada.setTelefono(txFiTelefono.getText().trim());
                organizacionActualizada.setDireccion(txfiDireccion.getText().trim());
                organizacionActualizada.setCiudad(txfiCiudad.getText().trim());
                organizacionActualizada.setEstado(txfiEstado.getText().trim());

                boolean actualizado = OrganizacionVinculadaDAO.actualizar(organizacionActualizada);
                if (actualizado) {
                    Utilidad.crearAlerta(Alert.AlertType.INFORMATION,
                            "Organización vinculada actualizada exitosamente.",
                            "La organización vinculada ha sido actualizada correctamente.");
                    Stage stage = (Stage) txfiNombre.getScene().getWindow();
                    stage.close();
                } else {
                    Utilidad.crearAlerta(Alert.AlertType.ERROR,
                            "Error al actualizar organización vinculada.",
                            "No se pudo actualizar la organización vinculada. Intente nuevamente.");
                }
            } catch (SQLException e) {
                Utilidad.crearAlerta(Alert.AlertType.ERROR,
                        "No hay conexión con la base de datos",
                        "Se ha perdido la conexión con la base de datos.");
                e.printStackTrace();
            }
        }
    }

    private boolean validarCampos() {
        boolean camposValidos = true;
        if (txfiNombre.getText().isEmpty() || txfiSector.getText().isEmpty() || txfiCorreo.getText().isEmpty() ||
            txFiTelefono.getText().isEmpty() || txfiDireccion.getText().isEmpty() ||
            txfiCiudad.getText().isEmpty() || txfiEstado.getText().isEmpty()) {
            Utilidad.crearAlerta(Alert.AlertType.ERROR,
                    "Campos incompletos",
                    "Por favor, complete todos los campos requeridos.");
            camposValidos = false;
        }
        return camposValidos;
    }
}
