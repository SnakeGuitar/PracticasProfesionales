/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 13-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 13-06-2025
 * Descripción: Clase beans del modelo de dominio
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.modelo.beans.expediente.reporte;

import java.sql.Date;
import java.time.LocalDateTime;

public class EntregaReporte {
    private int idEntregaReporte;
    private int numeroReporte;
    private LocalDateTime fechaApertura;
    private LocalDateTime fechaLimite;
    private LocalDateTime fechaEntrega;
    private int idEstudiante;
    private int idPeriodo;

    public EntregaReporte() {
    }

    public EntregaReporte(int idEntregaReporte, int numeroReporte, LocalDateTime fechaApertura, LocalDateTime fechaLimite, LocalDateTime fechaEntrega, int idEstudiante, int idPeriodo) {
        this.idEntregaReporte = idEntregaReporte;
        this.numeroReporte = numeroReporte;
        this.fechaApertura = fechaApertura;
        this.fechaLimite = fechaLimite;
        this.fechaEntrega = fechaEntrega;
        this.idEstudiante = idEstudiante;
        this.idPeriodo = idPeriodo;
    }

    public int getIdEntregaReporte() {
        return idEntregaReporte;
    }

    public void setIdEntregaReporte(int idEntregaReporte) {
        this.idEntregaReporte = idEntregaReporte;
    }

    public int getNumeroReporte() {
        return numeroReporte;
    }

    public void setNumeroReporte(int numeroReporte) {
        this.numeroReporte = numeroReporte;
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
