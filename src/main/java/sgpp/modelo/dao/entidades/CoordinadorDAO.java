package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Coordinador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CoordinadorDAO {
    public static Coordinador obtenerPorIdUsuario(int idUsuario) throws SQLException {
        Coordinador coordinador = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT ID_Coordinador, nombre, ID_Usuario FROM Coordinador WHERE ID_Usuario = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idUsuario);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    coordinador = new Coordinador();
                    coordinador.setIdCoordinador(resultado.getInt("ID_Coordinador"));
                    coordinador.setNombre(resultado.getString("nombre"));
                    coordinador.setIdUsuario(resultado.getInt("ID_Usuario"));
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al recuperar el coordinador: " + sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion con la base de datos");
        }
        return coordinador;
    }
}
