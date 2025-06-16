/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 09-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 10-06-2025
 * Descripción: Clase DAO para manejar las operaciones de inicio de sesión del usuario en el sistema.
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.modelo.dao;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.TipoUsuario;
import sgpp.modelo.beans.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class InicioSesionDAO {
    public static Usuario verificarCredenciales(String username, String password) throws SQLException {
        Usuario sesionUsuario = null;
        Connection conexionBD = ConexionBD.abrirConexion();
        if(conexionBD != null) {
            String consulta = "CALL autenticar_usuario(?, ?)";
            try (PreparedStatement sentencia = conexionBD.prepareStatement(consulta)) {
                sentencia.setString(1, username);
                sentencia.setString(2, password);
                try (ResultSet resultado = sentencia.executeQuery()) {
                    if (resultado.next()) {
                        sesionUsuario = convertirRegistroUsuario(resultado);
                    }
                }
            }
            conexionBD.close();
        } else {
            throw new SQLException("Error: Se ha perdido la conexión con la base de datos");
        }
        return sesionUsuario;
    }

    private static Usuario convertirRegistroUsuario(ResultSet resultado) throws SQLException {
        Usuario usuario = new Usuario();
        usuario.setIdUsuario(resultado.getInt("ID_Usuario"));
        usuario.setUsername(resultado.getString("username"));

        String tipoUsuarioStr = resultado.getString("tipo_usuario");
        try {
            TipoUsuario tipoUsuario = TipoUsuario.valueOf(tipoUsuarioStr.toUpperCase());
            usuario.setTipoUsuario(tipoUsuario);
        } catch (IllegalArgumentException e) {
            // Mejorar el logging
            System.err.println("Error con el tipo de usuario");
        }
        return usuario;
    }
}
