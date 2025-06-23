package sgpp.utilidad;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.interactive.form.PDAcroForm;
import org.apache.pdfbox.pdmodel.interactive.form.PDField;
import org.apache.pdfbox.pdmodel.interactive.form.PDTextField;
import org.apache.pdfbox.pdmodel.interactive.form.PDCheckBox;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.entidades.OrganizacionVinculadaDAO;
import sgpp.modelo.dao.entidades.PeriodoDAO;
import sgpp.modelo.dao.entidades.ProyectoDAO;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;

// TODO: Adaptar para cualquier rúbrica.
// TODO: Tomar de base para AutoEvaluacion.
public class DocumentoRubrica {

    /**
     * Llena un formulario PDF existente con los datos de la rúbrica
     */
    public static byte[] generarRubricaEvaluacion(RubricaPresentacion rubrica) throws IOException {
        try (PDDocument document = new PDDocument();
             ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            PDPage page = new PDPage(PDRectangle.LETTER);
            document.addPage(page);

            PDPageContentStream content = new PDPageContentStream(document, page);

            content.beginText();
            content.setFont(PDType1Font.HELVETICA, 11);
            content.setLeading(14.5f);
            content.newLineAtOffset(50, 700);

            String[] encabezado = {
                    "FACULTAD DE ESTADÍSTICA E INFORMÁTICA",
                    "Licenciatura en Ingenería de Software",
                    "Formato: RÚBRICA DE PRESENTACIÓN ORAL DEL INFORME PARCIAL EE Prácticas de Ingeniería de Software"
            };
            escribirLineaPorLinea(content, encabezado);

            int idProyecto = recuperarIdProyecto(rubrica.getIdEstudiante());
            String[] datosDelProyecto = {
                    "Datos del Proyecto",
                    "Alumno(a): "+recuperarNombreDeEstudiante(rubrica.getIdEstudiante()),
                    "Proyecto: "+recuperarNombreDeProyecto(rubrica.getIdEstudiante()),
                    "Organizacion Vinculada: "+recuperarNombreDeOV(idProyecto),
                    "Periodo del reporte: "+recuperarAbreviaturaPerido(rubrica.getIdPeriodo()),
                    "Fecha del reporte: "+rubrica.getFechaHora().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")),
                    "Evaluador(a): "+rubrica.getEvaluador().getNombre()
            };
            content.newLine();
            escribirLineaPorLinea(content, datosDelProyecto);

            float[] criterios = rubrica.getCriterios();
            if (criterios != null && criterios.length == 5) {
                String criterioIS = determinarNivel(criterios[0]);
                String criterioRequisitos = determinarNivel(criterios[1]);
                String criterioDominio = determinarNivel(criterios[2]);
                String criterioContenido = determinarNivel(criterios[3]);
                String criterioOrtografia = determinarNivel(criterios[4]);

                String[] evaluacionCriterios = {
                        String.format("USO DE MÉTODOS Y TÉCNICAS DE LA IS: %s (%s)", criterioIS, criterios[0]),
                        String.format("REQUISITOS (Objetivo, metodología, cronograma, resultados, retos/estrategias): %s (%s)",
                                criterioRequisitos, criterios[1]),
                        String.format("SEGURIDAD Y DOMINIO: %s (%s)", criterioDominio, criterios[2]),
                        String.format("CONTENIDO: %s (%s)", criterioContenido, criterios[3]),
                        String.format("ORTOGRAFÍA Y REDACCIÓN: %s (%s)", criterioOrtografia, criterios[4])
                };
                content.newLine();
                escribirLineaPorLinea(content, evaluacionCriterios);
            }

            content.newLine();
            String[] cierre = {
                    String.format("PROMEDIO: %s", rubrica.getCalificacion()),
                    "OBSERVACIONES Y COMENTARIOS",
                    rubrica.getObservaciones()
            };
            escribirLineaPorLinea(content, cierre);

            content.endText();
            content.close();
            document.save(baos);
            return baos.toByteArray();
        }
    }

    private static void llenarCampoTexto(PDAcroForm acroForm, String nombreCampo, String valor) {
        try {
            PDField field = acroForm.getField(nombreCampo);
            if (field instanceof PDTextField && valor != null) {
                field.setValue(valor);
            }
        } catch (IOException e) {
            System.err.println("Error al llenar campo " + nombreCampo + ": " + e.getMessage());
        }
    }

    private static void marcarNivelCalificacion(PDAcroForm acroForm, float[] criterios) {
        // Ejemplo de cómo marcar checkboxes según el nivel de calificación
        for (int i = 0; i < criterios.length; i++) {
            float calificacion = criterios[i];
            String nivel = determinarNivel(calificacion);
            String nombreCheckbox = "criterio" + (i + 1) + "_" + nivel;

            try {
                PDField field = acroForm.getField(nombreCheckbox);
                if (field instanceof PDCheckBox) {
                    ((PDCheckBox) field).check();
                }
            } catch (IOException e) {
                System.err.println("Error al marcar checkbox " + nombreCheckbox + ": " + e.getMessage());
            }
        }
    }

    private static String determinarNivel(float calificacion) {
        if (calificacion >= 9.1) return "COMPETENTE";
        else if (calificacion >= 8.1) return "INDEPENDIENTE";
        else if (calificacion >= 7.1) return "BÁSICO AVANZADO";
        else if (calificacion >= 6.0) return "BÁSICO UMBRAL";
        else return "NO COMPETENTE";
    }

    /**
     * Lista todos los campos disponibles en un formulario PDF
     */
    public static void listarCamposFormulario(String archivoPDF) throws IOException {
        try (PDDocument document = PDDocument.load(new File(archivoPDF))) {
            PDAcroForm acroForm = document.getDocumentCatalog().getAcroForm();

            if (acroForm != null) {
                System.out.println("Campos encontrados en el formulario:");
                for (PDField field : acroForm.getFields()) {
                    System.out.println("- Nombre: " + field.getFullyQualifiedName() +
                            ", Tipo: " + field.getClass().getSimpleName() +
                            ", Valor actual: " + field.getValueAsString());
                }
            } else {
                System.out.println("El PDF no contiene formularios AcroForm.");
            }
        }
    }

    private static void escribirLineaPorLinea(PDPageContentStream content, String[] lineas) throws IOException {
        for (String linea : lineas) {
            content.showText(linea);
            content.newLine();
        }
    }

    private static String recuperarNombreDeEstudiante(int idEstudiante) {
        String nombreEstudiante = "";
        try {
            nombreEstudiante = EstudianteDAO.obtenerPorId(idEstudiante).getNombre();
        } catch (SQLException sqlex) {
            System.err.println("Error al recuperar el nombre del estudiante: " + sqlex.getMessage());
        }
        return nombreEstudiante;
    }

    private static String recuperarNombreDeOV(int idProyecto) {
        String nombreOV = "";
        try {

            nombreOV = OrganizacionVinculadaDAO.obtenerPorAsocionAProyecto(idProyecto).getNombre();
        } catch (SQLException sqlex) {
            System.err.println("Error al recuperar el nombre de la OV "+sqlex.getMessage());
        }
        return nombreOV;
    }

    private static String recuperarNombreDeProyecto(int idEstudiante) {
        String nombreProyecto = "";
        try {
            Proyecto proyecto = ProyectoDAO.obtenerPorAsociacionEstudiante(idEstudiante);
            if (proyecto != null) {
                nombreProyecto = proyecto.getNombre();
            }
        } catch (SQLException sqlex) {
            System.err.println("Error al recuperar el nombre del proyecto "+sqlex.getMessage());
        }
        return nombreProyecto;
    }

    private static int recuperarIdProyecto(int idEstudiante) {
        int idProyecto = 0;
        try {
            Proyecto proyecto = ProyectoDAO.obtenerPorAsociacionEstudiante(idEstudiante);
            if (proyecto != null) {
                idProyecto = proyecto.getIdProyecto();
            }
        } catch (SQLException sqlex) {
            System.err.println("Error al recuperar el ID del proyecto "+sqlex.getMessage());
        }
        return idProyecto;
    }

    private static String recuperarAbreviaturaPerido(int idPeriodo) {
        String abreviatura = "";
        try {
            abreviatura = PeriodoDAO.recuperarPeriodoPorId(idPeriodo).getAbreviatura();
        } catch (SQLException sqlex) {
            System.err.println("Error al recuperar la abreviatura del periodo "+sqlex.getMessage());
        }
        return abreviatura;
    }
}
