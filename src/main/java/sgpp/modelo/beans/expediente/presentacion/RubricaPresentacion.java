package sgpp.modelo.beans.expediente.presentacion;

import java.util.Date;

public class RubricaPresentacion {
    private int idPresentacion;
    private Date fechaHora;
    private float calificacion;
    private String observaciones;
    private int idEstudiante;
    private int idPeriodo;
    private int idProfesor;
    private Evaluador evaluador;

    public RubricaPresentacion() {
    }

    public RubricaPresentacion(int idPresentacion, Date fechaHora, float calificacion, String observaciones,
                               int idEstudiante, int idPeriodo, int idProfesor, Evaluador evaluador) {
        this.idPresentacion = idPresentacion;
        this.fechaHora = fechaHora;
        this.calificacion = calificacion;
        this.observaciones = observaciones;
        this.idEstudiante = idEstudiante;
        this.idPeriodo = idPeriodo;
        this.idProfesor = idProfesor;
        this.evaluador = evaluador;
    }

    public int getIdPresentacion() {
        return idPresentacion;
    }

    public void setIdPresentacion(int idPresentacion) {
        this.idPresentacion = idPresentacion;
    }

    public Date getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(Date fechaHora) {
        this.fechaHora = fechaHora;
    }

    public float getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(float calificacion) {
        this.calificacion = calificacion;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
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

    public int getIdProfesor() {
        return idProfesor;
    }

    public void setIdProfesor(int idProfesor) {
        this.idProfesor = idProfesor;
    }

    public Evaluador getEvaluador() {
        return evaluador;
    }

    public void setEvaluador(Evaluador evaluador) {
        this.evaluador = evaluador;
    }
}
