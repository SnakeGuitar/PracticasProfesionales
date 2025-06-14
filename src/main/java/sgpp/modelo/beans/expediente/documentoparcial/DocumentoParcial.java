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

package sgpp.modelo.beans.expediente.documentoparcial;

import sgpp.modelo.beans.expediente.EstadoDocumento;

public class DocumentoParcial {
    private int idDocumentoParcial;
    private int fechaEntrega;
    private TipoDocumentoParcial tipo;
    private EstadoDocumento estado;
    private byte[] documento;
    private int idEntregaDocumentoParcial;

    public DocumentoParcial() {
    }

    public DocumentoParcial(int idDocumentoParcial, int fechaEntrega, TipoDocumentoParcial tipo, EstadoDocumento estado, byte[] documento, int idEntregaDocumentoParcial) {
        this.idDocumentoParcial = idDocumentoParcial;
        this.fechaEntrega = fechaEntrega;
        this.tipo = tipo;
        this.estado = estado;
        this.documento = documento;
        this.idEntregaDocumentoParcial = idEntregaDocumentoParcial;
    }

    public int getIdDocumentoParcial() {
        return idDocumentoParcial;
    }

    public void setIdDocumentoParcial(int idDocumentoParcial) {
        this.idDocumentoParcial = idDocumentoParcial;
    }

    public int getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(int fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }

    public TipoDocumentoParcial getTipo() {
        return tipo;
    }

    public void setTipo(TipoDocumentoParcial tipo) {
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

    public int getIdEntregaDocumentoParcial() {
        return idEntregaDocumentoParcial;
    }

    public void setIdEntregaDocumentoParcial(int idEntregaDocumentoParcial) {
        this.idEntregaDocumentoParcial = idEntregaDocumentoParcial;
    }
}
