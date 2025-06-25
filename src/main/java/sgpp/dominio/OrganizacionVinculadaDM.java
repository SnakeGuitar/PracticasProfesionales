/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 10-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 25-06-2025
 * Descripción: Clase de dominio para manejar la información de las organizaciones vinculadas
 */

/*
 * Estado: En progreso
 * Modificaciones: Se modularizaron los métodos
 *                 Se agregaron más validacionees para los campos
 */

package sgpp.dominio;

import org.jetbrains.annotations.Contract;

import java.util.regex.Pattern;

public class OrganizacionVinculadaDM {
    private static final int LONGITUD_MAXIMA_NOMBRE = 100;
    private static final String[] SECTORES_VALIDOS = {"PUBLICO", "PRIVADO", "SOCIAL"};
    private static final int LONGITUD_TELEFONO = 10;
    private static final int LONGITUD_MAXIMA_CORREO = 50;
    private static final int LONGITUD_MAXIMA_DIRECCION = 100;
    private static final int LONGITUD_MAXIMA_CIUDAD = 50;
    private static final int LONGITUD_MAXIMA_ESTADO = 50;

    private static final Pattern PATRON_CORREO = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

    @Contract(pure = true)
    public static boolean validarLongitudNombre(String nombre) {
        return nombre.length() <= LONGITUD_MAXIMA_NOMBRE;
    }

    @Contract(pure = true)
    public static boolean validarLongitudTelefono(String telefono) {
        return telefono.length() == LONGITUD_TELEFONO;
    }

    @Contract(pure = true)
    public static boolean validarLongitudCorreo(String correo) {
        return correo.length() <= LONGITUD_MAXIMA_CORREO;
    }

    @Contract(pure = true)
    public static boolean validarLongitudDireccion(String direccion) {
        return direccion.length() <= LONGITUD_MAXIMA_DIRECCION;
    }

    @Contract(pure = true)
    public static boolean validarLongitudCiudad(String ciudad) {
        return ciudad.length() <= LONGITUD_MAXIMA_CIUDAD;
    }

    @Contract(pure = true)
    public static boolean validarLongitudEstado(String estado) {
        return estado.length() <= LONGITUD_MAXIMA_ESTADO;
    }


    public static boolean verificarSector(String sector) {
        for (String s : SECTORES_VALIDOS) {
            if (s.equalsIgnoreCase(sector)) {
                return true;
            }
        }
        return false;
    }

    public static boolean verificarFormatoCorreo(String correo) {
        return PATRON_CORREO.matcher(correo).matches();
    }

    @Contract(pure = true)
    public static boolean verificarFormatoTelefono(String telefono) {
        return telefono.matches("\\d{" + LONGITUD_TELEFONO + "}");
    }
}