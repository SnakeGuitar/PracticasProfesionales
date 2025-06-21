/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 20-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 20-06-2025
 * Descripción: Clase abstracta para simplificar el manejo de metodos entre entregas
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.modelo.beans.expediente;

import java.time.LocalDateTime;

public abstract class EntregaDocumento {
    LocalDateTime fechaApertura;
    LocalDateTime fechaLimite;
    int idEstudiante;
    int idPeriodo;

    public EntregaDocumento() {}

    public EntregaDocumento(LocalDateTime fechaApertura, LocalDateTime fechaLimite, int idEstudiante, int idPeriodo) {
        this.fechaApertura = fechaApertura;
        this.fechaLimite = fechaLimite;
        this.idEstudiante = idEstudiante;
        this.idPeriodo = idPeriodo;
    }

    public LocalDateTime getFechaApertura() {
        return fechaApertura;
    }

    public void setFechaApertura(LocalDateTime fechaApertura) {
        this.fechaApertura = fechaApertura;
    }

    public LocalDateTime getFechaLimite() {
        return fechaLimite;
    }

    public void setFechaLimite(LocalDateTime fechaLimite) {
        this.fechaLimite = fechaLimite;
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
}
