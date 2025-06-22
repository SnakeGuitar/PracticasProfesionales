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
}
