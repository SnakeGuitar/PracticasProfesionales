package sgpp.dominio;

public class ResultadoValidacion {
    private boolean valido;
    private String mensaje;

    public ResultadoValidacion() {

    }

    public boolean isValido() {
        return valido;
    }

    public void setValido(boolean valido) {
        this.valido = valido;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
}
