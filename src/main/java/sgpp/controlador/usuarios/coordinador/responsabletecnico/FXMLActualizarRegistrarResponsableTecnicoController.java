/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 16-06-2025
 * Descripción: Controlador FXML para registrar o actualizar un Responsable Técnico.
 *              Permite cargar organizaciones, llenar campos si es edición y guardar datos a través del DAO.
 */
/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 16-06-2025
 * Descripción: Controlador FXML para registrar o actualizar un Responsable Técnico.
 *              Permite cargar organizaciones, llenar campos si es edición y guardar datos a través del DAO.
 *
 *Actualizaciones:
 *                 implementa el uso de las utilidades generales de alerta.
 *                 verifica el formato de nombre y correo.
 */
package sgpp.controlador.usuarios.coordinador.responsabletecnico;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.beans.ResponsableTecnico;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.modelo.dao.entidades.ResponsableTecnicoDAO;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;
import java.util.regex.Pattern;

public class FXMLActualizarRegistrarResponsableTecnicoController implements Initializable {

    @FXML private TextField tfNombre;
    @FXML private TextField tfDepartamento;
    @FXML private TextField tfPuesto;
    @FXML private TextField tfCorreo;
    @FXML private ComboBox<OrganizacionVinculada> cbEmpresa;
    @FXML private Button btnGuardar;
    @FXML private Button btnCancelar;

    private ResponsableTecnico responsableActual;
    private ObservableList<OrganizacionVinculada> listaOrganizaciones;

    private static final Pattern PATRON_NOMBRE = Pattern.compile("^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$");
    private static final Pattern PATRON_CORREO = Pattern.compile("^[\\w.-]+@[\\w.-]+\\.[A-Za-z]{2,}$");

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarOrganizaciones();
        cbEmpresa.setConverter(new javafx.util.StringConverter<OrganizacionVinculada>() {
            @Override public String toString(OrganizacionVinculada ov) {
                return ov == null ? "" : ov.getNombre();
            }
            @Override public OrganizacionVinculada fromString(String s) { return null; }
        });
    }

    private void cargarOrganizaciones() {
        try {
            listaOrganizaciones = FXCollections.observableArrayList(
                    OrganizacionVinculadaDAO.obtenerIdYNombresOrganizaciones()
            );
            cbEmpresa.setItems(listaOrganizaciones);
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    public void setResponsableTecnico(ResponsableTecnico r) {
        this.responsableActual = r;
        if (r != null) {
            tfNombre.setText(r.getNombre());
            tfDepartamento.setText(r.getDepartamento());
            tfPuesto.setText(r.getPuesto());
            tfCorreo.setText(r.getCorreo());

            listaOrganizaciones.stream()
                    .filter(ov -> ov.getIdOrganizacionVinculada() == r.getIdOrganizacionVinculada())
                    .findFirst()
                    .ifPresent(ov -> cbEmpresa.getSelectionModel().select(ov));

            try {
                boolean tieneProyectos = ResponsableTecnicoDAO.tieneProyectosAsociados(r.getIdResponsable());
                cbEmpresa.setDisable(tieneProyectos);
            } catch (SQLException e) {
                Utilidad.mostrarError(true, e,
                        "Error al verificar proyectos",
                        "No se pudo verificar si el responsable tiene proyectos."
                );
            }
        }
    }

    @FXML
    private void clicBtnGuardar(ActionEvent event) {

        if (!verificarCamposVacios()) return;
        String nombre = tfNombre.getText().trim();
        String depto = tfDepartamento.getText().trim();
        String puesto = tfPuesto.getText().trim();
        String correo = tfCorreo.getText().trim();
        OrganizacionVinculada org = cbEmpresa.getSelectionModel().getSelectedItem();

        if (nombre.isEmpty() || depto.isEmpty() || puesto.isEmpty() || correo.isEmpty() || org == null) {
            Utilidad.crearAlertaError("Campos incompletos", "Por favor, completa todos los campos.");
            return;
        }

        if (!verificarNombre(nombre)) {
            Utilidad.crearAlertaError("Nombre inválido", "El nombre sólo puede contener letras y espacios.");
            return;
        }

        if (!verificarCorreo(correo)) {
            Utilidad.crearAlertaError("Correo inválido", "Ingresa un correo con formato válido (ej: usuario@dominio.com).");
            return;
        }

        try {
            if (responsableActual == null) {
                ResponsableTecnico nuevo = new ResponsableTecnico();
                nuevo.setNombre(nombre);
                nuevo.setDepartamento(depto);
                nuevo.setPuesto(puesto);
                nuevo.setCorreo(correo);
                nuevo.setIdOrganizacionVinculada(org.getIdOrganizacionVinculada());

                if (ResponsableTecnicoDAO.insertar(nuevo)) {
                    Utilidad.crearAlertaInformacion("Éxito", "Responsable registrado correctamente.");
                    cerrarVentana();
                } else {
                    Utilidad.crearAlertaError("Error", "No se pudo registrar el responsable.");
                }
            } else {
                responsableActual.setNombre(nombre);
                responsableActual.setDepartamento(depto);
                responsableActual.setPuesto(puesto);
                responsableActual.setCorreo(correo);
                if (!cbEmpresa.isDisabled()) {
                    responsableActual.setIdOrganizacionVinculada(org.getIdOrganizacionVinculada());
                }

                if (ResponsableTecnicoDAO.actualizar(responsableActual)) {
                    Utilidad.crearAlertaInformacion("Éxito", "Responsable actualizado correctamente.");
                    cerrarVentana();
                } else {
                    Utilidad.crearAlertaError("Error", "No se pudo actualizar el responsable.");
                }
            }
        } catch (SQLException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    @FXML
    private void clicBtnCancelar(ActionEvent event) {
        if (Utilidad.confirmarCancelar()) {
            cerrarVentana();
        }
    }

    private void cerrarVentana() {
        btnCancelar.getScene().getWindow().hide();
    }

    private boolean verificarNombre(String nombre) {
        return PATRON_NOMBRE.matcher(nombre).matches();
    }

    private boolean verificarCorreo(String correo) {
        return PATRON_CORREO.matcher(correo).matches();
    }
    private boolean verificarCamposVacios() {
        if (tfNombre.getText().trim().isEmpty() ||
                tfDepartamento.getText().trim().isEmpty() ||
                tfPuesto.getText().trim().isEmpty() ||
                tfCorreo.getText().trim().isEmpty() ||
                cbEmpresa.getSelectionModel().getSelectedItem() == null) {
            Utilidad.crearAlertaError("Campos vacíos", "Por favor, completa todos los campos obligatorios.");
            return false;
        }
        return true;
    }

}
