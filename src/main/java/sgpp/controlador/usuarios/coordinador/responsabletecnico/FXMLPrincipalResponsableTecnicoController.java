package sgpp.controlador.usuarios.coordinador.responsabletecnico;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.util.StringConverter;
import sgpp.modelo.beans.OrganizacionVinculada;
import sgpp.modelo.beans.ResponsableTecnico;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.modelo.dao.entidades.ResponsableTecnicoDAO;
import sgpp.utilidad.Utilidad;

public class FXMLPrincipalResponsableTecnicoController implements Initializable {

    @FXML
    private TextField tfFiltroNombre;
    @FXML
    private ComboBox<OrganizacionVinculada> cbFiltroOV;
    @FXML
    private TableView<ResponsableTecnico> tblResponsable;
    @FXML
    private TableColumn<ResponsableTecnico, Integer> colId;
    @FXML
    private TableColumn<ResponsableTecnico, String> colNombre;
    @FXML
    private TableColumn<ResponsableTecnico, String> colDepartamento;
    @FXML
    private TableColumn<ResponsableTecnico, String> colPuesto;
    @FXML
    private TableColumn<ResponsableTecnico, String> colCorreo;
    @FXML
    private TableColumn<ResponsableTecnico, String> colIdOrgVinculada;

    private ObservableList<ResponsableTecnico> listaResponsables;
    private ObservableList<OrganizacionVinculada> listaOVs;
    private FilteredList<ResponsableTecnico> responsablesFiltrados;
    private Map<Integer, String> mapaIdANombreOV;  // <ID, Nombre de OV>

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // Configurar columnas
        colNombre.setCellValueFactory(cellData -> 
            new SimpleStringProperty(cellData.getValue().getNombre())
        );
        colDepartamento.setCellValueFactory(cellData -> 
            new SimpleStringProperty(cellData.getValue().getDepartamento())
        );
        colPuesto.setCellValueFactory(cellData -> 
            new SimpleStringProperty(cellData.getValue().getPuesto())
        );
        colCorreo.setCellValueFactory(cellData -> 
            new SimpleStringProperty(cellData.getValue().getCorreo())
        );
        colId.setCellValueFactory(cellData -> 
            new javafx.beans.property.SimpleIntegerProperty(cellData.getValue().getIdResponsable()).asObject()
        );

        // Por medio del metodo cargarOrganizacionesVinculadas carga el nombre atravez de la id.
        colIdOrgVinculada.setCellValueFactory(cellData -> {
            int idOV = cellData.getValue().getIdOrganizacionVinculada();
            String nombreOV = mapaIdANombreOV.getOrDefault(idOV, "Desconocido");
            return new SimpleStringProperty(nombreOV);
        });

        cargarOrganizacionesVinculadas();
        cargarResponsables();

        responsablesFiltrados = new FilteredList<>(listaResponsables, p -> true);

        tfFiltroNombre.textProperty().addListener((observable, oldValue, newValue) -> aplicarFiltros());
        cbFiltroOV.valueProperty().addListener((obs, oldVal, newVal) -> aplicarFiltros());

        tblResponsable.setItems(responsablesFiltrados);

        cbFiltroOV.setConverter(new StringConverter<OrganizacionVinculada>() {
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

    private void cargarOrganizacionesVinculadas() {
        try {
            ArrayList<OrganizacionVinculada> ovList = OrganizacionVinculadaDAO.obtenerIdYNombresOrganizaciones();
            listaOVs = FXCollections.observableArrayList();
            listaOVs.add(new OrganizacionVinculada(0, "Todos", "", "", "", "", "", ""));
            listaOVs.addAll(ovList);
            cbFiltroOV.setItems(listaOVs);
            cbFiltroOV.getSelectionModel().selectFirst();

            // Llenar el mapa de ID → Nombre
            mapaIdANombreOV = new HashMap<>();
            for (OrganizacionVinculada ov : ovList) {
                mapaIdANombreOV.put(ov.getId(), ov.getNombre());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void cargarResponsables() {
        try {
            List<ResponsableTecnico> responsables = ResponsableTecnicoDAO.obtenerResponsables();
            listaResponsables = FXCollections.observableArrayList(responsables);
        } catch (SQLException e) {
            e.printStackTrace();
            listaResponsables = FXCollections.observableArrayList();
        }
    }

    private void aplicarFiltros() {
        String filtroNombre = tfFiltroNombre.getText().toLowerCase().trim();
        OrganizacionVinculada filtroOV = cbFiltroOV.getValue();

        responsablesFiltrados.setPredicate(responsable -> {
            boolean cumpleNombre = responsable.getNombre().toLowerCase().contains(filtroNombre);
            boolean cumpleOV = (filtroOV == null || filtroOV.getId() == 0) || responsable.getIdOrganizacionVinculada() == filtroOV.getId();
            return cumpleNombre && cumpleOV;
        });
    }

    @FXML
    private void clicBtnRegistrarResponsable(ActionEvent event) {
          mostrarFormulario(null);
    }

    @FXML
    private void clicBtnActualizarResponsable(ActionEvent event) {
        
    ResponsableTecnico seleccionado = tblResponsable.getSelectionModel().getSelectedItem();
    if (seleccionado != null) {
        mostrarFormulario(seleccionado);
    } else {
        // Mostrar mensaje o alerta que debe seleccionar un responsable
               Utilidad.crearAlertaInformacion("Selección requerida", "Por favor, selecciona un responsable técnico.");

    }
    }

 

@FXML
private void clicBtnEliminarResponsable(ActionEvent event) {
    ResponsableTecnico seleccionado = tblResponsable.getSelectionModel().getSelectedItem();

    if (seleccionado == null) {
        Utilidad.crearAlertaInformacion("Selección requerida", "Por favor, selecciona un responsable técnico.");
        return;
    }

    try {
        boolean tieneProyectos = ResponsableTecnicoDAO.tieneProyectosAsociados(seleccionado.getIdResponsable());

        if (tieneProyectos) {
            Utilidad.crearAlertaInformacion("Acción no permitida",
                    "El responsable técnico tiene proyectos asignados y no puede ser eliminado.");
            return;
        }

        boolean confirmado = Utilidad.crearAlertaConfirmacion("Confirmar eliminación",
                "¿Estás seguro de eliminar al responsable técnico seleccionado?");
        if (!confirmado) {
            return;
        }

        boolean eliminado = ResponsableTecnicoDAO.eliminar(seleccionado.getIdResponsable());
        if (eliminado) {
            Utilidad.crearAlertaInformacion("Eliminado", "El responsable técnico fue eliminado exitosamente.");
            cargarResponsables();
            responsablesFiltrados = new FilteredList<>(listaResponsables, p -> true);
            aplicarFiltros();
            tblResponsable.setItems(responsablesFiltrados);
        } else {
            Utilidad.crearAlertaError("Error", "No se pudo eliminar al responsable técnico.");
        }

    } catch (SQLException ex) {
        Utilidad.mostrarErrorBD(ex, true);
    }
}


    
    private void mostrarFormulario(ResponsableTecnico responsable) {
    try {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/sgpp/vista/usuarios/coordinador/responsabletecnico/FXMLActualizarRegistrarResponsableTecnico.fxml"));
        Parent root = loader.load();

        FXMLActualizarRegistrarResponsableTecnicoController controller = loader.getController();

        // Si responsable es null, es registro nuevo
        controller.setResponsableTecnico(responsable);

        Stage stage = new Stage();
        stage.setTitle(responsable == null ? "Registrar Responsable Técnico" : "Actualizar Responsable Técnico");
        stage.initModality(Modality.APPLICATION_MODAL); 
        stage.setScene(new Scene(root));
        stage.showAndWait();

       
        cargarResponsables();
        responsablesFiltrados = new FilteredList<>(listaResponsables, p -> true);
        aplicarFiltros();
        tblResponsable.setItems(responsablesFiltrados);

    } catch (IOException ex) {
        ex.printStackTrace();
    }
}
}



