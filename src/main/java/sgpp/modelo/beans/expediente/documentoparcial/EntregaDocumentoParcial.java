package sgpp.modelo.beans.expediente.documentoparcial;

import java.util.Date;

public class EntregaDocumentoParcial {
    private int idEntregaDocumentoParcial;
    private Date fechaApertura;
    private Date fechaLimite;
    private int idEstudiante;
    private int idPeriodo;

    public EntregaDocumentoParcial() {
    }

    public EntregaDocumentoParcial(int idEntregaDocumentoParcial, Date fechaApertura, Date fechaLimite, int idEstudiante, int idPeriodo) {
        this.idEntregaDocumentoParcial = idEntregaDocumentoParcial;
        this.fechaApertura = fechaApertura;
        this.fechaLimite = fechaLimite;
        this.idEstudiante = idEstudiante;
        this.idPeriodo = idPeriodo;
    }

    public int getIdEntregaDocumentoParcial() {
        return idEntregaDocumentoParcial;
    }

    public void setIdEntregaDocumentoParcial(int idEntregaDocumentoParcial) {
        this.idEntregaDocumentoParcial = idEntregaDocumentoParcial;
    }

    public Date getFechaApertura() {
        return fechaApertura;
    }

    public void setFechaApertura(Date fechaApertura) {
        this.fechaApertura = fechaApertura;
    }

    public Date getFechaLimite() {
        return fechaLimite;
    }

    public void setFechaLimite(Date fechaLimite) {
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
