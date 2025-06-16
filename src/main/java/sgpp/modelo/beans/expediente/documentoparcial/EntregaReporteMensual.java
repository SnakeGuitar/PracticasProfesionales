/*
 * Autor original: ChatGPT
 * Último autor: ChatGPT
 * Fecha de creación: 16-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 16-06-2025
 * Descripción: POJO para representar la entidad 'entrega_reporte'.
 */

/*
 * Estado: En funcionamiento
 * Modificaciones:
 */

package sgpp.modelo.beans.expediente.documentoparcial;

import java.time.LocalDateTime;

public class EntregaReporteMensual{
    private int idEntregaReporte;
    private int numReporte;
    private LocalDateTime fechaApertura;
    private LocalDateTime fechaLimite;
    private LocalDateTime fechaEntrega;
    private int idEstudiante;
    private int idPeriodo;

    public int getIdEntregaReporte() {
        return idEntregaReporte;
    }

    public void setIdEntregaReporte(int idEntregaReporte) {
        this.idEntregaReporte = idEntregaReporte;
    }

    public int getNumReporte() {
        return numReporte;
    }

    public void setNumReporte(int numReporte) {
        this.numReporte = numReporte;
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

    public LocalDateTime getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(LocalDateTime fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
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
