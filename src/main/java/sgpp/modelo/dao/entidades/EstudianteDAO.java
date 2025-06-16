package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Estudiante;
import sgpp.utilidad.Utilidad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EstudianteDAO {

    public static boolean insertar(Estudiante estudiante) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "INSERT INTO estudiante (matricula, nombre, genero, correo, telefono, semestre, promedio, habla_idioma_indigena, ID_Proyecto, ID_Usuario) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setString(1, estudiante.getMatricula());
            sentencia.setString(2, estudiante.getNombre());
            sentencia.setString(3, estudiante.getGenero());
            sentencia.setString(4, estudiante.getCorreo());
            sentencia.setString(5, estudiante.getTelefono());
            sentencia.setInt(6, Integer.parseInt(estudiante.getSemestre()));
            sentencia.setFloat(7, estudiante.getPromedio());
            sentencia.setBoolean(8, estudiante.isHablaIdiomaIndigena());
            sentencia.setInt(9, estudiante.getIdProyecto());
            sentencia.setInt(10, estudiante.getIdUsuario());

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Registro exitoso",
                        "Estudiante registrado exitosamente.");
                return true;
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

    public static Estudiante obtenerPorId(int id) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        Estudiante estudiante = null;
        String consulta = "SELECT * FROM estudiante WHERE ID_Estudiante = ?";

        try  {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, id);

            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                estudiante = convertirResultSetEstudiante(resultado);
            } else {
                throw new SQLException();
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return estudiante;
    }

    public static boolean actualizar(Estudiante estudiante) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "UPDATE estudiante SET nombre = ?, correo = ?, telefono = ?, semestre = ?, promedio = ?, habla_idioma_indigena = ? " +
                "WHERE ID_Responsable = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setString(1, estudiante.getNombre());
            sentencia.setString(2, estudiante.getCorreo());
            sentencia.setString(3, estudiante.getTelefono());
            sentencia.setInt(4, Integer.parseInt(estudiante.getSemestre()));
            sentencia.setFloat(5, estudiante.getPromedio());
            sentencia.setBoolean(6, estudiante.isHablaIdiomaIndigena());
            sentencia.setInt(7, estudiante.getIdEstudiante());

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Modificación exitosa",
                        "Estudiante modificado exitosamente.");
                return true;
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

        String consulta = "DELETE FROM estudiante WHERE ID_Estudiante = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, id);

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Eliminación exitosa",
                        "Estudiante eliminado exitosamente.");
                return true;
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

    public static ArrayList<Estudiante> obtenerEstudiantes() throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        ArrayList<Estudiante> estudiantes = new ArrayList<>();
        String consulta = "SELECT * FROM estudiante";

        try {

            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            resultado = sentencia.executeQuery();

            while (resultado.next()) {
                estudiantes.add(convertirResultSetEstudiante(resultado));
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return estudiantes;
    }

    public static Estudiante convertirResultSetEstudiante(ResultSet resultado) throws SQLException {
        Estudiante estudiante = new Estudiante();

        estudiante.setIdEstudiante(resultado.getInt("ID_Estudiante"));
        estudiante.setMatricula(resultado.getString("matricula"));
        estudiante.setNombre(resultado.getString("nombre"));
        estudiante.setGenero(resultado.getString("genero"));
        estudiante.setCorreo(resultado.getString("correo"));
        estudiante.setTelefono(resultado.getString("telefono"));
        estudiante.setSemestre(String.valueOf(resultado.getInt("semestre")));
        estudiante.setPromedio(resultado.getFloat("promedio"));
        estudiante.setHablaIdiomaIndigena(resultado.getBoolean("habla_idioma_indigena"));
        estudiante.setIdProyecto(resultado.getInt("ID_Proyecto"));
        estudiante.setIdUsuario(resultado.getInt("ID_Usuario"));

        return estudiante;
    }

}
