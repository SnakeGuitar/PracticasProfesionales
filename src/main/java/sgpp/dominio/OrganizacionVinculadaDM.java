package sgpp.dominio;

import javafx.scene.control.Alert;
import sgpp.utilidad.Utilidad;

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

    public static boolean validarLongitudNombre(String nombre) {
        return nombre.length() <= LONGITUD_MAXIMA_NOMBRE;
    }

    public static boolean validarLongitudTelefono(String telefono) {
        return telefono.length() == LONGITUD_TELEFONO;
    }

    public static boolean validarLongitudCorreo(String correo) {
        return correo.length() <= LONGITUD_MAXIMA_CORREO;
    }

    public static boolean validarLongitudDireccion(String direccion) {
        return direccion.length() <= LONGITUD_MAXIMA_DIRECCION;
    }

    public static boolean validarLongitudCiudad(String ciudad) {
        return ciudad.length() <= LONGITUD_MAXIMA_CIUDAD;
    }

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

    public static boolean verificarFormatoTelefono(String telefono) {
        return telefono.matches("\\d{" + LONGITUD_TELEFONO + "}");
    }
}