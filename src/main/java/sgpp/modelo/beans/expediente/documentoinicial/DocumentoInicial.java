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

import sgpp.modelo.beans.expediente.Documento;
import sgpp.modelo.beans.expediente.EstadoDocumento;

import java.time.LocalDateTime;

public class DocumentoInicial extends Documento {
    private int idDocumentoInicial;
    private LocalDateTime fechaEntrega;
    private TipoDocumentoInicial tipo;
    private EstadoDocumento estado;
    private byte[] documento;
    private int idEntregaDocumentoInicial;

    public DocumentoInicial() {}

    public DocumentoInicial(int idDocumentoInicial, LocalDateTime fechaEntrega, TipoDocumentoInicial tipo, EstadoDocumento estado, byte[] documento, int idEntregaDocumentoInicial) {
        super(idDocumentoInicial, fechaEntrega, estado, documento, idEntregaDocumentoInicial);
        this.tipo = tipo;
    }

    public TipoDocumentoInicial getTipo() {
        return tipo;
    }

    public void setTipo(TipoDocumentoInicial tipo) {
        this.tipo = tipo;
    }

    @Override
    public Enum<?> getTipoDocumento() {
        return tipo;
    }

    @Override
    public String toString() {
        return switch (tipo) {
            case CartaAceptacion -> "Carta de Aceptacion";
            case HorarioUV -> "Horario UV";
            case Cronograma -> "Cronograma";
            case ConstanciaSeguro -> "Constancia de Seguro";
            case OficioAsignacion -> "Oficio de Asignacion";
            default -> super.toString();
        };
    }
}
