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

package sgpp.modelo.beans.expediente.documentoinicial;

import sgpp.modelo.beans.expediente.EstadoDocumento;

import java.util.Date;

public class DocumentoInicial {
    private int idDocumentoInicial;
    private Date fechaEntrega;
    private TipoDocumentoInicial tipo;
    private EstadoDocumento estado;
    private byte[] documento;
    private int idEntregaDocumentoInicial;

    public DocumentoInicial() {
    }

    public DocumentoInicial(int idDocumentoInicial, Date fechaEntrega, TipoDocumentoInicial tipo, EstadoDocumento estado, byte[] documento, int idEntregaDocumentoInicial) {
        this.idDocumentoInicial = idDocumentoInicial;
        this.fechaEntrega = fechaEntrega;
        this.tipo = tipo;
        this.estado = estado;
        this.documento = documento;
        this.idEntregaDocumentoInicial = idEntregaDocumentoInicial;
    }

    public int getIdDocumentoInicial() {
        return idDocumentoInicial;
    }

    public void setIdDocumentoInicial(int idDocumentoInicial) {
        this.idDocumentoInicial = idDocumentoInicial;
    }

    public Date getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(Date fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }

    public TipoDocumentoInicial getTipo() {
        return tipo;
    }

    public void setTipo(TipoDocumentoInicial tipo) {
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

    public int getIdEntregaDocumentoInicial() {
        return idEntregaDocumentoInicial;
    }

    public void setIdEntregaDocumentoInicial(int idEntregaDocumentoInicial) {
        this.idEntregaDocumentoInicial = idEntregaDocumentoInicial;
    }
}
