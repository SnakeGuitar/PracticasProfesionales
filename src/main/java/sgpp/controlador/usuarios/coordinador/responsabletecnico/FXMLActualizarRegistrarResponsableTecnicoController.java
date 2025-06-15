package sgpp.controlador.usuarios.coordinador.responsabletecnico;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.beans.ResponsableTecnico;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.modelo.dao.entidades.ResponsableTecnicoDAO;

import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class FXMLActualizarRegistrarResponsableTecnicoController implements Initializable {

    @FXML private TextField tfNombre;
    @FXML private TextField tfDepartamento;
    @FXML private TextField tfPuesto;
    @FXML private TextField tfCorreo;
    @FXML private ComboBox<OrganizacionVinculada> cbEmpresa;
    @FXML private Button btnGuardar;
    @FXML private Button btnCancelar;

    private ResponsableTecnico responsableActual;  // null si es nuevo
    private ObservableList<OrganizacionVinculada> listaOrganizaciones;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarOrganizaciones();

        cbEmpresa.setConverter(new javafx.util.StringConverter<OrganizacionVinculada>() {
            @Override
            public String toString(OrganizacionVinculada ov) {
                return ov == null ? "" : ov.getNombre();
            }

            @Override
            public OrganizacionVinculada fromString(String string) {
                return null;
            }
        });
    }

    private void cargarOrganizaciones() {
        try {
            listaOrganizaciones = FXCollections.observableArrayList(
                    OrganizacionVinculadaDAO.obtenerIdYNombresOrganizaciones()
            );
            cbEmpresa.setItems(listaOrganizaciones);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void setResponsableTecnico(ResponsableTecnico r) {
        this.responsableActual = r;
        if (r != null) {
            tfNombre.setText(r.getNombre());
            tfDepartamento.setText(r.getDepartamento());
            tfPuesto.setText(r.getPuesto());
            tfCorreo.setText(r.getCorreo());

            for (OrganizacionVinculada ov : listaOrganizaciones) {
                if (ov.getId() == r.getIdOrganizacionVinculada()) {
                    cbEmpresa.getSelectionModel().select(ov);
                    break;
                }
            }

            // Verificar si tiene proyectos asociados y desactivar ComboBox si es así
            try {
                boolean tieneProyectos = ResponsableTecnicoDAO.tieneProyectosAsociados(r.getIdResponsable());
                cbEmpresa.setDisable(tieneProyectos);
            } catch (SQLException e) {
                e.printStackTrace();
                mostrarAlerta("Error", "No se pudo verificar si el responsable tiene proyectos.");
            }
        }
    }

    @FXML
    private void clicBtnGuardar(ActionEvent event) {
        if (tfNombre.getText().isEmpty() || tfDepartamento.getText().isEmpty() ||
            tfPuesto.getText().isEmpty() || tfCorreo.getText().isEmpty() ||
            cbEmpresa.getSelectionModel().getSelectedItem() == null) {
            mostrarAlerta("Error", "Por favor, completa todos los campos.");
            return;
        }

        try {
            if (responsableActual == null) {
                ResponsableTecnico nuevo = new ResponsableTecnico();
                nuevo.setNombre(tfNombre.getText());
                nuevo.setDepartamento(tfDepartamento.getText());
                nuevo.setPuesto(tfPuesto.getText());
                nuevo.setCorreo(tfCorreo.getText());
                nuevo.setIdOrganizacionVinculada(cbEmpresa.getSelectionModel().getSelectedItem().getId());

                boolean exito = ResponsableTecnicoDAO.insertar(nuevo);
                if (exito) {
                    mostrarAlerta("Éxito", "Responsable registrado correctamente.");
                    cerrarVentana();
                } else {
                    mostrarAlerta("Error", "No se pudo registrar el responsable.");
                }
            } else {
                responsableActual.setNombre(tfNombre.getText());
                responsableActual.setDepartamento(tfDepartamento.getText());
                responsableActual.setPuesto(tfPuesto.getText());
                responsableActual.setCorreo(tfCorreo.getText());

                // Solo cambiar la empresa si el ComboBox está habilitado
                if (!cbEmpresa.isDisabled()) {
                    responsableActual.setIdOrganizacionVinculada(
                        cbEmpresa.getSelectionModel().getSelectedItem().getId()
                    );
                }

                boolean exito = ResponsableTecnicoDAO.actualizar(responsableActual);
                if (exito) {
                    mostrarAlerta("Éxito", "Responsable actualizado correctamente.");
                    cerrarVentana();
                } else {
                    mostrarAlerta("Error", "No se pudo actualizar el responsable.");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            mostrarAlerta("Error", "Ocurrió un error en la base de datos.");
        }
    }

    @FXML
    private void clicBtnCancelar(ActionEvent event) {
        cerrarVentana();
    }

    private void cerrarVentana() {
        btnCancelar.getScene().getWindow().hide();
    }

    private void mostrarAlerta(String titulo, String mensaje) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(titulo);
        alert.setHeaderText(null);
        alert.setContentText(mensaje);
        alert.showAndWait();
    }
}
