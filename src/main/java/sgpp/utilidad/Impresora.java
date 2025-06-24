package sgpp.utilidad;

import javafx.scene.control.Control;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.interactive.form.PDAcroForm;
import org.apache.pdfbox.pdmodel.interactive.form.PDField;
import org.apache.pdfbox.pdmodel.interactive.form.PDTextField;
import org.apache.pdfbox.pdmodel.interactive.form.PDCheckBox;
import sgpp.modelo.beans.Coordinador;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.beans.expediente.documentofinal.AutoEvaluacion;
import sgpp.modelo.beans.expediente.documentoinicial.TablaAsignacion;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;
import sgpp.modelo.dao.entidades.*;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class Impresora {

    // Métodos para rúbrica de presentación.
    public static void descargarRubrica(RubricaPresentacion rubrica, Control componente, int idEstudiante) {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Descargar documento");

        //Generar un nombre apropiado

        String nombreSugerido = String.format(
                "Evaluacion-Presentacion_%s_%s.pdf",
                recuperarNombreDeEstudiante(idEstudiante).replace(" ", ""),
                rubrica.getFechaHora().format(DateTimeFormatter.ofPattern("dd_MM_yyyy")));

        //Configurar el filechooser
        configurarFileChooser(fileChooser, nombreSugerido);

        Stage stage = Utilidad.getEscenarioComponente(componente);
        File destino = fileChooser.showSaveDialog(stage);

        //Guardar el archivo en el destino
        if (destino != null) {
            try {
                byte[] pdf = Impresora.generarRubricaEvaluacion(rubrica);
                Files.write(destino.toPath(), pdf);
                Utilidad.crearAlertaInformacion(
                        "Exito",
                        "Documento descargado exitosamente a: \n"+destino.getAbsolutePath()
                );
            } catch (IOException ioex) {
                System.out.println(ioex.getMessage());
                Utilidad.crearAlertaError(
                        "Error",
                        "Lo sentimos, no fue posible guardar la rubrica en su dispositivo");
            }
        }
    }

    /**
     * Convierta la rubrica en un PDF
     */
    private static byte[] generarRubricaEvaluacion(RubricaPresentacion rubrica) throws IOException {
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
                    "Formato: RÚBRICA DE PRESENTACIÓN ORAL DEL INFORME PARCIAL",
                    "EE PRÁCTICAS PROFESIONALES DE INGENIERÍA DE SOFTWARE"
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

    // Métodos para rúbrica de presentación.
    public static void descargarAutoEvaluacion(AutoEvaluacion autoEvaluacion, Control componente, int idEstudiante) {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Descargar documento");

        //Generar un nombre apropiado

        String nombreSugerido = String.format(
                "Autoevaluacion_%s_%s.pdf",
                recuperarNombreDeEstudiante(idEstudiante).replace(" ", ""),
                autoEvaluacion.getFechaHora().format(DateTimeFormatter.ofPattern("dd_MM_yyyy")));

        //Configurar el filechooser
        configurarFileChooser(fileChooser, nombreSugerido);

        Stage stage = Utilidad.getEscenarioComponente(componente);
        File destino = fileChooser.showSaveDialog(stage);

        if (destino != null) {
            //Guardar el archivo en el destino
            try {
                byte[] pdf = Impresora.generarAutoEvaluacion(autoEvaluacion);
                Files.write(destino.toPath(), pdf);
                Utilidad.crearAlertaInformacion(
                        "Exito",
                        "Documento descargado exitosamente a: \n"+destino.getAbsolutePath()
                );
            } catch (IOException ioex) {
                System.out.println(ioex.getMessage());
                Utilidad.crearAlertaError(
                        "Error",
                        "Lo sentimos, no fue posible guardar la autoevaluación en su dispositivo");
            }
        }
    }

    /**
     * Convierta la rubrica en un PDF
     */
    private static byte[] generarAutoEvaluacion(AutoEvaluacion autoEvaluacion) throws IOException {
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
                    "Formato: EVALUACIÓN DEL ALUMNO",
                    "EE PRÁCTICAS PROFESIONALES DE INGENIERÍA DE SOFTWARE"
            };

            escribirLineaPorLinea(content, encabezado);

            int idProyecto = recuperarIdProyecto(autoEvaluacion.getIdEstudiante());
            String[] datosDelProyecto = {
                    "Datos del Proyecto",
                    "Alumno(a): " + recuperarNombreDeEstudiante(autoEvaluacion.getIdEstudiante()),
                    "Matricula" + recuperarMatriculaDeEstudiante(autoEvaluacion.getIdEstudiante()),
                    "Proyecto: " + recuperarNombreDeProyecto(autoEvaluacion.getIdEstudiante()),
                    "Organizacion Vinculada: " + recuperarNombreDeOV(idProyecto),
                    "Responsable del proyecto: " + recuperarNombreDeResponsable(autoEvaluacion.getIdResponsable()),
                    "Departamento: " + recuperarDepartamento(autoEvaluacion.getIdResponsable()),
                    "Periodo del reporte: " + recuperarAbreviaturaPerido(autoEvaluacion.getIdPeriodo()),
                    "Fecha del reporte: " + autoEvaluacion.getFechaHora().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))
            };

            content.newLine();
            escribirLineaPorLinea(content, datosDelProyecto);

            int[] criterios = autoEvaluacion.getCriterios();
            if (criterios != null && criterios.length == 10) {
                String criterio1 = obtenerPuntaje(criterios[0]);
                String criterio2 = obtenerPuntaje(criterios[1]);
                String criterio3 = obtenerPuntaje(criterios[2]);
                String criterio4 = obtenerPuntaje(criterios[3]);
                String criterio5 = obtenerPuntaje(criterios[4]);
                String criterio6 = obtenerPuntaje(criterios[5]);
                String criterio7 = obtenerPuntaje(criterios[6]);
                String criterio8 = obtenerPuntaje(criterios[7]);
                String criterio9 = obtenerPuntaje(criterios[8]);
                String criterio10 = obtenerPuntaje(criterios[9]);

                String[] evaluacionCriterios = {
                        String.format("Mi participación en la Organización Vinculada fue productiva: %s (%s)",
                                criterio1, criterios[0]),
                        String.format("Logré la aplicación de los conocimientos teórico-prácticos adquiridos en la Licenciatura en Ingeniería\n de Software: %s (%s)",
                                criterio2, criterios[1]),
                        String.format("Me sentí seguro al realizar las actividades encomendadas: %s (%s)",
                                criterio3, criterios[2]),
                        String.format("Las actividades encomendadas despertaron mi interés: %s (%s)",
                                criterio4, criterios[3]),
                        String.format("La Organización Vinculada me proporcionó la información y facilidades adecuados durante el desarrollo\n de las prácticas: %s (%s)",
                                criterio5, criterios[4]),
                        String.format("La Organización Vinculada me dio a conocer las reglas internas que debía seguir al conducirme\n durante el desarrollo de las prácticas: %s (%s)",
                                criterio6, criterios[5]),
                        String.format("El Responsable del Proyecto me orientó correctamente para el desarrollo de mis actividades: %s (%s)",
                                criterio7, criterios[6]),
                        String.format("El Responsable del Proyecto realizó un seguimiento efectivo de mis actividades: %s (%s)",
                                criterio8, criterios[7]),
                        String.format("El proyecto es congruente con la formación de mi carrera: %s (%s)",
                                criterio9, criterios[8]),
                        String.format("Considero que las prácticas son importantes para mi formación profesional: %s (%s)",
                                criterio10, criterios[9]),
                };

                content.newLine();
                escribirLineaPorLinea(content, evaluacionCriterios);
            }

            content.newLine();
            String[] cierre = {
                    String.format("PUNTUACION FINAL: %s", autoEvaluacion.getPuntuacionFinal())
            };

            escribirLineaPorLinea(content, cierre);

            content.endText();
            content.close();
            document.save(baos);
            return baos.toByteArray();
        }
    }

    private static void configurarFileChooser(FileChooser fileChooser, String nombreSugerido) {
        fileChooser.setInitialFileName(nombreSugerido);
        fileChooser.getExtensionFilters().add(
                new FileChooser.ExtensionFilter("Documento PDF", "*.pdf"));
    }

    private static String determinarNivel(float calificacion) {
        if (calificacion >= 9.1) return "COMPETENTE";
        else if (calificacion >= 8.1) return "INDEPENDIENTE";
        else if (calificacion >= 7.1) return "BÁSICO AVANZADO";
        else if (calificacion >= 6.0) return "BÁSICO UMBRAL";
        else return "NO COMPETENTE";
    }

    private static String obtenerPuntaje(int criterio) {
        return switch (criterio) {
            case 1 -> "TOTALMENTE EN DESACUERDO";
            case 2 -> "EN DESACUERDO";
            case 3 -> "INDECISO";
            case 4 -> "DE ACUERDO";
            case 5 -> "TOTALMENTE DE ACUERDO";
            default -> "NULL";
        };
    }

    private static void escribirLineaPorLinea(PDPageContentStream content, String[] lineas) throws IOException {
        for (String linea : lineas) {
            String lineaLimpia = linea.replaceAll("\\r", ""); // Eliminar carriage return
            String[] sublíneas = lineaLimpia.split("\\n"); // Dividir por line feed

            for (String sublinea : sublíneas) {
                // Eliminar cualquier otro carácter de control que pueda causar problemas
                String sublineaFinal = sublinea.replaceAll("[\\x00-\\x08\\x0B\\x0C\\x0E-\\x1F\\x7F]", "");
                content.showText(sublineaFinal);
                content.newLine();
            }
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

    private static String recuperarMatriculaDeEstudiante(int idEstudiante) {
        String matriculaEstudiante = "";
        try {
            matriculaEstudiante = EstudianteDAO.obtenerPorId(idEstudiante).getMatricula();
        } catch (SQLException sqlex) {
            System.err.println("Error al recuperar la matrícula del estudiante: " + sqlex.getMessage());
        }
        return matriculaEstudiante;
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

    private static String recuperarNombreDeResponsable(int idResponsable) {
        String nombreResponsable = "";
        try {
            nombreResponsable = ResponsableTecnicoDAO.obtenerPorId(idResponsable).getNombre();
        } catch (SQLException sqlex) {
            System.err.println("Error al recuperar el nombre del responsable técnico "+sqlex.getMessage());
        }
        return nombreResponsable;
    }

    private static String recuperarDepartamento(int idResponsable) {
        String departamento = "";
        try {
            departamento = ResponsableTecnicoDAO.obtenerPorId(idResponsable).getDepartamento();
        } catch (SQLException sqlex) {
            System.err.println("Error al recuperar el departamento del responsable técnico "+sqlex.getMessage());
        }
        return departamento;
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

    public static byte[] generarDocumentoAsignacion(TablaAsignacion a, Coordinador coordinador) {
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
            content.showText(String.format("%s", coordinador.getNombre().toUpperCase()));
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
