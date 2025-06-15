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

package sgpp.modelo.beans;

public class ResponsableTecnico {
    private int idResponsable;
    private String nombre;
    private String departamento;
    private String puesto;
    private String correo;
    private int idOrganizacionVinculada;

    public ResponsableTecnico() {
    }

    public ResponsableTecnico(int idResponsable, String nombre, String departamento, String puesto, String correo, int idOrganizacionVinculada) {
        this.idResponsable = idResponsable;
        this.nombre = nombre;
        this.departamento = departamento;
        this.puesto = puesto;
        this.correo = correo;
        this.idOrganizacionVinculada = idOrganizacionVinculada;
    }

    public int getIdResponsable() {
        return idResponsable;
    }

    public void setIdResponsable(int idResponsable) {
        this.idResponsable = idResponsable;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public int getIdOrganizacionVinculada() {
        return idOrganizacionVinculada;
    }

    public void setIdOrganizacionVinculada(int idOrganizacionVinculada) {
        this.idOrganizacionVinculada = idOrganizacionVinculada;
    }

    @Override
    public String toString() {
        return nombre;
    }
}
