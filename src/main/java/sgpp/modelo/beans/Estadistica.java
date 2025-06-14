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

public class Estadistica {
    int idPeriodo;
    int hombresSectorPrivado;
    int mujeresSectorPrivado;
    int hombresSectorPublico;
    int mujeresSectorPublico;
    int hombresSectorSocial;
    int mujeresSectorSocial;
    int numeroHablantesIdiomaIndigena;

    public Estadistica() {
    }

    public Estadistica(int idPeriodo, int hombresSectorPrivado, int mujeresSectorPrivado, int hombresSectorPublico, int mujeresSectorPublico, int hombresSectorSocial, int mujeresSectorSocial, int numeroHablantesIdiomaIndigena) {
        this.idPeriodo = idPeriodo;
        this.hombresSectorPrivado = hombresSectorPrivado;
        this.mujeresSectorPrivado = mujeresSectorPrivado;
        this.hombresSectorPublico = hombresSectorPublico;
        this.mujeresSectorPublico = mujeresSectorPublico;
        this.hombresSectorSocial = hombresSectorSocial;
        this.mujeresSectorSocial = mujeresSectorSocial;
        this.numeroHablantesIdiomaIndigena = numeroHablantesIdiomaIndigena;
    }

    public int getIdPeriodo() {
        return idPeriodo;
    }

    public void setIdPeriodo(int idPeriodo) {
        this.idPeriodo = idPeriodo;
    }

    public int getHombresSectorPrivado() {
        return hombresSectorPrivado;
    }

    public void setHombresSectorPrivado(int hombresSectorPrivado) {
        this.hombresSectorPrivado = hombresSectorPrivado;
    }

    public int getMujeresSectorPrivado() {
        return mujeresSectorPrivado;
    }

    public void setMujeresSectorPrivado(int mujeresSectorPrivado) {
        this.mujeresSectorPrivado = mujeresSectorPrivado;
    }

    public int getHombresSectorPublico() {
        return hombresSectorPublico;
    }

    public void setHombresSectorPublico(int hombresSectorPublico) {
        this.hombresSectorPublico = hombresSectorPublico;
    }

    public int getMujeresSectorPublico() {
        return mujeresSectorPublico;
    }

    public void setMujeresSectorPublico(int mujeresSectorPublico) {
        this.mujeresSectorPublico = mujeresSectorPublico;
    }

    public int getHombresSectorSocial() {
        return hombresSectorSocial;
    }

    public void setHombresSectorSocial(int hombresSectorSocial) {
        this.hombresSectorSocial = hombresSectorSocial;
    }

    public int getMujeresSectorSocial() {
        return mujeresSectorSocial;
    }

    public void setMujeresSectorSocial(int mujeresSectorSocial) {
        this.mujeresSectorSocial = mujeresSectorSocial;
    }

    public int getNumeroHablantesIdiomaIndigena() {
        return numeroHablantesIdiomaIndigena;
    }

    public void setNumeroHablantesIdiomaIndigena(int numeroHablantesIdiomaIndigena) {
        this.numeroHablantesIdiomaIndigena = numeroHablantesIdiomaIndigena;
    }
}
