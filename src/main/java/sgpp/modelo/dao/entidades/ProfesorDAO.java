package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Profesor;
import sgpp.utilidad.Utilidad;

import java.sql.*;
import java.util.ArrayList;

public class ProfesorDAO {

    public static boolean insertar(Profesor profesor) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        String consulta = "INSERT INTO profesor (nombre, num_personal, ID_Usuario) VALUES (?, ?, ?)";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            sentencia.setString(1, profesor.getNombre());
            sentencia.setInt(2, profesor.getNumeroPersonal());
            sentencia.setInt(3, profesor.getIdUsuario());

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Registro exitoso", "Profesor registrado exitosamente.");
                exitoso = true;
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }

        return exitoso;
    }

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

    public static int obtenerIdProfesorPorIdUsuario(int idUsuario) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        int idProfesor = 0;
        String consulta = "SELECT ID_Profesor FROM profesor WHERE ID_Usuario = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            sentencia.setInt(1, idUsuario);
            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                idProfesor = resultado.getInt("ID_Profesor");
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return idProfesor;
    }


    public static ArrayList<Profesor> obtenerTodos() throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        ArrayList<Profesor> profesores = new ArrayList<>();
        String consulta = "SELECT * FROM profesor";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            resultado = sentencia.executeQuery();

            while (resultado.next()) {
                profesores.add(convertirResultSetProfesor(resultado));
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return profesores;
    }

    public static boolean actualizar(Profesor profesor) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;
        String consulta = "UPDATE profesor SET nombre = ?, num_personal = ?, ID_Usuario = ? WHERE ID_Profesor = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            sentencia.setString(1, profesor.getNombre());
            sentencia.setInt(2, profesor.getNumeroPersonal());
            sentencia.setInt(3, profesor.getIdUsuario());
            sentencia.setInt(4, profesor.getIdProfesor());

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Modificación exitosa", "Profesor modificado exitosamente.");
                exitoso = true;
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }

        return exitoso;
    }

    public static boolean eliminar(int id) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;
        String consulta = "DELETE FROM profesor WHERE ID_Profesor = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            sentencia.setInt(1, id);

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Eliminación exitosa", "Profesor eliminado exitosamente.");
                exitoso = true;
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }

        return exitoso;
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
