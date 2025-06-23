package sgpp.utilidad;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.interactive.form.PDAcroForm;
import org.apache.pdfbox.pdmodel.interactive.form.PDField;
import org.apache.pdfbox.pdmodel.interactive.form.PDTextField;
import org.apache.pdfbox.pdmodel.interactive.form.PDCheckBox;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;

import java.io.File;
import java.io.IOException;
import java.time.format.DateTimeFormatter;

// TODO: Adaptar para cualquier rúbrica.
// TODO: Tomar de base para AutoEvaluacion.
public class DocumentoRubrica {

    /**
     * Llena un formulario PDF existente con los datos de la rúbrica
     */
    public static void llenarFormularioPDF(String archivoOriginal, String archivoDestino, RubricaPresentacion rubrica) throws IOException {
        try (PDDocument document = PDDocument.load(new File(archivoOriginal))) {
            PDAcroForm acroForm = document.getDocumentCatalog().getAcroForm();

            if (acroForm != null) {
                // Llenar campos de texto básicos
                llenarCampoTexto(acroForm, "alumno", "Nombre del estudiante"); // Necesitarías obtener el nombre
                llenarCampoTexto(acroForm, "organizacion", "Organización vinculada");
                llenarCampoTexto(acroForm, "proyecto", "Nombre del proyecto");
                llenarCampoTexto(acroForm, "periodo", "Período: " + rubrica.getIdPeriodo());
                llenarCampoTexto(acroForm, "fecha", rubrica.getFechaHora().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")));

                // Llenar evaluador
                if (rubrica.getEvaluador() != null) {
                    llenarCampoTexto(acroForm, "evaluador", rubrica.getEvaluador().getNombre());
                }

                // Llenar calificaciones de criterios
                float[] criterios = rubrica.getCriterios();
                if (criterios != null && criterios.length >= 5) {
                    llenarCampoTexto(acroForm, "criterio1", String.format("%.1f", criterios[0]));
                    llenarCampoTexto(acroForm, "criterio2", String.format("%.1f", criterios[1]));
                    llenarCampoTexto(acroForm, "criterio3", String.format("%.1f", criterios[2]));
                    llenarCampoTexto(acroForm, "criterio4", String.format("%.1f", criterios[3]));
                    llenarCampoTexto(acroForm, "criterio5", String.format("%.1f", criterios[4]));
                }

                // Llenar calificación promedio
                llenarCampoTexto(acroForm, "promedio", String.format("%.1f", rubrica.getCalificacion()));

                // Llenar observaciones
                llenarCampoTexto(acroForm, "observaciones", rubrica.getObservaciones());

                // Marcar checkboxes según calificaciones (si existen)
                marcarNivelCalificacion(acroForm, criterios);

                // Aplanar el formulario (opcional - hace los campos no editables)
                // acroForm.flatten();
            }

            document.save(archivoDestino);
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
        if (calificacion >= 9.1) return "competente";
        else if (calificacion >= 8.1) return "independiente";
        else if (calificacion >= 7.1) return "basico_avanzado";
        else if (calificacion >= 6.0) return "basico_umbral";
        else return "no_competente";
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
}
