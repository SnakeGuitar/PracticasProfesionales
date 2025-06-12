package sgpp.controlador.usuarios.coordinador.organizacionvinculada;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.dao.OrganizacionVinculadaDAO;
import sgpp.utilidad.Utilidad;

import java.sql.SQLException;

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
                OrganizacionVinculada organizacion = new OrganizacionVinculada();
                organizacion.setNombre(txfiNombre.getText());
                organizacion.setSector(txfiSector.getText());
                organizacion.setTelefono(txFiTelefono.getText());
                organizacion.setCorreo(txfiCorreo.getText());
                organizacion.setDireccion(txfiDireccion.getText());
                organizacion.setCiudad(txfiCiudad.getText());
                organizacion.setEstado(txfiEstado.getText());
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