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

public class Estudiante {
    private int idEstudiante;
    private String matricula;
    private String nombre;
    private String genero;
    private String correo;
    private String telefono;
    private String semestre;
    private float promedio;
    private boolean hablaIdiomaIndigena;
    private int idProyecto;
    private int idUsuario;

    public Estudiante() {
    }

    public Estudiante(int idEstudiante, String matricula, String nombre, String genero, String correo, String telefono, String semestre, float promedio, boolean hablaIdiomaIndigena, int idProyecto, int idusuario) {
        this.idEstudiante = idEstudiante;
        this.matricula = matricula;
        this.nombre = nombre;
        this.genero = genero;
        this.correo = correo;
        this.telefono = telefono;
        this.semestre = semestre;
        this.promedio = promedio;
        this.hablaIdiomaIndigena = hablaIdiomaIndigena;
        this.idProyecto = idProyecto;
        this.idUsuario = idusuario;
    }

    public int getIdEstudiante() {
        return idEstudiante;
    }

    public void setIdEstudiante(int idEstudiante) {
        this.idEstudiante = idEstudiante;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getSemestre() {
        return semestre;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }

    public float getPromedio() {
        return promedio;
    }

    public void setPromedio(float promedio) {
        this.promedio = promedio;
    }

    public boolean isHablaIdiomaIndigena() {
        return hablaIdiomaIndigena;
    }

    public void setHablaIdiomaIndigena(boolean hablaIdiomaIndigena) {
        this.hablaIdiomaIndigena = hablaIdiomaIndigena;
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
}
