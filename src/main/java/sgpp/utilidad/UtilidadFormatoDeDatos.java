/*
 * Autor original: Abel Yong
 * Ultimo autor: Abel Yong
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025 16:42
 * Descripción: Clase DAO para contener validaciones comunes de formato de datos.
 */

/*
 * Estado: En progreso
 * Modificaciones: movido esUnNumeroEntero
 */

package sgpp.utilidad;

import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextFormatter;
import javafx.util.StringConverter;
import org.w3c.dom.Text;

import java.time.DateTimeException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class UtilidadFormatoDeDatos {
    public static boolean esUnNumeroEntero(String numero) {
        try {
            Integer.parseInt(numero);
            return true;
        } catch (NumberFormatException nfex) {
            return false;
        }
    }

    public static LocalDateTime stringToLocalDateTime(String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return LocalDateTime.parse(date, formatter);
    }

    public static String localDateTimeToString(LocalDateTime date) {
        String fecha = "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        try {
             fecha = date.format(formatter);
        } catch (DateTimeException | NullPointerException ex) {
            fecha = "";
        }
        return fecha;
    }

    public static void configurarTextAreaConFormatter(TextArea textArea, Label lbContador, int limiteCaracteres) {
        TextFormatter<String> formatter = new TextFormatter<String>(
                new StringConverter<String>() {
                    @Override
                    public String toString(String object) {
                        return object != null ? object : "";
                    }

                    @Override
                    public String fromString(String string) {
                        return string;
                    }
                },
                "", // valor inicial
                change -> {
                    String newText = change.getControlNewText();
                    if (newText.length() <= limiteCaracteres) {
                        return change; // Permitir el cambio
                    } else {
                        return null; // Rechazar el cambio
                    }
                }
        );

        textArea.setTextFormatter(formatter);

        textArea.textProperty().addListener((observable, oldValue, newValue) -> {
            actualizarContador(lbContador, newValue.length(), limiteCaracteres);
        });

        actualizarContador(lbContador, 0, limiteCaracteres);
    }

    // Método para actualizar el label del contador
    private static void actualizarContador(Label lbContador, int caracteres, int limiteCaracteres) {
        lbContador.setText(caracteres + "/" + limiteCaracteres);

        if (caracteres > limiteCaracteres * 0.9) {
            lbContador.setStyle("-fx-text-fill: red;");
        } else if (caracteres > limiteCaracteres * 0.75) {
            lbContador.setStyle("-fx-text-fill: orange;");
        } else {
            lbContador.setStyle("-fx-text-fill: black;");
        }
    }

}
