package sgpp.modelo.beans.expediente;

import java.time.LocalDateTime;

public abstract class Documento {
    int idDocumento;
    LocalDateTime fechaEntrega;
    EstadoDocumento estado;
    // Enum tipo;
    byte[] documento;
    int idEntregaDocumento;

    public Documento() {}

    public Documento(int idDocumento, LocalDateTime fechaEntrega, EstadoDocumento estado, byte[] documento, int idEntregaDocumento) {
        this.idEntregaDocumento = idEntregaDocumento;
        this.documento = documento;
        this.estado = estado;
        this.fechaEntrega = fechaEntrega;
        this.idDocumento = idDocumento;
    }

    public int getIdDocumento() {
        return idDocumento;
    }

    public void setIdDocumento(int idDocumento) {
        this.idDocumento = idDocumento;
    }

    public LocalDateTime getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(LocalDateTime fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
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

    public int getIdEntregaDocumento() {
        return idEntregaDocumento;
    }

    public void setIdEntregaDocumento(int idEntregaDocumento) {
        this.idEntregaDocumento = idEntregaDocumento;
    }

    public abstract Enum<?> getTipoDocumento();
}