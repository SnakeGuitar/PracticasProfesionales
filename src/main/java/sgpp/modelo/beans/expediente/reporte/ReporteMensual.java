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

import sgpp.modelo.beans.expediente.Documento;
import sgpp.modelo.beans.expediente.EstadoDocumento;
import sgpp.modelo.dao.expediente.TipoDocumento;

public class ReporteMensual extends Documento {
    private int idReporteMensual;
    private Mes mes;
    private int horasReportadas;
    private EstadoDocumento estado;
    private String observaciones;
    private byte[] reporte;
    private int idEntregaReporte;

    public ReporteMensual() {
    }

    public ReporteMensual(int idReporteMensual, Mes mes, int horasReportadas, EstadoDocumento estado, String observaciones, byte[] reporte, int idEntregaReporte) {
        this.idReporteMensual = idReporteMensual;
        this.mes = mes;
        this.horasReportadas = horasReportadas;
        this.estado = estado;
        this.observaciones = observaciones;
        this.reporte = reporte;
        this.idEntregaReporte = idEntregaReporte;
    }

    public int getIdReporteMensual() {
        return idReporteMensual;
    }

    public void setIdReporteMensual(int idReporteMensual) {
        this.idReporteMensual = idReporteMensual;
    }

    public Mes getMes() {
        return mes;
    }

    public void setMes(Mes mes) {
        this.mes = mes;
    }

    public int getHorasReportadas() {
        return horasReportadas;
    }

    public void setHorasReportadas(int horasReportadas) {
        this.horasReportadas = horasReportadas;
    }

    public EstadoDocumento getEstado() {
        return estado;
    }

    public void setEstado(EstadoDocumento estado) {
        this.estado = estado;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    //En este caso, su getter se tiene un nombre distinto para permitir la compatibilidad para descarga
    //con otros tipos de Documento
    @Override
    public byte[] getDocumento() {
        return reporte;
    }

    public void setReporte(byte[] reporte) {
        this.reporte = reporte;
    }

    public int getIdEntregaReporte() {
        return idEntregaReporte;
    }

    public void setIdEntregaReporte(int idEntregaReporte) {
        this.idEntregaReporte = idEntregaReporte;
    }

    @Override
    public TipoDocumento getTipoDocumento() {
        return TipoDocumento.REPORTE_MENSUAL;
    }

    @Override
    public String toString() {
        return String.format("Reporte Mensual - %s", mes.toString());
    }
}
