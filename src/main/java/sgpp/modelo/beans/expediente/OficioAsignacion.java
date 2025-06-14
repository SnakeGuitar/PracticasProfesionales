package sgpp.modelo.beans.expediente;

import java.util.Date;

public class OficioAsignacion {
    private int numeroOficio;
    private String nombreResponsable;
    private String puestoResponsable;
    private String nombreOV;
    private String nombreEstudiante;
    private String matriculaEstudiante;
    private String nombreProyecto;
    private String nombreCoordinador;
    private String puestoCoordinador;
    private Date fechaInicioPracticas;
    private Date fechaImpresion;

    public OficioAsignacion() {
    }

    public OficioAsignacion(int numeroOficio, String nombreResponsable, String puestoResponsable,
                            String nombreOV, String nombreEstudiante, String matriculaEstudiante,
                            String nombreProyecto, String nombreCoordinador, String puestoCoordinador,
                            Date fechaInicioPracticas, Date fechaImpresion) {
        this.numeroOficio = numeroOficio;
        this.nombreResponsable = nombreResponsable;
        this.puestoResponsable = puestoResponsable;
        this.nombreOV = nombreOV;
        this.nombreEstudiante = nombreEstudiante;
        this.matriculaEstudiante = matriculaEstudiante;
        this.nombreProyecto = nombreProyecto;
        this.nombreCoordinador = nombreCoordinador;
        this.puestoCoordinador = puestoCoordinador;
        this.fechaInicioPracticas = fechaInicioPracticas;
        this.fechaImpresion = fechaImpresion;
    }

    public int getNumeroOficio() {
        return numeroOficio;
    }

    public void setNumeroOficio(int numeroOficio) {
        this.numeroOficio = numeroOficio;
    }

    public String getNombreResponsable() {
        return nombreResponsable;
    }

    public void setNombreResponsable(String nombreResponsable) {
        this.nombreResponsable = nombreResponsable;
    }

    public String getPuestoResponsable() {
        return puestoResponsable;
    }

    public void setPuestoResponsable(String puestoResponsable) {
        this.puestoResponsable = puestoResponsable;
    }

    public String getNombreOV() {
        return nombreOV;
    }

    public void setNombreOV(String nombreOV) {
        this.nombreOV = nombreOV;
    }

    public String getNombreEstudiante() {
        return nombreEstudiante;
    }

    public void setNombreEstudiante(String nombreEstudiante) {
        this.nombreEstudiante = nombreEstudiante;
    }

    public String getMatriculaEstudiante() {
        return matriculaEstudiante;
    }

    public void setMatriculaEstudiante(String matriculaEstudiante) {
        this.matriculaEstudiante = matriculaEstudiante;
    }

    public String getNombreProyecto() {
        return nombreProyecto;
    }

    public void setNombreProyecto(String nombreProyecto) {
        this.nombreProyecto = nombreProyecto;
    }

    public String getNombreCoordinador() {
        return nombreCoordinador;
    }

    public void setNombreCoordinador(String nombreCoordinador) {
        this.nombreCoordinador = nombreCoordinador;
    }

    public String getPuestoCoordinador() {
        return puestoCoordinador;
    }

    public void setPuestoCoordinador(String puestoCoordinador) {
        this.puestoCoordinador = puestoCoordinador;
    }

    public Date getFechaInicioPracticas() {
        return fechaInicioPracticas;
    }

    public void setFechaInicioPracticas(Date fechaInicioPracticas) {
        this.fechaInicioPracticas = fechaInicioPracticas;
    }

    public Date getFechaImpresion() {
        return fechaImpresion;
    }

    public void setFechaImpresion(Date fechaImpresion) {
        this.fechaImpresion = fechaImpresion;
    }
}
