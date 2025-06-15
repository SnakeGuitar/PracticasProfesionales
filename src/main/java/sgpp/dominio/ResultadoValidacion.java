/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:S/F
 * Fecha de la última modificación: 15-06-2025 16:44
 * Descripción: Clase para representar el resultado de operaciones de logica de negocio
 */

/*
 * Estado: Creado
 * Modificaciones:
 */

package sgpp.dominio;

public class ResultadoValidacion {
    private boolean valido;
    private String mensaje;

    public ResultadoValidacion() {

    }

    public boolean isValido() {
        return valido;
    }

    public void setValido(boolean valido) {
        this.valido = valido;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
}
