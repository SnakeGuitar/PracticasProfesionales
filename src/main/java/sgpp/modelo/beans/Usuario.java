package sgpp.modelo.beans;

import sgpp.modelo.TipoUsuario;

public class Usuario {
    private int idUsuario;
    private String username;
    private TipoUsuario tipoUsuario;
    private boolean activo;

    public Usuario() {

    }

    public Usuario(int idUsuario, String username, TipoUsuario tipoUsuario, boolean activo) {
        this.idUsuario = idUsuario;
        this.username = username;
        this.tipoUsuario = tipoUsuario;
        this.activo = activo;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public TipoUsuario getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(TipoUsuario tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
