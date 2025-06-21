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

import sgpp.modelo.beans.expediente.EntregaDocumento;

import java.time.LocalDateTime;

public class EntregaDocumentoParcial extends EntregaDocumento {
    private int idEntregaDocumentoParcial;
    private LocalDateTime fechaApertura;
    private LocalDateTime fechaLimite;
    private int idEstudiante;
    private int idPeriodo;

    public EntregaDocumentoParcial() {
    }

    public EntregaDocumentoParcial(int idEntregaDocumentoParcial, LocalDateTime fechaApertura, LocalDateTime fechaLimite, int idEstudiante, int idPeriodo) {
        super(fechaApertura, fechaLimite, idEstudiante, idPeriodo);
        this.idEntregaDocumentoParcial = idEntregaDocumentoParcial;
    }

    public int getIdEntregaDocumentoParcial() {
        return idEntregaDocumentoParcial;
    }

    public void setIdEntregaDocumentoParcial(int idEntregaDocumentoParcial) {
        this.idEntregaDocumentoParcial = idEntregaDocumentoParcial;
    }
}