package sgpp.modelo.beans.expediente.presentacion;

public class Evaluador {
    private int idEvaluador;
    private String nombre;
    private int numeroPersonal;

    public Evaluador() {
    }

    public Evaluador(int idEvaluador, String nombre, int numeroPersonal) {
        this.idEvaluador = idEvaluador;
        this.nombre = nombre;
        this.numeroPersonal = numeroPersonal;
    }

    public int getIdEvaluador() {
        return idEvaluador;
    }

    public void setIdEvaluador(int idEvaluador) {
        this.idEvaluador = idEvaluador;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getNumeroPersonal() {
        return numeroPersonal;
    }

    public void setNumeroPersonal(int numeroPersonal) {
        this.numeroPersonal = numeroPersonal;
    }
}
