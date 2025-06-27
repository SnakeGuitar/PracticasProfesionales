/*
 * Autor original: Diego Ivan
 * Último autor: Abel Yong
 * Fecha de creación: 16-06-2025
 * Fecha de la última versión aprobada: 26-06-2025
 * Fecha de la última modificación: 26-06-2025
 * Descripción: Clase para obtener un profesor
 */

/*
 * Estado: Terminado
 * Modificaciones: eliminado metodo sin utilizar obtenerTodos()
 */

package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Profesor;
import sgpp.utilidad.Utilidad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProfesorDAO {

    public static Profesor obtenerPorId(int id) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        Profesor profesor = null;
        String consulta = "SELECT * FROM profesor WHERE ID_Profesor = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            sentencia.setInt(1, id);
            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                profesor = convertirResultSetProfesor(resultado);
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return profesor;
    }

    public static Profesor obtenerPorIdUsuario(int idUsuario) throws SQLException {
        Profesor profesor = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM profesor WHERE ID_Usuario = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idUsuario);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    profesor = convertirResultSetProfesor(resultado);
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al obtener el profesor: "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion con la Base de Datos");
        }
        return profesor;
    }

    public static Profesor convertirResultSetProfesor(ResultSet resultado) throws SQLException {
        Profesor profesor = new Profesor();

        profesor.setIdProfesor(resultado.getInt("ID_Profesor"));
        profesor.setNombre(resultado.getString("nombre"));
        profesor.setNumeroPersonal(resultado.getInt("num_personal"));
        profesor.setIdUsuario(resultado.getInt("ID_Usuario"));

        return profesor;
    }
}
