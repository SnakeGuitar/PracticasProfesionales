package sgpp.controlador.usuarios.profesor;

import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.stage.Stage;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.expediente.Documento;
import sgpp.modelo.beans.expediente.EstadoDocumento;
import sgpp.modelo.beans.expediente.documentofinal.DocumentoFinal;
import sgpp.modelo.beans.expediente.documentofinal.EntregaDocumentoFinal;
import sgpp.modelo.beans.expediente.documentoinicial.DocumentoInicial;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoparcial.DocumentoParcial;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.expediente.TipoDocumento;
import sgpp.modelo.dao.expediente.documentofinal.DocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentofinal.EntregaDocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentoinicial.DocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoinicial.EntregaDocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.DocumentoParcialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaDocumentoParcialDAO;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

public class FXMLValidarDocumentoController implements Initializable {
    public Label lblDocumentosActuales;
    @FXML
    private TableView<Documento> tblEntregas;
    @FXML
    private TableColumn<Documento, String> colEstudiante;
    @FXML
    private TableColumn<Documento, String> colDocumento;
    @FXML
    private TableColumn<Documento, String> colFechaEntrega;
    @FXML
    private TableColumn<Documento, String> colEstado;
    @FXML
    private Label lbNombreProfesor;

    private static final int ID_PERIODO = 4;
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    private ObservableList<Documento> datosDocumentos = FXCollections.observableArrayList();
    private Map<Integer, String> mapa_estudiantes = new HashMap<>();
    private TipoDocumento tipoDocumentoActual = TipoDocumento.INICIAL;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        cargarMapaEstudiantes();
        configurarTablaEntregas();
        cargarDocumentosIniciales();
    }

    private void cargarMapaEstudiantes() {
        try {
            for (Estudiante estudiante : EstudianteDAO.obtenerEstudiantes()) {
                mapa_estudiantes.put(estudiante.getIdEstudiante(), estudiante.getNombre());
            }
        } catch (SQLException e) {
            Utilidad.crearAlertaError(
                    "Error al cargar estudiantes",
                    "No se pudieron cargar los estudiantes desde la base de datos. Por favor, intente más tarde.");
        }
    }

    private void configurarTablaEntregas() {
        colEstudiante.setCellValueFactory(cellData -> {
            Documento doc = cellData.getValue();
            String nombreEstudiante = obtenerNombreEstudiante(doc.getIdEntregaDocumento());
            return new SimpleStringProperty(nombreEstudiante != null ? nombreEstudiante : "Desconocido");
        });

        colDocumento.setCellValueFactory(cellData -> {
            Documento doc = cellData.getValue();
            String tipoDoc = doc.getTipoDocumento() != null ?
                    doc.getTipoDocumento().toString() : "Sin tipo";
            return new SimpleStringProperty(tipoDoc);
        });

        colFechaEntrega.setCellValueFactory(cellData -> {
            Documento doc = cellData.getValue();
            String fecha = doc.getFechaEntrega() != null ?
                    doc.getFechaEntrega().format(TIME_FORMATTER) : "No entregado";
            return new SimpleStringProperty(fecha);
        });

        colEstado.setCellValueFactory(cellData -> {
            Documento doc = cellData.getValue();
            String estado = doc.getEstado() != null ?
                    doc.getEstado().toString() : "Sin estado";
            return new SimpleStringProperty(estado);
        });

        tblEntregas.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
    }

    private String obtenerNombreEstudiante(int idEntregaDocumento) {
        try {
            int idEstudiante = 0;

            switch (tipoDocumentoActual) {
                case INICIAL:
                    EntregaDocumentoInicial entregaInicial = EntregaDocumentoInicialDAO
                            .obtenerEntregaDocumentoInicial(idEntregaDocumento);
                    if (entregaInicial != null) {
                        idEstudiante = entregaInicial.getIdEstudiante();
                    }
                    break;

                case PARCIAL:
                    EntregaDocumentoParcial entregaParcial = EntregaDocumentoParcialDAO
                            .obtenerEntregaDocumentoParcial(idEntregaDocumento);
                    if (entregaParcial != null) {
                        idEstudiante = entregaParcial.getIdEstudiante();
                    }
                    break;

                case FINAL:
                    EntregaDocumentoFinal entregaFinal = EntregaDocumentoFinalDAO
                            .obtenerEntregaDocumentoFinal(idEntregaDocumento);
                    if (entregaFinal != null) {
                        idEstudiante = entregaFinal.getIdEstudiante();
                    }
                    break;
            }

            return mapa_estudiantes.getOrDefault(idEstudiante, "Desconocido");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Desconocido";
    }

    public void clicBtnActualizarLista(ActionEvent actionEvent) {
        switch (tipoDocumentoActual) {
            case INICIAL:
                cargarDocumentosIniciales();
                break;
            case PARCIAL:
                cargarDocumentosParciales();
                break;
            case FINAL:
                cargarDocumentosFinales();
                break;
        }
        Utilidad.crearAlertaInformacion(
                "Lista actualizada",
                "Los documentos se han actualizado correctamente.");
    }

    public void clicBtnValidar(ActionEvent actionEvent) {
        Documento documentoSeleccionado = tblEntregas.getSelectionModel().getSelectedItem();

        if (documentoSeleccionado == null) {
            Utilidad.crearAlertaAdvertencia(
                    "Selección de documento",
                    "Por favor, seleccione un documento de la lista para validar.");
            return;
        }

        if (documentoSeleccionado.getEstado() != EstadoDocumento.Entregado) {
            Utilidad.crearAlertaAdvertencia(
                    "Documento no válido",
                    "El documento seleccionado no está en estado 'Entregado'. No se puede validar.");
            return;
        }

        Alert confirmacion = new Alert(Alert.AlertType.CONFIRMATION);
        confirmacion.setTitle("Confirmar validación");
        confirmacion.setHeaderText("¿Está seguro de validar este documento?");
        confirmacion.setContentText("Esta acción cambiará el estado del documento a 'Aceptado'");

        if (confirmacion.showAndWait().get() == ButtonType.OK) {
            documentoSeleccionado.setEstado(EstadoDocumento.Aceptado);

            Utilidad.crearAlertaInformacion(
                    "Documento validado",
                    "El documento ha sido validado y su estado ha sido actualizado a 'Aceptado'.");
            clicBtnActualizarLista(null);
        }
    }

    public void clicBtnRechazar(ActionEvent actionEvent) {
        Documento documentoSeleccionado = tblEntregas.getSelectionModel().getSelectedItem();

        if (documentoSeleccionado == null) {
            Utilidad.crearAlertaAdvertencia(
                    "Selección de documento",
                    "Por favor, seleccione un documento de la lista para rechazar.");
            return;
        }

        if (documentoSeleccionado.getEstado() != EstadoDocumento.Entregado) {
            Utilidad.crearAlertaAdvertencia(
                    "Documento no válido",
                    "El documento seleccionado no está en estado 'Entregado'. No se puede rechazar.");
            return;
        }

        TextInputDialog dialog = new TextInputDialog();
        dialog.setTitle("Rechazar documento");
        dialog.setHeaderText("Ingrese la razón del rechazo:");
        dialog.setContentText("Razón:");

        dialog.showAndWait().ifPresent(razon -> {
            if (razon.trim().isEmpty()) {
                Utilidad.crearAlertaAdvertencia(
                        "Razón de rechazo vacía",
                        "Por favor, ingrese una razón válida para el rechazo del documento.");
                return;
            }

            documentoSeleccionado.setEstado(EstadoDocumento.Rechazado);

            Utilidad.crearAlertaInformacion(
                    "Documento rechazado",
                    "El documento ha sido rechazado y su estado ha sido actualizado a 'Rechazado'. Razón: " + razon);
            clicBtnActualizarLista(null);
        });
    }

    public void clicBtnCancelar(ActionEvent actionEvent) {
        Stage stage = (Stage) tblEntregas.getScene().getWindow();
        if (Utilidad.confirmarCancelar()) {
            stage.close();
        } else {
            Utilidad.crearAlertaInformacion(
                    "Operación cancelada",
                    "La operación ha sido cancelada. No se realizaron cambios.");
        }
    }

    public void clicBtnVerIniciales(ActionEvent actionEvent) {
        tipoDocumentoActual = TipoDocumento.INICIAL;
        cargarDocumentosIniciales();
        actualizarTituloTabla("Documentos Iniciales");
    }

    public void clicBtnVerParciales(ActionEvent actionEvent) {
        tipoDocumentoActual = TipoDocumento.PARCIAL;
        cargarDocumentosParciales();
        actualizarTituloTabla("Documentos Parciales");
    }

    public void clicBtnVerFinales(ActionEvent actionEvent) {
        tipoDocumentoActual = TipoDocumento.FINAL;
        cargarDocumentosFinales();
        actualizarTituloTabla("Documentos Finales");
    }

    private void cargarDocumentosIniciales() {
        try {

            datosDocumentos.clear();
            List<DocumentoInicial> documentos = DocumentoInicialDAO
                    .obtenerDocumentosInicialesPorPeriodo(ID_PERIODO);

            // Filtrar solo documentos en estado Entregado
            for (DocumentoInicial doc : documentos) {
                if (doc.getEstado() == EstadoDocumento.Entregado) {
                    datosDocumentos.add(doc);
                }
            }

            tblEntregas.setItems(datosDocumentos);

        } catch (SQLException e) {
            Utilidad.crearAlertaError(
                    "Error al cargar documentos iniciales",
                    "No se pudieron cargar los documentos iniciales desde la base de datos. Por favor, intente más tarde.");
        }
    }

    private void cargarDocumentosParciales() {
        try {
            datosDocumentos.clear();
            List<DocumentoParcial> documentos = DocumentoParcialDAO
                    .obtenerDocumentosParcialesPorPeriodo(ID_PERIODO);

            // Filtrar solo documentos en estado Entregado
            for (DocumentoParcial doc : documentos) {
                if (doc.getEstado() == EstadoDocumento.Entregado) {
                    datosDocumentos.add(doc);
                }
            }

            tblEntregas.setItems(datosDocumentos);
            actualizarTituloTabla("Documentos Parciales");

        } catch (SQLException e) {
            Utilidad.crearAlertaError(
                    "Error al cargar documentos parciales",
                    "No se pudieron cargar los documentos parciales desde la base de datos. Por favor, intente más tarde.");
        }
    }

    private void cargarDocumentosFinales() {
        try {
            datosDocumentos.clear();
            List<DocumentoFinal> documentos = DocumentoFinalDAO
                    .obtenerDocumentosFinalesPorPeriodo(ID_PERIODO);

            // Filtrar solo documentos en estado Entregado
            for (DocumentoFinal doc : documentos) {
                if (doc.getEstado() == EstadoDocumento.Entregado) {
                    datosDocumentos.add(doc);
                }
            }

            tblEntregas.setItems(datosDocumentos);
            actualizarTituloTabla("Documentos Finales");

        } catch (SQLException e) {
            Utilidad.crearAlertaError(
                    "Error al cargar documentos finales",
                    "No se pudieron cargar los documentos finales desde la base de datos. Por favor, intente más tarde.");
        }
    }


    private void actualizarTituloTabla(String titulo) {
        lblDocumentosActuales.setText(titulo);
    }
}