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

import sgpp.modelo.beans.expediente.EntregaDocumento;

import java.time.LocalDateTime;

public class EntregaDocumentoFinal extends EntregaDocumento {
    private int idEntregaDocumentoFinal;
    private LocalDateTime fechaApertura;
    private LocalDateTime fechaLimite;
    private int idEstudiante;
    private int idPeriodo;

    public EntregaDocumentoFinal() {
    }

    public EntregaDocumentoFinal(int idEntregaDocumentoFinal, LocalDateTime fechaApertura, LocalDateTime fechaLimite, int idEstudiante, int idPeriodo) {
        super(fechaApertura, fechaLimite, idEstudiante, idPeriodo);
        this.idEntregaDocumentoFinal = idEntregaDocumentoFinal;
    }

    public int getIdEntregaDocumentoFinal() {
        return idEntregaDocumentoFinal;
    }

    public void setIdEntregaDocumentoFinal(int idEntregaDocumentoFinal) {
        this.idEntregaDocumentoFinal = idEntregaDocumentoFinal;
    }
}
