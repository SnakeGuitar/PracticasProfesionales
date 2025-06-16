/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 09-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase utilitaria general para controladores JavaFX y generación de documentos.
 */

package sgpp.utilidad;

import sgpp.SistemaGestionPracticasProfesionales;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Control;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

import sgpp.modelo.beans.expediente.documentoinicial.TablaAsignacion;

public class Utilidad {

    public static void crearAlerta(Alert.AlertType tipo, String titulo, String contenido) {
        Alert alerta = new Alert(tipo);
        alerta.setTitle(titulo);
        alerta.setHeaderText(null);
        alerta.setContentText(contenido);
        alerta.showAndWait();
    }

    public static boolean crearAlertaConfirmacion(String titulo, String contenido) {
        Alert alertaConfirmacion = new Alert(Alert.AlertType.CONFIRMATION);
        alertaConfirmacion.setTitle(titulo);
        alertaConfirmacion.setHeaderText(null);
        alertaConfirmacion.setContentText(contenido);
        return alertaConfirmacion.showAndWait().get() == ButtonType.OK;
    }

    public static boolean confirmarCancelar() {
        return crearAlertaConfirmacion(
                "Cancelar operación",
                "¿Estás seguro de que deseas cancelar?\n" +
                        "Se perderá el progreso no guardado.");
    }

    public static void crearAlertaError(String titulo, String contenido) {
        crearAlerta(Alert.AlertType.ERROR, titulo, contenido);
    }

    public static void crearAlertaAdvertencia(String titulo, String contenido) {
        crearAlerta(Alert.AlertType.WARNING, titulo, contenido);
    }

    public static void crearAlertaInformacion(String titulo, String contenido) {
        crearAlerta(Alert.AlertType.INFORMATION, titulo, contenido);
    }

    public static void mostrarError(boolean mostrarAlerta, Exception excepcion, String titulo, String contenido) {
        System.err.println(excepcion.getMessage());
        excepcion.printStackTrace();

        if(mostrarAlerta) {
            crearAlertaError(titulo, contenido + ": " + excepcion.getMessage());
        }
    }

    public static void mostrarErrorBD(boolean mostrarAlerta, Exception exception) {
        mostrarError(mostrarAlerta, exception, "Error de conexión", "Hubo un error de conexión");
    }

    public static Stage getEscenarioComponente(Control componente) {
        return (Stage) componente.getScene().getWindow();
    }

    public static void cerrarVentana(Control componente) {
        getEscenarioComponente(componente).close();
    }

    public static void crearEscenario(String URL, String tituloEscenario) {
        try {
            Stage nuevoEscenario = new Stage();
            Parent vista = FXMLLoader.load(SistemaGestionPracticasProfesionales.class.getResource(URL));
            Scene nuevaEscena = new Scene(vista);
            nuevoEscenario.setScene(nuevaEscena);
            nuevoEscenario.initModality(Modality.APPLICATION_MODAL);
            nuevoEscenario.setTitle(tituloEscenario);
            nuevoEscenario.showAndWait();
        } catch (IOException excepcion) {
            mostrarError(true, excepcion, "Error al cargar la vista", "No se pudo cargar la vista: " + URL);
        }
    }

    public static byte[] generarDocumentoAsignacion(TablaAsignacion a) {
        try (PDDocument document = new PDDocument(); ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            PDPage page = new PDPage(PDRectangle.LETTER);
            document.addPage(page);

            PDPageContentStream content = new PDPageContentStream(document, page);

            content.beginText();
            content.setFont(PDType1Font.HELVETICA, 11);
            content.setLeading(14.5f);
            content.newLineAtOffset(50, 700);

            String fecha = LocalDate.now().format(DateTimeFormatter.ofPattern("d 'de' MMMM 'de' yyyy", new Locale("es", "MX")));
            content.showText("Xalapa-Enríquez, Veracruz, a " + fecha);
            content.newLine();
            content.newLine();

            String[] destinatario = {
                a.getNombreResponsable().toUpperCase(),
                a.getPuestoResponsable().toUpperCase(),
                a.getDepartamentoResponsable().toUpperCase(),
                a.getNombreOrganizacion().toUpperCase(),
                a.getDireccionOrganizacion(),
                "XALAPA-ENRÍQUEZ, VERACRUZ"
            };
            for (String linea : destinatario) {
                content.showText(linea);
                content.newLine();
            }
            content.newLine();

            String cuerpo = String.format("""
                En atención a su solicitud expresada a la Coordinación de Prácticas Profesionales de la 
                Licenciatura en Ingeniería de Software, hacemos de su conocimiento que el C. %s
                estudiante de la Licenciatura con matrícula %s, ha sido asignado al proyecto de 
                %s, a su digno cargo a partir del %s del presente 
                hasta cubrir 420 HORAS. Cabe mencionar que el estudiante cuenta 
                con la formación y el perfil para las actividades a desempeñar.

                Anexo a este documento usted encontrará una copia del horario de las experiencias educativas 
                que el estudiante asignado se encuentra cursando para que sea respetado y tomado en cuenta al
                momento de establecer el horario de realización de sus Prácticas Profesionales.

                Por otra parte, le solicito de la manera más atenta, haga llegar a la brevedad con el 
                estudiante, el oficio de aceptación así como el plan de trabajo detallado del estudiante
                además del horario que cubrirá. Deberá indicar además, la forma en que 
                se registrará la evidencia de asistencia y número de horas cubiertas.

                Es importante mencionar que el estudiante deberá presentar mensualmente un reporte de avances
                de sus prácticas. Este reporte de avances puede entregarse hasta con una semana de atraso por
                lo que le solicito de la manera más atenta sean elaborados y avalados (incluyendo sello si aplica)
                de manera oportuna para su entrega al académico responsable de la experiencia 
                de Prácticas de Ingeniería de Software.

                En relación con lo anterior, es importante que en el oficio de aceptación proporcione el nombre
                de la persona que supervisará y avalará en su dependencia la prestación de las prácticas profesionales
                así como número telefónico, extensión (cuando aplique) y correo electrónico. 



                Sin más por el momento, agradezco su atención al presente reiterándole a usted mis apreciables órdenes.
                """,
                a.getNombreEstudiante().toUpperCase(),
                a.getMatricula(),
                a.getNombreProyecto().toUpperCase(),
                a.getFechaInicio().format(DateTimeFormatter.ofPattern("d 'de' MMMM", new Locale("es", "MX")))
            );

            for (String linea : cuerpo.split("\n")) {
                content.showText(linea.trim());
                content.newLine();
            }

            content.newLine();
            content.showText("Atentamente,");
            content.newLine();
            content.newLine();
            content.showText("Dr. Ángel Juárez Sánchez García");
            content.newLine();
            content.showText("Coordinador de Servicio Social y Prácticas Profesionales");
            content.newLine();
            content.showText("Licenciatura en Ingeniería de Software");
            content.newLine();
            content.showText("Universidad Veracruzana");

            content.endText();
            content.close();

            document.save(baos);
            return baos.toByteArray();

        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
