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

import sgpp.modelo.beans.expediente.EntregaDocumento;

import java.time.LocalDateTime;

public class EntregaDocumentoInicial extends EntregaDocumento {
    private int idEntregaDocumentoInicial;
    private LocalDateTime fechaApertura;
    private LocalDateTime fechaLimite;
    private int idEstudiante;
    private int idPeriodo;

    public EntregaDocumentoInicial() {
    }

    public EntregaDocumentoInicial(int idEntregaDocumentoInicial, LocalDateTime fechaApertura, LocalDateTime fechaLimite, int idEstudiante, int idPeriodo) {
        super(fechaApertura, fechaLimite, idEstudiante, idPeriodo);
        this.idEntregaDocumentoInicial = idEntregaDocumentoInicial;
    }

    public int getIdEntregaDocumentoInicial() {
        return idEntregaDocumentoInicial;
    }

    public void setIdEntregaDocumentoInicial(int idEntregaDocumentoInicial) {
        this.idEntregaDocumentoInicial = idEntregaDocumentoInicial;
    }
}
