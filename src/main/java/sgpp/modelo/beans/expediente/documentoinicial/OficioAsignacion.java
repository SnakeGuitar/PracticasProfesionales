/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: POJO para representar un oficio de asignación con su PDF asociado.
 */

package sgpp.modelo.beans.expediente.documentoinicial;

public class OficioAsignacion {
    private int idOficio;
    private int idEstudiante;
    private int idPeriodo;
    private byte[] documento;

    public OficioAsignacion() {
    }

    public OficioAsignacion(int idOficio, int idEstudiante, int idPeriodo, byte[] documento) {
        this.idOficio = idOficio;
        this.idEstudiante = idEstudiante;
        this.idPeriodo = idPeriodo;
        this.documento = documento;
    }

    public int getIdOficio() {
        return idOficio;
    }

    public void setIdOficio(int idOficio) {
        this.idOficio = idOficio;
    }

    public int getIdEstudiante() {
        return idEstudiante;
    }

    public void setIdEstudiante(int idEstudiante) {
        this.idEstudiante = idEstudiante;
    }

    public int getIdPeriodo() {
        return idPeriodo;
    }

    public void setIdPeriodo(int idPeriodo) {
        this.idPeriodo = idPeriodo;
    }

    public byte[] getDocumento() {
        return documento;
    }

    public void setDocumento(byte[] documento) {
        this.documento = documento;
    }
}
