package sgpp.modelo.beans;

public class PreferenciaProyecto {
    private int idProyecto;
    private int idEstudiante;
    private int numPreferencia;

    public PreferenciaProyecto() {
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }

    public int getIdEstudiante() {
        return idEstudiante;
    }

    public void setIdEstudiante(int idEstudiante) {
        this.idEstudiante = idEstudiante;
    }

    public int getNumPreferencia() {
        return numPreferencia;
    }

    public void setNumPreferencia(int numPreferencia) {
        this.numPreferencia = numPreferencia;
    }
}
