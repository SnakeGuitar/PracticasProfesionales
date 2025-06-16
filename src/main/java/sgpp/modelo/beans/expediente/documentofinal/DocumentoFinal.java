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

package sgpp.modelo.beans.expediente.documentofinal;

import sgpp.modelo.beans.expediente.Documento;
import sgpp.modelo.beans.expediente.EstadoDocumento;

import java.util.Date;

public class DocumentoFinal extends Documento {
    private int idDocumentoFinal;
    private Date fechaEntrega;
    private TipoDocumentoFinal tipo;
    private EstadoDocumento estado;
    private byte[] documento;
    private int idEntregaDocumentoFinal;

    public DocumentoFinal() {}

    public DocumentoFinal(int idDocumentoFinal, Date fechaEntrega, TipoDocumentoFinal tipo, EstadoDocumento estado, byte[] documento, int idEntregaDocumentoFinal) {
        super(idDocumentoFinal, fechaEntrega, estado, documento, idEntregaDocumentoFinal);
        this.tipo = tipo;
    }

    public TipoDocumentoFinal getTipo() {
        return tipo;
    }

    public void setTipo(TipoDocumentoFinal tipo) {
        this.tipo = tipo;
    }

    @Override
    public Enum<?> getTipoDocumento() {
        return tipo;
    }
}
