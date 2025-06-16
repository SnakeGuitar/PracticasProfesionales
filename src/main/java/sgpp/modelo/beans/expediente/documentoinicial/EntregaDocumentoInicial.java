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

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Locale;

public class EntregaDocumentoInicial {
    private int idEntregaDocumentoInicial;
    private LocalDateTime fechaApertura;
    private LocalDateTime fechaLimite;
    private int idEstudiante;
    private int idPeriodo;

    public EntregaDocumentoInicial() {
    }

    public EntregaDocumentoInicial(int idEntregaDocumentoInicial, LocalDateTime fechaApertura, LocalDateTime fechaLimite, int idEstudiante, int idPeriodo) {
        this.idEntregaDocumentoInicial = idEntregaDocumentoInicial;
        this.fechaApertura = fechaApertura;
        this.fechaLimite = fechaLimite;
        this.idEstudiante = idEstudiante;
        this.idPeriodo = idPeriodo;
    }

    public int getIdEntregaDocumentoInicial() {
        return idEntregaDocumentoInicial;
    }

    public void setIdEntregaDocumentoInicial(int idEntregaDocumentoInicial) {
        this.idEntregaDocumentoInicial = idEntregaDocumentoInicial;
    }

    public LocalDateTime getFechaApertura() {
        return fechaApertura;
    }

    public void setFechaApertura(LocalDateTime fechaApertura) {
        this.fechaApertura = fechaApertura;
    }

    public LocalDateTime getFechaLimite() {
        return fechaLimite;
    }

    public void setFechaLimite(LocalDateTime fechaLimite) {
        this.fechaLimite = fechaLimite;
    }

    public int getIdEstudiante() {
        return idEstudiante;
    }

    public void setIdEstudiante(int idEstudiante) {
        this.idEstudiante = idEstudiante;
    }

    public int getIdPeriodo() {
        return idPeriodo;
    }

    public void setIdPeriodo(int idPeriodo) {
        this.idPeriodo = idPeriodo;
    }
}
