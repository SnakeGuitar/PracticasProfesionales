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

import sgpp.modelo.beans.expediente.Documento;
import sgpp.modelo.beans.expediente.EstadoDocumento;

import java.time.LocalDateTime;

public class DocumentoParcial extends Documento {
    private int idDocumentoParcial;
    private LocalDateTime fechaEntrega;
    private TipoDocumentoParcial tipo;
    private EstadoDocumento estado;
    private byte[] documento;
    private int idEntregaDocumentoParcial;

    public DocumentoParcial() {}

    public DocumentoParcial(int idDocumentoParcial, LocalDateTime fechaEntrega, TipoDocumentoParcial tipo, EstadoDocumento estado, byte[] documento, int idEntregaDocumentoParcial) {
        super(idDocumentoParcial, fechaEntrega, estado, documento, idEntregaDocumentoParcial);
        this.tipo = tipo;
    }

    public TipoDocumentoParcial getTipo() {
        return tipo;
    }

    public void setTipo(TipoDocumentoParcial tipo) {
        this.tipo = tipo;
    }

    @Override
    public Enum<?> getTipoDocumento() {
        return tipo;
    }
}
