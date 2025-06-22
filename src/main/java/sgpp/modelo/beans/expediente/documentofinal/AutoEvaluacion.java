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

import sgpp.modelo.beans.expediente.presentacion.Evaluador;

import java.time.LocalDateTime;

public class AutoEvaluacion {
    private int idAutoEvaluacion;
    private LocalDateTime fechaHora;
    private int[] criterios;
    private int puntuacionFinal;
    private int idEstudiante;
    private int idOrganizacionVinculada;
    private int idResponsable;
    private int idProyecto;
    private int idPeriodo;

    public AutoEvaluacion() {}

    public AutoEvaluacion(int idAutoEvaluacion, LocalDateTime fechaHora, int puntuacionFinal, int idEstudiante, int idOrganizacionVinculada, int idResponsable, int idProyecto, int idPeriodo, int[] criterios) {
        this.idAutoEvaluacion = idAutoEvaluacion;
        this.fechaHora = fechaHora;
        this.puntuacionFinal = puntuacionFinal;
        this.idEstudiante = idEstudiante;
        this.idOrganizacionVinculada = idOrganizacionVinculada;
        this.idResponsable = idResponsable;
        this.idProyecto = idProyecto;
        this.idPeriodo = idPeriodo;
        this.criterios = criterios;
    }

    public int getIdAutoEvaluacion() {
        return idAutoEvaluacion;
    }

    public void setIdAutoEvaluacion(int idAutoEvaluacion) {
        this.idAutoEvaluacion = idAutoEvaluacion;
    }

    public LocalDateTime getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(LocalDateTime fechaHora) {
        this.fechaHora = fechaHora;
    }

    public int getPuntuacionFinal() {
        return puntuacionFinal;
    }

    public void setPuntuacionFinal(int puntuacionFinal) {
        this.puntuacionFinal = puntuacionFinal;
    }

    public int getIdEstudiante() {
        return idEstudiante;
    }

    public void setIdEstudiante(int idEstudiante) {
        this.idEstudiante = idEstudiante;
    }

    public int getIdOrganizacionVinculada() {
        return idOrganizacionVinculada;
    }

    public void setIdOrganizacionVinculada(int idOrganizacionVinculada) {
        this.idOrganizacionVinculada = idOrganizacionVinculada;
    }

    public int getIdResponsable() {
        return idResponsable;
    }

    public void setIdResponsable(int idResponsable) {
        this.idResponsable = idResponsable;
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }

    public int getIdPeriodo() {
        return idPeriodo;
    }

    public void setIdPeriodo(int idPeriodo) {
        this.idPeriodo = idPeriodo;
    }

    public int[] getCriterios() {
        return criterios;
    }

    public void setCriterios(int[] criterios) {
        this.criterios = criterios;
    }
}
