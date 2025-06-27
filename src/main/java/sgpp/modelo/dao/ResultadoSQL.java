/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada: 26-06-2025
 * Fecha de la última modificación: 26-06-2025 23:28
 * Descripción: Clase para representar el resultado de operaciones SQL en los controladores
 */

/*
 * Estado: Terminada
 * Modificaciones:
 */

package sgpp.modelo.dao;

public class ResultadoSQL {
    private boolean error;
    private String mensaje;

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
}
