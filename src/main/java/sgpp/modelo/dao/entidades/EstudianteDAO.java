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
            sentencia.setInt(6, estudiante.getSemestre());
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

    public static Estudiante obtenerPorId(int idEstudiante) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        Estudiante estudiante = null;

        String consulta = "SELECT * FROM estudiante WHERE ID_Estudiante = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, idEstudiante);

            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                estudiante = convertirResultSetEstudiante(resultado);
            } else {
                throw new SQLException("No se encontró el estudiante con ID: " + idEstudiante);
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return estudiante;
    }

    public static Estudiante obtenerPorIdUsuario(int idUsuario) throws SQLException {
        Estudiante estudiante = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM Estudiante WHERE ID_Usuario = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idUsuario);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    estudiante = convertirResultSetEstudiante(resultado);
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al obtener al estudiante: "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se perdio la conexion con la Base de Datos");
        }
        return estudiante;
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

    public static ArrayList<Estudiante> obtenerEstudiantesPendientesDeAsignacion() throws SQLException {
        ArrayList<Estudiante> estudiantes = new ArrayList<Estudiante>();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT ID_Estudiante, nombre, semestre, promedio FROM Estudiante WHERE ID_Proyecto is NULL";
            PreparedStatement sentencia = conexion.prepareStatement(consulta);
            ResultSet resultado = sentencia.executeQuery();
            while (resultado.next()) {
                Estudiante estudiante = new Estudiante();
                estudiante.setIdEstudiante(resultado.getInt("ID_Estudiante"));
                estudiante.setNombre(resultado.getString("nombre"));
                estudiante.setSemestre(resultado.getInt("semestre"));
                estudiante.setPromedio(resultado.getFloat("promedio"));
                estudiantes.add(estudiante);
            }
        } else {
            throw new SQLException();
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
        estudiante.setSemestre(resultado.getInt("semestre"));
        estudiante.setPromedio(resultado.getFloat("promedio"));
        estudiante.setHablaIdiomaIndigena(resultado.getBoolean("habla_idioma_indigena"));
        estudiante.setIdProyecto(resultado.getInt("ID_Proyecto"));
        estudiante.setIdUsuario(resultado.getInt("ID_Usuario"));

        return estudiante;
    }
}
