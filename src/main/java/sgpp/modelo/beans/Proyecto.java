/*
 * Autor original: Luis Donaldo
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 13-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 14-06-2025 6:51
 * Descripción: Clase beans del modelo de dominio
 */

/*
 * Estado: En progreso
 * Modificaciones: Se cambiaron los tipos Date a String
 */

package sgpp.modelo.beans;

public class Proyecto {
    private int idProyecto;
    private String nombre;
    private String objetivoGeneral;
    private String metodologia;
    private int numeroMaximoParticipantes;
    private String fechaInicio;
    private String fechaFin;
    private int idOrganizacionVinculada;
    private int idResponsable;

    public Proyecto() {
    }

    public Proyecto(int idProyecto, String nombre, String objetivoGeneral, String metodologia, int numeroMaximoParticipantes, String fechaInicio, String fechaFin, int idOrganizacionVinculada, int idResponsable) {
        this.idProyecto = idProyecto;
        this.nombre = nombre;
        this.objetivoGeneral = objetivoGeneral;
        this.metodologia = metodologia;
        this.numeroMaximoParticipantes = numeroMaximoParticipantes;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.idOrganizacionVinculada = idOrganizacionVinculada;
        this.idResponsable = idResponsable;
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getObjetivoGeneral() {
        return objetivoGeneral;
    }

    public void setObjetivoGeneral(String objetivoGeneral) {
        this.objetivoGeneral = objetivoGeneral;
    }

    public String getMetodologia() {
        return metodologia;
    }

    public void setMetodologia(String metodologia) {
        this.metodologia = metodologia;
    }

    public int getNumeroMaximoParticipantes() {
        return numeroMaximoParticipantes;
    }

    public void setNumeroMaximoParticipantes(int numeroMaximoParticipantes) {
        this.numeroMaximoParticipantes = numeroMaximoParticipantes;
    }

    public String getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public String getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(String fechaFin) {
        this.fechaFin = fechaFin;
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
}
