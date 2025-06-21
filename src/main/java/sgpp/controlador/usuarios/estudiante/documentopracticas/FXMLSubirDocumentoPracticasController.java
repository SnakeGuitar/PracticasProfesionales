/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 13-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 19-06-2025
 * Descripción: Clase controller para subir documentos de prácticas
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador.usuarios.estudiante.documentopracticas;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import sgpp.modelo.beans.Periodo;
import sgpp.modelo.beans.expediente.EstadoDocumento;
import sgpp.modelo.beans.expediente.documentofinal.DocumentoFinal;
import sgpp.modelo.beans.expediente.documentofinal.EntregaDocumentoFinal;
import sgpp.modelo.beans.expediente.documentofinal.TipoDocumentoFinal;
import sgpp.modelo.beans.expediente.documentoinicial.DocumentoInicial;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoinicial.TipoDocumentoInicial;
import sgpp.modelo.beans.expediente.documentoparcial.DocumentoParcial;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;
import sgpp.modelo.beans.expediente.documentoparcial.TipoDocumentoParcial;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.expediente.TipoDocumento;
import sgpp.modelo.dao.expediente.documentofinal.DocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentofinal.EntregaDocumentoFinalDAO;
import sgpp.modelo.dao.expediente.documentoinicial.DocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoinicial.EntregaDocumentoInicialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.DocumentoParcialDAO;
import sgpp.modelo.dao.expediente.documentoparcial.EntregaDocumentoParcialDAO;
import sgpp.utilidad.Utilidad;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class FXMLSubirDocumentoPracticasController implements javafx.fxml.Initializable {

    @FXML
    private Label nombreArchivoDocumento;

    @FXML
    private Button btnCartaAceptacion;

    @FXML
    private Button btnCronograma;

    @FXML
    private Button btnOficioAsignacion;

    @FXML
    private Button btnHorarioUV;

    @FXML
    private Button btnConstanciaSeguro;

    @FXML
    private Label lblFechas;

    @FXML
    private Label lblFechas1;

    @FXML
    private Button btnReporteParcial;

    @FXML
    private Button btnEvaluacionParcialOV;

    @FXML
    private Label lblFechas2;

    @FXML
    private Button btnReporteFinal;

    @FXML
    private Button btnAutoevaluacion;

    @FXML
    private Button btnEvaluacionFinalOV;

    @FXML
    private Button btnCartaLiberacion;

    @FXML
    private Label lblFechas3;

    private static final DateTimeFormatter FORMATO_FECHA = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    private final int ID_ESTUDIANTE = 4;
    private int idPeriodoActual;

    private TipoDocumento tipoDocumentoSeleccionado;
    private File archivoSeleccionado;
    private Object entregaSeleccionada;
    private Enum<?> tipoEspecificoSeleccionado;

    @Override
    public void initialize(java.net.URL url, java.util.ResourceBundle rb) {
        // Inicialización de la vista para subir documentos de prácticas
        configurarInterfazInicial();
        cargarPeriodo();
    }

    private void cargarEstudiante() {
        //TODO
        //Cargar el estudiante desde la sesión actual en la pantalla principal de estudiante
    }

    private void cargarPeriodo() {
        try {
            Periodo periodo = PeriodoDAO.obtenerPeriodoActual();
            if (periodo != null) {
                this.idPeriodoActual = periodo.getIdPeriodo();
            } else {
                Utilidad.crearAlertaAdvertencia("Sin período",
                        "No se encontro un periodo activo.");
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    @FXML
    public void clicBtnEntregarDocumento(ActionEvent actionEvent) {
        subirReporte(actionEvent);
    }

    @FXML
    public void clicBtnSeleccionarDocumento(ActionEvent actionEvent) {
        seleccionarPDF(actionEvent);
    }

    @FXML
    public void btnCartaAceptacion(ActionEvent actionEvent) {
        manejarDocumentoInicial(TipoDocumentoInicial.CartaAceptacion);
    }

    @FXML
    public void btnCronograma(ActionEvent actionEvent) {
        manejarDocumentoInicial(TipoDocumentoInicial.Cronograma);
    }

    @FXML
    public void btnOficioAsignacion(ActionEvent actionEvent) {
        manejarDocumentoInicial(TipoDocumentoInicial.OficioAsignacion);
    }

    @FXML
    public void btnHorarioUV(ActionEvent actionEvent) {
        manejarDocumentoInicial(TipoDocumentoInicial.HorarioUV);
    }

    @FXML
    public void btnConstanciaSeguro(ActionEvent actionEvent) {
        manejarDocumentoInicial(TipoDocumentoInicial.ConstanciaSeguro);
    }

    @FXML
    public void btnReporteParcial(ActionEvent actionEvent) {
        manejarDocumentoParcial(TipoDocumentoParcial.REPORTE_PARCIAL);
    }

    @FXML
    public void btnEvaluacionParcialOV(ActionEvent actionEvent) {
        manejarDocumentoParcial(TipoDocumentoParcial.EVALUACION_PARCIAL_POR_OV);
    }

    @FXML
    public void btnReporteFinal(ActionEvent actionEvent) {
        manejarDocumentoFinal(TipoDocumentoFinal.REPORTE_FINAL);
    }

    @FXML
    public void btnAutoevaluacion(ActionEvent actionEvent) {
        manejarDocumentoFinal(TipoDocumentoFinal.AUTOEVALUACION);
    }

    @FXML
    public void btnEvaluacionFinalOV(ActionEvent actionEvent) {
        manejarDocumentoFinal(TipoDocumentoFinal.EVALUACION_FINAL_POR_OV);
    }

    @FXML
    public void btnCartaLiberacion(ActionEvent actionEvent) {
        manejarDocumentoFinal(TipoDocumentoFinal.CARTA_LIBERACION);
    }

    public void seleccionarPDF(ActionEvent actionEvent) {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Seleccionar archivo PDF");
        fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("Archivos PDF", "*.pdf"));
        File archivo = fileChooser.showOpenDialog(null);
        if (archivo != null) {
            archivoSeleccionado = archivo;
            nombreArchivoDocumento.setText("Seleccionado: " + archivo.getName());
        } else {
            nombreArchivoDocumento.setText("No se ha seleccionado ningún archivo");
        }
    }

    @FXML
    private void subirReporte(ActionEvent event) {
        //TODO mover a CU subir reporte
        // Validaciones preliminares
        if (entregaSeleccionada == null) {
            Utilidad.crearAlertaAdvertencia("Sin entrega",
                    "Primero selecciona un documento abierto.");
            return;
        }

        if (archivoSeleccionado == null) {
            Utilidad.crearAlertaAdvertencia("Sin archivo",
                    "Selecciona un archivo PDF.");
            return;
        }

        try {
            // Verificar si ya existe el documento
            if (yaExisteDocumentoEspecifico()) {
                Utilidad.crearAlertaAdvertencia("Ya entregado",
                        "Ya has entregado este documento.");
                return;
            }

            // Leer el archivo PDF
            byte[] pdf = Files.readAllBytes(archivoSeleccionado.toPath());

            // Validar tamaño del archivo (máximo 10MB)
            if (pdf.length > 10 * 1024 * 1024) {
                Utilidad.crearAlertaAdvertencia("Archivo muy grande",
                        "El archivo no debe superar los 10MB.");
                return;
            }

            // Subir según el tipo de documento
            boolean exito = false;
            switch (tipoDocumentoSeleccionado) {
                case INICIAL:
                    exito = subirDocumentoInicial(pdf);
                    break;
                case PARCIAL:
                    exito = subirDocumentoParcial(pdf);
                    break;
                case FINAL:
                    exito = subirDocumentoFinal(pdf);
                    break;
            }

            if (exito) {
                Utilidad.crearAlertaInformacion("Éxito", "Documento subido correctamente.");
                limpiarFormulario();
                actualizarEstadoBotones();
            } else {
                Utilidad.crearAlertaAdvertencia("Fallo", "No se pudo subir el documento.");
            }

        } catch (IOException ex) {
            Utilidad.crearAlertaError("Error al leer archivo",
                    "No se pudo leer el archivo PDF: " + ex.getMessage());
        } catch (SQLException ex) {
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    private void manejarDocumentoInicial(TipoDocumentoInicial tipo) {
        try {
            System.out.println("ID Estudiante: " + ID_ESTUDIANTE);
            System.out.println("ID Periodo Actual: " + idPeriodoActual);
            EntregaDocumentoInicial entrega = EntregaDocumentoInicialDAO.obtenerEntregaDisponible(ID_ESTUDIANTE, idPeriodoActual);
            if (entrega != null) {
                DocumentoInicial documento = DocumentoInicialDAO.obtenerDocumentoInicialPorTipo(entrega.getIdEntregaDocumentoInicial(), tipo);
                if (documento != null) {
                    Utilidad.crearAlertaAdvertencia("Ya entregado",
                            "Ya has entregado este documento: " + tipo.name());
                } else {
                    if (validarVentanaEntrega(entrega.getFechaApertura(), entrega.getFechaLimite())) {
                        entregaSeleccionada = entrega;
                        tipoDocumentoSeleccionado = TipoDocumento.INICIAL;
                        tipoEspecificoSeleccionado = tipo;
                        Utilidad.crearAlertaInformacion(
                                "Entrega disponible",
                                "Puedes entregar el documento: " + tipo.name());
                        actualizarInterfaz(entrega.getFechaApertura(), entrega.getFechaLimite());
                    }
                }
            } else {
                Utilidad.crearAlertaAdvertencia(
                        "Error",
                        "No hay una fecha de entrega programada para entregar tus documentos iniciales.");
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    private void manejarDocumentoParcial(TipoDocumentoParcial tipo) {
        try {
            System.out.println("ID Estudiante: " + ID_ESTUDIANTE);
            System.out.println("ID Periodo Actual: " + idPeriodoActual);
            EntregaDocumentoParcial entrega = EntregaDocumentoParcialDAO.obtenerEntregaDisponible(ID_ESTUDIANTE, idPeriodoActual);
            if (entrega != null) {
                DocumentoParcial documento = DocumentoParcialDAO.obtenerDocumentoParcialPorTipo(entrega.getIdEntregaDocumentoParcial(), tipo);
                if (documento != null) {
                    Utilidad.crearAlertaAdvertencia("Ya entregado",
                            "Ya has entregado este documento: " + tipo.name());
                } else {
                    if (validarVentanaEntrega(entrega.getFechaApertura(), entrega.getFechaLimite())) {
                        entregaSeleccionada = entrega;
                        tipoDocumentoSeleccionado = TipoDocumento.PARCIAL;
                        tipoEspecificoSeleccionado = tipo;
                        Utilidad.crearAlertaInformacion(
                                "Entrega disponible",
                                "Puedes entregar el documento: " + tipo.name());
                        actualizarInterfaz(entrega.getFechaApertura(), entrega.getFechaLimite());
                    }
                }
            } else {
                Utilidad.crearAlertaAdvertencia(
                        "Error",
                        "No hay una fecha de entrega programada para entregar tus documentos parciales.");
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    private void manejarDocumentoFinal(TipoDocumentoFinal tipo) {
        try {
            System.out.println("ID Estudiante: " + ID_ESTUDIANTE);
            System.out.println("ID Periodo Actual: " + idPeriodoActual);
            EntregaDocumentoFinal entrega = EntregaDocumentoFinalDAO.obtenerEntregaDisponible(ID_ESTUDIANTE, idPeriodoActual);
            if (entrega != null) {
                DocumentoFinal documento = DocumentoFinalDAO.obtenerDocumentoFinalPorTipo(entrega.getIdEntregaDocumentoFinal(), tipo);
                if (documento != null) {
                    Utilidad.crearAlertaAdvertencia("Ya entregado",
                            "Ya has entregado este documento: " + tipo.name());
                } else {
                    if (validarVentanaEntrega(entrega.getFechaApertura(), entrega.getFechaLimite())) {
                        entregaSeleccionada = entrega;
                        tipoDocumentoSeleccionado = TipoDocumento.FINAL;
                        tipoEspecificoSeleccionado = tipo;
                        Utilidad.crearAlertaInformacion(
                                "Entrega disponible",
                                "Puedes entregar el documento: " + tipo.name());
                        actualizarInterfaz(entrega.getFechaApertura(), entrega.getFechaLimite());
                    }
                }
            } else {
                Utilidad.crearAlertaAdvertencia(
                        "Error",
                        "No hay una fecha de entrega programada para entregar tus documentos finales.");
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    private boolean subirDocumentoInicial(byte[] pdf) throws SQLException {
        EntregaDocumentoInicial entrega = (EntregaDocumentoInicial) entregaSeleccionada;

        DocumentoInicial documento = new DocumentoInicial();
        documento.setFechaEntrega(LocalDateTime.now());
        documento.setEstado(EstadoDocumento.Entregado);
        documento.setDocumento(pdf);
        documento.setTipo((TipoDocumentoInicial) tipoEspecificoSeleccionado);

        return DocumentoInicialDAO.subirDocumentoInicial(
                documento,
                entrega.getIdEntregaDocumentoInicial(),
                ID_ESTUDIANTE,
                idPeriodoActual
        );
    }

    private boolean subirDocumentoParcial(byte[] pdf) throws SQLException {
        EntregaDocumentoParcial entrega = (EntregaDocumentoParcial) entregaSeleccionada;

        DocumentoParcial documento = new DocumentoParcial();
        documento.setFechaEntrega(LocalDateTime.now());
        documento.setEstado(EstadoDocumento.Entregado);
        documento.setDocumento(pdf);
        documento.setTipo((TipoDocumentoParcial) tipoEspecificoSeleccionado);

        return DocumentoParcialDAO.subirDocumentoParcial(
                documento,
                entrega.getIdEntregaDocumentoParcial(),
                ID_ESTUDIANTE,
                idPeriodoActual
        );
    }

    private boolean subirDocumentoFinal(byte[] pdf) throws SQLException {
        EntregaDocumentoFinal entrega = (EntregaDocumentoFinal) entregaSeleccionada;

        DocumentoFinal documento = new DocumentoFinal();
        documento.setFechaEntrega(LocalDateTime.now());
        documento.setEstado(EstadoDocumento.Entregado);
        documento.setDocumento(pdf);
        documento.setTipo((TipoDocumentoFinal) tipoEspecificoSeleccionado);

        return DocumentoFinalDAO.subirDocumentoFinal(
                documento,
                entrega.getIdEntregaDocumentoFinal(),
                ID_ESTUDIANTE,
                idPeriodoActual
        );
    }

    private boolean validarVentanaEntrega(LocalDateTime fechaApertura, LocalDateTime fechaLimite) {
        LocalDateTime ahora = LocalDateTime.now();

        if (ahora.isBefore(fechaApertura)) {
            Utilidad.crearAlertaAdvertencia("Pendiente", "La entrega aún no está abierta.");
            return false;
        } else if (ahora.isAfter(fechaLimite)) {
            Utilidad.crearAlertaAdvertencia("Cerrada", "La ventana de entrega ya cerró.");
            return false;
        } else {
            return true;
        }
    }

    private void actualizarInterfaz(LocalDateTime fechaApertura, LocalDateTime fechaLimite) {
        String textoFechas = "Apertura: " + FORMATO_FECHA.format(fechaApertura) +
                "  |  Límite: " + FORMATO_FECHA.format(fechaLimite);

        // Actualizar todas las etiquetas de fecha según corresponda
        if (tipoDocumentoSeleccionado == TipoDocumento.INICIAL) {
            lblFechas.setText(textoFechas);
        } else if (tipoDocumentoSeleccionado == TipoDocumento.PARCIAL) {
            lblFechas1.setText(textoFechas);
        } else if (tipoDocumentoSeleccionado == TipoDocumento.FINAL) {
            lblFechas2.setText(textoFechas);
        }
    }

    private boolean yaExisteDocumentoEspecifico() throws SQLException {
        // Verificar si ya existe el documento específico del tipo seleccionado
        switch (tipoDocumentoSeleccionado) {
            case INICIAL:
                List<DocumentoInicial> docsIniciales = DocumentoInicialDAO.obtenerDocumentosInicialesPorExpediente(ID_ESTUDIANTE, idPeriodoActual);
                return docsIniciales.stream()
                        .anyMatch(doc -> doc.getTipo() == tipoEspecificoSeleccionado);
            case PARCIAL:
                List<DocumentoParcial> docsParciales = DocumentoParcialDAO.obtenerDocumentosParcialesPorExpediente(ID_ESTUDIANTE, idPeriodoActual);
                return docsParciales.stream()
                        .anyMatch(doc -> doc.getTipo() == tipoEspecificoSeleccionado);
            case FINAL:
                List<DocumentoFinal> docsFinales = DocumentoFinalDAO.obtenerDocumentosFinalesPorExpediente(ID_ESTUDIANTE, idPeriodoActual);
                return docsFinales.stream()
                        .anyMatch(doc -> doc.getTipo() == tipoEspecificoSeleccionado);
            default:
                return false;
        }
    }

    private void configurarInterfazInicial() {
        if (lblFechas != null) {
            lblFechas.setText("Selecciona un documento inicial para ver su información de entrega");
        }
        if (lblFechas1 != null) {
            lblFechas1.setText("Selecciona un documento parcial para ver su información de entrega");
        }
        if (lblFechas2 != null) {
            lblFechas2.setText("Selecciona un documento final para ver su información de entrega");
        }
        if (lblFechas3 != null) {
            lblFechas3.setText("Estado: Sin información");
        }

        if (nombreArchivoDocumento != null) {
            nombreArchivoDocumento.setText("Ningún archivo seleccionado");
        }

        actualizarEstadoBotones();
    }

    private void actualizarEstadoBotones() {
        // Esta función podría deshabilitar botones de documentos ya entregados
        // Para implementación futura
    }

    private void limpiarFormulario() {
        archivoSeleccionado = null;
        entregaSeleccionada = null;
        tipoDocumentoSeleccionado = null;
        tipoEspecificoSeleccionado = null;
        nombreArchivoDocumento.setText("Ningún archivo seleccionado");
        lblFechas.setText("Selecciona un documento inicial para ver su información de entrega");
        lblFechas1.setText("Selecciona un documento parcial para ver su información de entrega");
        lblFechas2.setText("Selecciona un documento final para ver su información de entrega");
    }

    @FXML
    private void clicBtnCancelar(ActionEvent event) {
        Stage stage = (Stage) nombreArchivoDocumento.getScene().getWindow();
        stage.close();
    }
}