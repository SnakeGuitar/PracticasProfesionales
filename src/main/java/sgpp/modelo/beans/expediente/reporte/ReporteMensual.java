package sgpp.modelo.beans.expediente.reporte;

public class ReporteMensual {
    private int idReporteMensual;
    private Mes mes;
    private int horasReportadas;
    private EstadoReporte estado;
    private String observaciones;
    private byte[] reporte;
    private int idEntregaReporte;

    public ReporteMensual() {
    }

    public ReporteMensual(int idReporteMensual, Mes mes, int horasReportadas, EstadoReporte estado, String observaciones, byte[] reporte, int idEntregaReporte) {
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

    public EstadoReporte getEstado() {
        return estado;
    }

    public void setEstado(EstadoReporte estado) {
        this.estado = estado;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public byte[] getReporte() {
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
}
