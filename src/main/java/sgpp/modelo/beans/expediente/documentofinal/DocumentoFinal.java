package sgpp.modelo.beans.expediente.documentofinal;

import sgpp.modelo.beans.expediente.EstadoDocumento;

import java.sql.Date;

public class DocumentoFinal {
    private int idDocumentoFinal;
    private Date fechaEntrega;
    private TipoDocumentoFinal tipo;
    private EstadoDocumento estado;
    private byte[] documento;
    private int idEntregaDocumentoFinal;

    public DocumentoFinal() {
    }

    public DocumentoFinal(int idDocumentoFinal, Date fechaEntrega, TipoDocumentoFinal tipo, EstadoDocumento estado, byte[] documento, int idEntregaDocumentoFinal) {
        this.idDocumentoFinal = idDocumentoFinal;
        this.fechaEntrega = fechaEntrega;
        this.tipo = tipo;
        this.estado = estado;
        this.documento = documento;
        this.idEntregaDocumentoFinal = idEntregaDocumentoFinal;
    }

    public int getIdDocumentoFinal() {
        return idDocumentoFinal;
    }

    public void setIdDocumentoFinal(int idDocumentoFinal) {
        this.idDocumentoFinal = idDocumentoFinal;
    }

    public Date getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(Date fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }

    public TipoDocumentoFinal getTipo() {
        return tipo;
    }

    public void setTipo(TipoDocumentoFinal tipo) {
        this.tipo = tipo;
    }

    public EstadoDocumento getEstado() {
        return estado;
    }

    public void setEstado(EstadoDocumento estado) {
        this.estado = estado;
    }

    public byte[] getDocumento() {
        return documento;
    }

    public void setDocumento(byte[] documento) {
        this.documento = documento;
    }

    public int getIdEntregaDocumentoFinal() {
        return idEntregaDocumentoFinal;
    }

    public void setIdEntregaDocumentoFinal(int idEntregaDocumentoFinal) {
        this.idEntregaDocumentoFinal = idEntregaDocumentoFinal;
    }
}
