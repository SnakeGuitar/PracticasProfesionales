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

    //javadoc
    /**
     * Valida la longitud del nombre de la organización.
     *
     * @param nombre Nombre de la organización a validar.
     * @return true si el nombre es válido, false en caso contrario.
     */
    @Contract(pure = true)
    public static boolean validarLongitudNombre(String nombre) {
        return nombre.length() <= LONGITUD_MAXIMA_NOMBRE;
    }

    /**
     * Valida la longitud del teléfono de la organización.
     *
     * @param telefono Teléfono de la organización a validar.
     * @return true si el teléfono es válido, false en caso contrario.
     */
    @Contract(pure = true)
    public static boolean validarLongitudTelefono(String telefono) {
        return telefono.length() == LONGITUD_TELEFONO;
    }

    /**
     * Valida la longitud del correo electrónico de la organización.
     *
     * @param correo Correo electrónico de la organización a validar.
     * @return true si el correo es válido, false en caso contrario.
     */
    @Contract(pure = true)
    public static boolean validarLongitudCorreo(String correo) {
        return correo.length() <= LONGITUD_MAXIMA_CORREO;
    }

    /**
     * Valida la longitud de la dirección de la organización.
     *
     * @param direccion Dirección de la organización a validar.
     * @return true si la dirección es válida, false en caso contrario.
     */
    @Contract(pure = true)
    public static boolean validarLongitudDireccion(String direccion) {
        return direccion.length() <= LONGITUD_MAXIMA_DIRECCION;
    }

    /**
     * Valida la longitud de la ciudad de la organización.
     *
     * @param ciudad Ciudad de la organización a validar.
     * @return true si la ciudad es válida, false en caso contrario.
     */
    @Contract(pure = true)
    public static boolean validarLongitudCiudad(String ciudad) {
        return ciudad.length() <= LONGITUD_MAXIMA_CIUDAD;
    }

    /**
     * Valida la longitud del estado de la organización.
     *
     * @param estado Estado de la organización a validar.
     * @return true si el estado es válido, false en caso contrario.
     */
    @Contract(pure = true)
    public static boolean validarLongitudEstado(String estado) {
        return estado.length() <= LONGITUD_MAXIMA_ESTADO;
    }
    
    /**
     * Verifica si el sector proporcionado es válido.
     *
     * @param sector Sector a verificar.
     * @return true si el sector es válido, false en caso contrario.
     */
    public static boolean verificarSector(String sector) {
        for (String s : SECTORES_VALIDOS) {
            if (s.equalsIgnoreCase(sector)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Verifica si el nombre proporcionado contiene solo letras y espacios.
     *
     * @param correo Nombre a verificar.
     * @return true si el nombre es válido, false en caso contrario.
     */
    public static boolean verificarFormatoCorreo(String correo) {
        return PATRON_CORREO.matcher(correo).matches();
    }

    /**
     * Verifica si el teléfono proporcionado tiene el formato correcto.
     *
     * @param telefono Teléfono a verificar.
     * @return true si el teléfono es válido, false en caso contrario.
     */
    @Contract(pure = true)
    public static boolean verificarFormatoTelefono(String telefono) {
        return telefono.matches("\\d{" + LONGITUD_TELEFONO + "}");
    }
}