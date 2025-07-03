/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 13-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 25-06-2025
 * Descripción: Clase controller para subir documentos de prácticas
 */

/*
 * Estado: En progreso
 * Modificaciones: Implementación de javadocs y logger
 */

package sgpp.controlador.usuarios.estudiante.documentopracticas;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.stage.FileChooser;
import sgpp.modelo.beans.Estudiante;
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
import java.util.logging.Logger;
import java.util.logging.Level;

public class FXMLSubirDocumentoPracticasController implements javafx.fxml.Initializable {

    private static final Logger logger = Logger.getLogger(FXMLSubirDocumentoPracticasController.class.getName());

    @FXML
    private Label lbFechasIniciales;
    @FXML
    private Label lbFechasParciales;
    @FXML
    private Label lbFechasFinales;
    @FXML
    private Label lbAperturaCierre;
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
    private Button btnReporteParcial;

    @FXML
    private Button btnEvaluacionParcialOV;
    @FXML
    private Button btnReporteFinal;

    @FXML
    private Button btnAutoevaluacion;

    @FXML
    private Button btnEvaluacionFinalOV;

    @FXML
    private Button btnCartaLiberacion;

    private static final DateTimeFormatter FORMATO_FECHA = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    private int idEstudiante;
    private int idEntregaInicial;
    private int idEntregaParcial;
    private int idEntregaFinal;
    private int idPeriodoActual;

    private TipoDocumento tipoDocumentoSeleccionado;
    private File archivoSeleccionado;
    private Object entregaSeleccionada;
    private Enum<?> tipoEspecificoSeleccionado;

    @Override
    public void initialize(java.net.URL url, java.util.ResourceBundle rb) {
        logger.info("Inicializando controlador de subida de documentos de prácticas");
        // Inicialización de la vista para subir documentos de prácticas
        configurarInterfazInicial();
        cargarPeriodo();
        logger.info("Controlador inicializado correctamente");
    }

    /**
     * Carga el ID del estudiante para el cual se van a subir los documentos.
     * @param estudiante El objeto Estudiante que contiene la información del estudiante.
     */
    public void cargarEstudiante(Estudiante estudiante) {
        logger.log(Level.FINE, "Cargando estudiante con ID: {0}", estudiante.getIdEstudiante());
        this.idEstudiante = estudiante.getIdEstudiante();
        logger.log(Level.INFO, "Estudiante cargado exitosamente - ID: {0}", this.idEstudiante);
    }

    /**
     * Carga el período actual desde la base de datos.
     * Si no hay un período activo, muestra una alerta de advertencia.
     */
    private void cargarPeriodo() {
        logger.fine("Iniciando carga del período actual");
        try {
            Periodo periodo = PeriodoDAO.obtenerPeriodoActual();
            if (periodo != null) {
                this.idPeriodoActual = periodo.getIdPeriodo();
                logger.log(Level.INFO, "Período actual cargado exitosamente - ID: {0}", this.idPeriodoActual);
            } else {
                logger.warning("No se encontró un período activo en la base de datos");
                Utilidad.crearAlertaAdvertencia("Sin período",
                        "No se encontro un periodo activo.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al cargar el período actual desde la base de datos", e);
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    /**
     * Método para manejar el evento de clic en el botón de entregar documento.
     * Este método se encarga de subir el documento seleccionado por el estudiante.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void clicBtnEntregarDocumento(ActionEvent actionEvent) {
        logger.fine("Usuario hizo clic en botón entregar documento");
        clicBtnSubirReporte(actionEvent);
    }

    /**
     * Método para manejar el evento de clic en el botón de seleccionar documento.
     * Este método permite al usuario seleccionar un archivo PDF desde su sistema.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void clicBtnSeleccionarDocumento(ActionEvent actionEvent) {
        logger.fine("Usuario hizo clic en botón seleccionar documento");
        clicBtnSeleccionarPDF(actionEvent);
    }

    /**
     * Maneja el evento de clic en el botón de cancelar.
     * Cierra la ventana actual.
     *
     * @param actionEvent El evento de acción del botón.
     *
     */
    @FXML
    public void btnCartaAceptacion(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Carta de Aceptación");
        manejarDocumentoInicial(TipoDocumentoInicial.CartaAceptacion);
    }

    /**
     * Maneja el evento de clic en el botón de cronograma.
     * Abre la ventana para entregar el cronograma.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnCronograma(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Cronograma");
        manejarDocumentoInicial(TipoDocumentoInicial.Cronograma);
    }

    /**
     * Maneja el evento de clic en el botón de oficio de asignación.
     * Abre la ventana para entregar el oficio de asignación.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnOficioAsignacion(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Oficio de Asignación");
        manejarDocumentoInicial(TipoDocumentoInicial.OficioAsignacion);
    }

    /**
     * Maneja el evento de clic en el botón de horario UV.
     * Abre la ventana para entregar el horario UV.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnHorarioUV(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Horario UV");
        manejarDocumentoInicial(TipoDocumentoInicial.HorarioUV);
    }

    /**
     * Maneja el evento de clic en el botón de constancia de seguro.
     * Abre la ventana para entregar la constancia de seguro.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnConstanciaSeguro(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Constancia de Seguro");
        manejarDocumentoInicial(TipoDocumentoInicial.ConstanciaSeguro);
    }

    /**
     * Maneja el evento de clic en el botón de reporte parcial.
     * Abre la ventana para entregar el reporte parcial.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnReporteParcial(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Reporte Parcial");
        manejarDocumentoParcial(TipoDocumentoParcial.ReporteParcial);
    }

    /**
     * Maneja el evento de clic en el botón de evaluación parcial por OV.
     * Abre la ventana para entregar la evaluación parcial por OV.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnEvaluacionParcialOV(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Evaluación Parcial por OV");
        manejarDocumentoParcial(TipoDocumentoParcial.EvaluacionParcialPorOV);
    }

    /**
     * Maneja el evento de clic en el botón de reporte final.
     * Abre la ventana para entregar el reporte final.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnReporteFinal(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Reporte Final");
        manejarDocumentoFinal(TipoDocumentoFinal.REPORTE_FINAL);
    }

    /**
     * Maneja el evento de clic en el botón de autoevaluación.
     * Abre la ventana para entregar la autoevaluación.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnAutoevaluacion(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Autoevaluación");
        manejarDocumentoFinal(TipoDocumentoFinal.AUTOEVALUACION);
    }

    /**
     * Maneja el evento de clic en el botón de evaluación final por OV.
     * Abre la ventana para entregar la evaluación final por OV.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnEvaluacionFinalOV(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Evaluación Final por OV");
        manejarDocumentoFinal(TipoDocumentoFinal.EVALUACION_FINAL_POR_OV);
    }

    /**
     * Maneja el evento de clic en el botón de carta de liberación.
     * Abre la ventana para entregar la carta de liberación.
     *
     * @param actionEvent El evento de acción del botón.
     */
    @FXML
    public void btnCartaLiberacion(ActionEvent actionEvent) {
        logger.fine("Usuario seleccionó documento: Carta de Liberación");
        manejarDocumentoFinal(TipoDocumentoFinal.CARTA_LIBERACION);
    }

    /**
     * Método para seleccionar un archivo PDF desde el sistema de archivos.
     * Muestra un diálogo de selección de archivos y actualiza la etiqueta con el nombre del archivo seleccionado.
     *
     * @param actionEvent El evento de acción del botón.
     */
    public void clicBtnSeleccionarPDF(ActionEvent actionEvent) {
        logger.fine("Iniciando selección de archivo PDF");
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Seleccionar archivo PDF");
        fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("Archivos PDF", "*.pdf"));
        File archivo = fileChooser.showOpenDialog(null);
        if (archivo != null) {
            archivoSeleccionado = archivo;
            nombreArchivoDocumento.setText("Seleccionado: " + archivo.getName());
            logger.log(Level.INFO, "Archivo PDF seleccionado: {0} (Tamaño: {1} bytes)",
                    new Object[]{archivo.getName(), archivo.length()});
        } else {
            nombreArchivoDocumento.setText("No se ha seleccionado ningún archivo");
            logger.fine("Usuario canceló la selección de archivo");
        }
    }

    /**
     * Método para subir el documento seleccionado por el estudiante.
     * Realiza las validaciones necesarias y sube el documento al sistema.
     *
     * @param event El evento de acción del botón.
     */
    @FXML
    private void clicBtnSubirReporte(ActionEvent event) {
        logger.fine("Iniciando proceso de subida de documento");
        //TODO mover a CU subir reporte
        // Validaciones preliminares
        if (entregaSeleccionada == null) {
            logger.log(Level.WARNING, "Intento de subida sin seleccionar entrega - Estudiante ID: {0}", idEstudiante);
            Utilidad.crearAlertaAdvertencia("Sin entrega",
                    "Primero selecciona un documento abierto.");
            return;
        }

        if (archivoSeleccionado == null) {
            logger.log(Level.WARNING, "Intento de subida sin seleccionar archivo - Estudiante ID: {0}", idEstudiante);
            Utilidad.crearAlertaAdvertencia("Sin archivo",
                    "Selecciona un archivo PDF.");
            return;
        }

        try {
            logger.fine("Verificando si ya existe el documento específico");
            // Verificar si ya existe el documento
            if (yaExisteDocumentoEspecifico()) {
                logger.log(Level.WARNING, "Intento de subir documento ya existente - Estudiante ID: {0}, Tipo: {1}",
                        new Object[]{idEstudiante, tipoEspecificoSeleccionado});
                Utilidad.crearAlertaAdvertencia("Ya entregado",
                        "Ya has entregado este documento.");
                return;
            }

            logger.log(Level.FINE, "Leyendo archivo PDF: {0}", archivoSeleccionado.getName());
            // Leer el archivo PDF
            byte[] pdf = Files.readAllBytes(archivoSeleccionado.toPath());

            // Validar tamaño del archivo (máximo 10 MB)
            if (pdf.length > 10 * 1024 * 1024) {
                logger.log(Level.WARNING, "Archivo demasiado grande rechazado - Tamaño: {0} bytes, Archivo: {1}",
                        new Object[]{pdf.length, archivoSeleccionado.getName()});
                Utilidad.crearAlertaAdvertencia("Archivo muy grande",
                        "El archivo no debe superar los 10MB.");
                return;
            }

            logger.log(Level.INFO, "Archivo validado correctamente - Tamaño: {0} bytes", pdf.length);

            // Subir según el tipo de documento
            boolean exito = switch (tipoDocumentoSeleccionado) {
                case INICIAL -> subirDocumentoInicial(pdf);
                case PARCIAL -> subirDocumentoParcial(pdf);
                case FINAL -> subirDocumentoFinal(pdf);
                default -> {
                    logger.log(Level.SEVERE, "Tipo de documento no reconocido: {0}", tipoDocumentoSeleccionado);
                    yield false;
                }
            };

            if (exito) {
                logger.log(Level.INFO, "Documento subido exitosamente - Estudiante ID: {0}, Tipo: {1}, Archivo: {2}",
                        new Object[]{idEstudiante, tipoEspecificoSeleccionado, archivoSeleccionado.getName()});
                Utilidad.crearAlertaInformacion("Éxito", "Documento subido correctamente.");
                limpiarFormulario();
                actualizarEstadoBotones();
            } else {
                logger.log(Level.SEVERE, "Fallo al subir documento - Estudiante ID: {0}, Tipo: {1}",
                        new Object[]{idEstudiante, tipoEspecificoSeleccionado});
                Utilidad.crearAlertaAdvertencia("Fallo", "No se pudo subir el documento.");
            }

        } catch (IOException ex) {
            logger.log(Level.SEVERE, "Error de I/O al leer archivo PDF: " + archivoSeleccionado.getName(), ex);
            Utilidad.crearAlertaError("Error al leer archivo",
                    "No se pudo leer el archivo PDF: " + ex.getMessage());
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error de base de datos durante subida de documento", ex);
            Utilidad.mostrarErrorBD(true, ex);
        }
    }

    /**
     * Maneja la lógica para cada tipo de documento inicial.
     * Dependiendo del tipo, verifica si hay una entrega disponible y si ya se ha entregado.
     *
     * @param tipo El tipo de documento inicial a manejar.
     */
    private void manejarDocumentoInicial(TipoDocumentoInicial tipo) {
        logger.log(Level.FINE, "Manejando documento inicial tipo: {0} para estudiante ID: {1}",
                new Object[]{tipo, idEstudiante});
        try {
            EntregaDocumentoInicial entrega = EntregaDocumentoInicialDAO.obtenerEntregaDisponible(idEstudiante, idPeriodoActual);
            if (entrega != null) {
                logger.log(Level.FINE, "Entrega inicial encontrada - ID: {0}", entrega.getIdEntregaDocumentoInicial());
                idEntregaInicial = entrega.getIdEntregaDocumentoInicial();
                DocumentoInicial documento = DocumentoInicialDAO.obtenerDocumentoInicialPorTipo(entrega.getIdEntregaDocumentoInicial(), tipo);
                if (documento != null) {
                    logger.log(Level.WARNING, "Documento inicial ya entregado - Tipo: {0}, Estudiante ID: {1}",
                            new Object[]{tipo, idEstudiante});
                    Utilidad.crearAlertaAdvertencia("Ya entregado",
                            "Ya has entregado este documento: " + tipo.name());
                } else {
                    if (validarVentanaEntrega(entrega.getFechaApertura(), entrega.getFechaLimite())) {
                        entregaSeleccionada = entrega;
                        tipoDocumentoSeleccionado = TipoDocumento.INICIAL;
                        tipoEspecificoSeleccionado = tipo;
                        logger.log(Level.INFO, "Documento inicial disponible para entrega - Tipo: {0}, Estudiante ID: {1}",
                                new Object[]{tipo, idEstudiante});
                        Utilidad.crearAlertaInformacion(
                                "Entrega disponible",
                                "Puedes entregar el documento: " + tipo.name());
                        actualizarInterfaz(entrega.getFechaApertura(), entrega.getFechaLimite());
                    }
                }
            } else {
                logger.log(Level.WARNING, "No hay entrega inicial programada - Estudiante ID: {0}, Período ID: {1}",
                        new Object[]{idEstudiante, idPeriodoActual});
                Utilidad.crearAlertaAdvertencia(
                        "Error",
                        "No hay una fecha de entrega programada para entregar tus documentos iniciales.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error de base de datos al manejar documento inicial tipo: " + tipo, e);
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    /**
     * Maneja la lógica para cada tipo de documento parcial.
     * Dependiendo del tipo, verifica si hay una entrega disponible y si ya se ha entregado.
     *
     * @param tipo El tipo de documento parcial a manejar.
     */
    private void manejarDocumentoParcial(TipoDocumentoParcial tipo) {
        logger.log(Level.FINE, "Manejando documento parcial tipo: {0} para estudiante ID: {1}",
                new Object[]{tipo, idEstudiante});
        try {
            EntregaDocumentoParcial entrega = EntregaDocumentoParcialDAO.obtenerEntregaDisponible(idEstudiante, idPeriodoActual);
            if (entrega != null) {
                logger.log(Level.FINE, "Entrega parcial encontrada - ID: {0}", entrega.getIdEntregaDocumentoParcial());
                idEntregaParcial = entrega.getIdEntregaDocumentoParcial();
                DocumentoParcial documento = DocumentoParcialDAO.obtenerDocumentoParcialPorTipo(entrega.getIdEntregaDocumentoParcial(), tipo);
                if (documento != null) {
                    logger.log(Level.WARNING, "Documento parcial ya entregado - Tipo: {0}, Estudiante ID: {1}",
                            new Object[]{tipo, idEstudiante});
                    Utilidad.crearAlertaAdvertencia("Ya entregado",
                            "Ya has entregado este documento: " + tipo.name());
                } else {
                    if (validarVentanaEntrega(entrega.getFechaApertura(), entrega.getFechaLimite())) {
                        entregaSeleccionada = entrega;
                        tipoDocumentoSeleccionado = TipoDocumento.PARCIAL;
                        tipoEspecificoSeleccionado = tipo;
                        logger.log(Level.INFO, "Documento parcial disponible para entrega - Tipo: {0}, Estudiante ID: {1}",
                                new Object[]{tipo, idEstudiante});
                        Utilidad.crearAlertaInformacion(
                                "Entrega disponible",
                                "Puedes entregar el documento: " + tipo.name());
                        actualizarInterfaz(entrega.getFechaApertura(), entrega.getFechaLimite());
                    }
                }
            } else {
                logger.log(Level.WARNING, "No hay entrega parcial programada - Estudiante ID: {0}, Período ID: {1}",
                        new Object[]{idEstudiante, idPeriodoActual});
                Utilidad.crearAlertaAdvertencia(
                        "Error",
                        "No hay una fecha de entrega programada para entregar tus documentos parciales.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error de base de datos al manejar documento parcial tipo: " + tipo, e);
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    /**
     * Maneja la lógica para cada tipo de documento final.
     * Dependiendo del tipo, verifica si hay una entrega disponible y si ya se ha entregado.
     *
     * @param tipo El tipo de documento final a manejar.
     */
    private void manejarDocumentoFinal(TipoDocumentoFinal tipo) {
        logger.log(Level.FINE, "Manejando documento final tipo: {0} para estudiante ID: {1}",
                new Object[]{tipo, idEstudiante});
        try {
            EntregaDocumentoFinal entrega = EntregaDocumentoFinalDAO.obtenerEntregaDisponible(idEstudiante, idPeriodoActual);
            if (entrega != null) {
                logger.log(Level.FINE, "Entrega final encontrada - ID: {0}", entrega.getIdEntregaDocumentoFinal());
                idEntregaFinal = entrega.getIdEntregaDocumentoFinal();
                DocumentoFinal documento = DocumentoFinalDAO.obtenerDocumentoFinalPorTipo(entrega.getIdEntregaDocumentoFinal(), tipo);
                if (documento != null) {
                    logger.log(Level.WARNING, "Documento final ya entregado - Tipo: {0}, Estudiante ID: {1}",
                            new Object[]{tipo, idEstudiante});
                    Utilidad.crearAlertaAdvertencia("Ya entregado",
                            "Ya has entregado este documento: " + tipo.name());
                } else {
                    if (validarVentanaEntrega(entrega.getFechaApertura(), entrega.getFechaLimite())) {
                        entregaSeleccionada = entrega;
                        tipoDocumentoSeleccionado = TipoDocumento.FINAL;
                        tipoEspecificoSeleccionado = tipo;
                        logger.log(Level.INFO, "Documento final disponible para entrega - Tipo: {0}, Estudiante ID: {1}",
                                new Object[]{tipo, idEstudiante});
                        Utilidad.crearAlertaInformacion(
                                "Entrega disponible",
                                "Puedes entregar el documento: " + tipo.name());
                        actualizarInterfaz(entrega.getFechaApertura(), entrega.getFechaLimite());
                    }
                }
            } else {
                logger.log(Level.WARNING, "No hay entrega final programada - Estudiante ID: {0}, Período ID: {1}",
                        new Object[]{idEstudiante, idPeriodoActual});
                Utilidad.crearAlertaAdvertencia(
                        "Error",
                        "No hay una fecha de entrega programada para entregar tus documentos finales.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error de base de datos al manejar documento final tipo: " + tipo, e);
            Utilidad.mostrarErrorBD(true, e);
        }
    }

    /**
     * Sube el documento inicial seleccionado por el estudiante.
     * Crea un objeto DocumentoInicial y lo guarda en la base de datos.
     *
     * @param pdf El contenido del archivo PDF como un arreglo de bytes.
     * @return true si la subida fue exitosa, false en caso contrario.
     * @throws SQLException Si ocurre un error al acceder a la base de datos.
     */
    private boolean subirDocumentoInicial(byte[] pdf) throws SQLException {
        logger.log(Level.FINE, "Subiendo documento inicial - Tipo: {0}, Tamaño: {1} bytes",
                new Object[]{tipoEspecificoSeleccionado, pdf.length});
        EntregaDocumentoInicial entrega = (EntregaDocumentoInicial) entregaSeleccionada;

        DocumentoInicial documento = new DocumentoInicial();
        documento.setFechaEntrega(LocalDateTime.now());
        documento.setEstado(EstadoDocumento.Entregado);
        documento.setDocumento(pdf);
        documento.setTipo((TipoDocumentoInicial) tipoEspecificoSeleccionado);

        boolean resultado = DocumentoInicialDAO.subirDocumentoInicial(
                documento,
                entrega.getIdEntregaDocumentoInicial(),
                idEstudiante,
                idPeriodoActual
        );

        if (resultado) {
            logger.log(Level.INFO, "Documento inicial subido exitosamente - Estudiante ID: {0}, Tipo: {1}",
                    new Object[]{idEstudiante, tipoEspecificoSeleccionado});
        } else {
            logger.log(Level.SEVERE, "Fallo al subir documento inicial - Estudiante ID: {0}, Tipo: {1}",
                    new Object[]{idEstudiante, tipoEspecificoSeleccionado});
        }

        return resultado;
    }

    /**
     * Sube el documento parcial seleccionado por el estudiante.
     * Crea un objeto DocumentoParcial y lo guarda en la base de datos.
     *
     * @param pdf El contenido del archivo PDF como un arreglo de bytes.
     * @return true si la subida fue exitosa, false en caso contrario.
     * @throws SQLException Si ocurre un error al acceder a la base de datos.
     */
    private boolean subirDocumentoParcial(byte[] pdf) throws SQLException {
        logger.log(Level.FINE, "Subiendo documento parcial - Tipo: {0}, Tamaño: {1} bytes",
                new Object[]{tipoEspecificoSeleccionado, pdf.length});
        EntregaDocumentoParcial entrega = (EntregaDocumentoParcial) entregaSeleccionada;

        DocumentoParcial documento = new DocumentoParcial();
        documento.setFechaEntrega(LocalDateTime.now());
        documento.setEstado(EstadoDocumento.Entregado);
        documento.setDocumento(pdf);
        documento.setTipo((TipoDocumentoParcial) tipoEspecificoSeleccionado);

        boolean resultado = DocumentoParcialDAO.subirDocumentoParcial(
                documento,
                entrega.getIdEntregaDocumentoParcial(),
                idEstudiante,
                idPeriodoActual
        );

        if (resultado) {
            logger.log(Level.INFO, "Documento parcial subido exitosamente - Estudiante ID: {0}, Tipo: {1}",
                    new Object[]{idEstudiante, tipoEspecificoSeleccionado});
        } else {
            logger.log(Level.SEVERE, "Fallo al subir documento parcial - Estudiante ID: {0}, Tipo: {1}",
                    new Object[]{idEstudiante, tipoEspecificoSeleccionado});
        }

        return resultado;
    }

    /**
     * Sube el documento final seleccionado por el estudiante.
     * Crea un objeto DocumentoFinal y lo guarda en la base de datos.
     *
     * @param pdf El contenido del archivo PDF como un arreglo de bytes.
     * @return true si la subida fue exitosa, false en caso contrario.
     * @throws SQLException Si ocurre un error al acceder a la base de datos.
     */
    private boolean subirDocumentoFinal(byte[] pdf) throws SQLException {
        logger.log(Level.FINE, "Subiendo documento final - Tipo: {0}, Tamaño: {1} bytes",
                new Object[]{tipoEspecificoSeleccionado, pdf.length});
        EntregaDocumentoFinal entrega = (EntregaDocumentoFinal) entregaSeleccionada;

        DocumentoFinal documento = new DocumentoFinal();
        documento.setFechaEntrega(LocalDateTime.now());
        documento.setEstado(EstadoDocumento.Entregado);
        documento.setDocumento(pdf);
        documento.setTipo((TipoDocumentoFinal) tipoEspecificoSeleccionado);

        boolean resultado = DocumentoFinalDAO.subirDocumentoFinal(
                documento,
                entrega.getIdEntregaDocumentoFinal(),
                idEstudiante,
                idPeriodoActual
        );

        if (resultado) {
            logger.log(Level.INFO, "Documento final subido exitosamente - Estudiante ID: {0}, Tipo: {1}",
                    new Object[]{idEstudiante, tipoEspecificoSeleccionado});
        } else {
            logger.log(Level.SEVERE, "Fallo al subir documento final - Estudiante ID: {0}, Tipo: {1}",
                    new Object[]{idEstudiante, tipoEspecificoSeleccionado});
        }

        return resultado;
    }

    /**
     * Valida si la ventana de entrega está abierta o cerrada.
     * Muestra una alerta si la entrega aún no está abierta o ya ha cerrado.
     *
     * @param fechaApertura La fecha y hora de apertura de la entrega.
     * @param fechaLimite   La fecha y hora límite para entregar el documento.
     * @return true si la ventana está abierta, false en caso contrario.
     */
    private boolean validarVentanaEntrega(LocalDateTime fechaApertura, LocalDateTime fechaLimite) {
        logger.log(Level.FINE, "Validando ventana de entrega - Apertura: {0}, Límite: {1}",
                new Object[]{fechaApertura, fechaLimite});
        LocalDateTime ahora = LocalDateTime.now();

        if (ahora.isBefore(fechaApertura)) {
            logger.log(Level.WARNING, "Intento de entrega antes de apertura - Estudiante ID: {0}, Fecha actual: {1}, Apertura: {2}",
                    new Object[]{idEstudiante, ahora, fechaApertura});
            Utilidad.crearAlertaAdvertencia("Pendiente", "La entrega aún no está abierta.");
            return false;
        } else if (ahora.isAfter(fechaLimite)) {
            logger.log(Level.WARNING, "Intento de entrega después del límite - Estudiante ID: {0}, Fecha actual: {1}, Límite: {2}",
                    new Object[]{idEstudiante, ahora, fechaLimite});
            Utilidad.crearAlertaAdvertencia("Cerrada", "La ventana de entrega ya cerró.");
            return false;
        } else {
            long minutosRestantes = java.time.Duration.between(ahora, fechaLimite).toMinutes();
            logger.log(Level.INFO, "Ventana de entrega válida - Estudiante ID: {0}, Tiempo restante: {1} minutos",
                    new Object[]{idEstudiante, minutosRestantes});
            return true;
        }
    }

    /**
     * Actualiza la interfaz de usuario con las fechas de apertura y límite de entrega.
     * Dependiendo del tipo de documento seleccionado, actualiza la etiqueta correspondiente.
     *
     * @param fechaApertura La fecha y hora de apertura de la entrega.
     * @param fechaLimite   La fecha y hora límite para entregar el documento.
     */
    private void actualizarInterfaz(LocalDateTime fechaApertura, LocalDateTime fechaLimite) {
        logger.log(Level.FINE, "Actualizando interfaz con fechas - Tipo documento: {0}", tipoDocumentoSeleccionado);
        String textoFechas = "Apertura: " + FORMATO_FECHA.format(fechaApertura) +
                "  |  Límite: " + FORMATO_FECHA.format(fechaLimite);

        // Actualizar todas las etiquetas de fecha según corresponda
        if (tipoDocumentoSeleccionado == TipoDocumento.INICIAL) {
            lbFechasIniciales.setText(textoFechas);
            logger.fine("Interfaz actualizada para documentos iniciales");
        } else if (tipoDocumentoSeleccionado == TipoDocumento.PARCIAL) {
            lbFechasParciales.setText(textoFechas);
            logger.fine("Interfaz actualizada para documentos parciales");
        } else if (tipoDocumentoSeleccionado == TipoDocumento.FINAL) {
            lbFechasFinales.setText(textoFechas);
            logger.fine("Interfaz actualizada para documentos finales");
        }
    }

    /**
     * Verifica si ya existe un documento específico del tipo seleccionado.
     * Dependiendo del tipo de documento, consulta la base de datos para ver si ya se ha entregado.
     *
     * @return true si ya existe el documento específico, false en caso contrario.
     * @throws SQLException Si ocurre un error al acceder a la base de datos.
     */
    private boolean yaExisteDocumentoEspecifico() throws SQLException {
        logger.log(Level.FINE, "Verificando existencia de documento específico - Tipo: {0}, Estudiante ID: {1}",
                new Object[]{tipoEspecificoSeleccionado, idEstudiante});

        // Verificar si ya existe el documento específico del tipo seleccionado
        switch (tipoDocumentoSeleccionado) {
            case INICIAL:
                List<DocumentoInicial> docsIniciales = DocumentoInicialDAO.obtenerDocumentosInicialesPorExpediente(idEntregaInicial);
                boolean existeInicial = docsIniciales.stream()
                        .anyMatch(doc -> doc.getTipo() == tipoEspecificoSeleccionado);
                logger.log(Level.FINE, "Verificación documento inicial - Existe: {0}, Total documentos: {1}",
                        new Object[]{existeInicial, docsIniciales.size()});
                return existeInicial;

            case PARCIAL:
                List<DocumentoParcial> docsParciales = DocumentoParcialDAO.obtenerDocumentosParcialesPorExpediente(idEntregaParcial);
                boolean existeParcial = docsParciales.stream()
                        .anyMatch(doc -> doc.getTipo() == tipoEspecificoSeleccionado);
                logger.log(Level.FINE, "Verificación documento parcial - Existe: {0}, Total documentos: {1}",
                        new Object[]{existeParcial, docsParciales.size()});
                return existeParcial;

            case FINAL:
                List<DocumentoFinal> docsFinales = DocumentoFinalDAO.obtenerDocumentosFinalesPorExpediente(idEntregaFinal);
                boolean existeFinal = docsFinales.stream()
                        .anyMatch(doc -> doc.getTipo() == tipoEspecificoSeleccionado);
                logger.log(Level.FINE, "Verificación documento final - Existe: {0}, Total documentos: {1}",
                        new Object[]{existeFinal, docsFinales.size()});
                return existeFinal;

            default:
                logger.log(Level.WARNING, "Tipo de documento no reconocido para verificación: {0}", tipoDocumentoSeleccionado);
                return false;
        }
    }

    /**
     * Configura la interfaz inicial al cargar la vista.
     * Inicializa los campos y botones necesarios.
     */
    private void configurarInterfazInicial() {
        logger.fine("Configurando interfaz inicial");

        if (nombreArchivoDocumento != null) {
            nombreArchivoDocumento.setText("Ningún archivo seleccionado");
        }

        actualizarEstadoBotones();
        logger.info("Interfaz inicial configurada correctamente");
    }

    /**
     * Actualiza el estado de los botones según los documentos ya entregados.
     * Esta función puede deshabilitar botones de documentos que ya han sido entregados.
     */
    private void actualizarEstadoBotones() {
        logger.log(Level.FINE, "Actualizando estado de botones para estudiante ID: {0}", idEstudiante);
        // Esta función podría deshabilitar botones de documentos ya entregados
        // Para implementación futura
        logger.fine("Estado de botones actualizado");
    }

    /**
     * Limpia el formulario de entrega de documentos.
     * Resetea los campos y variables para permitir una nueva entrega.
     */
    private void limpiarFormulario() {
        logger.fine("Limpiando formulario de entrega");
        archivoSeleccionado = null;
        entregaSeleccionada = null;
        tipoDocumentoSeleccionado = null;
        tipoEspecificoSeleccionado = null;
        nombreArchivoDocumento.setText("Ningún archivo seleccionado");
        logger.info("Formulario limpiado correctamente");
    }

    /**
     * Maneja el evento de clic en el botón de cancelar.
     * Cierra la ventana actual sin realizar ninguna acción adicional.
     *
     * @param event El evento de acción del botón.
     */
    @FXML
    private void clicBtnCancelar(ActionEvent event) {
        logger.fine("Usuario hizo clic en botón cancelar");
        Utilidad.cerrarVentana(lbAperturaCierre);
        logger.info("Ventana cerrada por cancelación del usuario");
    }
}
