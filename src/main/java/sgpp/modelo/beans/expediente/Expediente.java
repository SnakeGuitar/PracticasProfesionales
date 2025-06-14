package sgpp.modelo.beans.expediente;

public class Expediente {
    private int idEstudiante;
    private int idPeriodo;
    private EstadoExpediente estado;
    private int horasAcumuladas;

    public Expediente() {
    }

    public Expediente(int idEstudiante, int idPeriodo, EstadoExpediente estado, int horasAcumuladas) {
        this.idEstudiante = idEstudiante;
        this.idPeriodo = idPeriodo;
        this.estado = estado;
        this.horasAcumuladas = horasAcumuladas;
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

    public EstadoExpediente getEstado() {
        return estado;
    }

    public void setEstado(EstadoExpediente estado) {
        this.estado = estado;
    }

    public int getHorasAcumuladas() {
        return horasAcumuladas;
    }

    public void setHorasAcumuladas(int horasAcumuladas) {
        this.horasAcumuladas = horasAcumuladas;
    }
}
