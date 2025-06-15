package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Estudiante;
import sgpp.utilidad.Utilidad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EstudianteDAO {

    public static boolean insertar(Estudiante estudiante) throws SQLException {
        String consulta = "INSERT INTO estudiante (matricula, nombre, genero, correo, telefono, semestre, promedio, habla_idioma_indigena, ID_Proyecto, ID_Usuario) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement statement = conexion.prepareStatement(consulta)) {

            statement.setString(1, estudiante.getMatricula());
            statement.setString(2, estudiante.getNombre());
            statement.setString(3, estudiante.getGenero());
            statement.setString(4, estudiante.getCorreo());
            statement.setString(5, estudiante.getTelefono());
            statement.setInt(6, Integer.parseInt(estudiante.getSemestre()));
            statement.setFloat(7, estudiante.getPromedio());
            statement.setBoolean(8, estudiante.isHablaIdiomaIndigena());
            statement.setInt(9, estudiante.getIdProyecto());
            statement.setInt(10, estudiante.getIdUsuario());

            int filas = statement.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Registro exitoso",
                        "Estudiante registrado exitosamente.");
                return true;
            } else {
                Utilidad.crearAlertaError("Registro fallido",
                        "No se pudo registrar al estudiante.");
                return false;
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
            throw e;
        }
    }

    public static Estudiante obtenerPorId(int id) throws SQLException {
        Estudiante estudiante = null;
        String consulta = "SELECT * FROM estudiante WHERE ID_Estudiante = ?";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement statement = conexion.prepareStatement(consulta)) {

            statement.setInt(1, id);

            try (ResultSet resultado = statement.executeQuery()) {
                if (resultado.next()) {
                    estudiante = convertirResultSetEstudiante(resultado);
                }
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
            throw e;
        }

        return estudiante;
    }

    public static boolean actualizar(Estudiante estudiante) throws SQLException {
        String consulta = "UPDATE estudiante SET nombre = ?, correo = ?, telefono = ?, semestre = ?, promedio = ?, habla_idioma_indigena = ? " +
                "WHERE ID_Responsable = ?";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement statement = conexion.prepareStatement(consulta)) {

            statement.setString(1, estudiante.getNombre());
            statement.setString(2, estudiante.getCorreo());
            statement.setString(3, estudiante.getTelefono());
            statement.setInt(4, Integer.parseInt(estudiante.getSemestre()));
            statement.setFloat(5, estudiante.getPromedio());
            statement.setBoolean(6, estudiante.isHablaIdiomaIndigena());
            statement.setInt(7, estudiante.getIdEstudiante());

            int filas = statement.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Modificación exitosa",
                        "Estudiante modificado exitosamente.");
                return true;
            } else {
                Utilidad.crearAlertaError("Modificación fallida",
                        "No se pudo modificar al estudiante.");
                return false;
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
            throw e;
        }
    }

    public static boolean eliminar(int id) throws SQLException {
        String consulta = "DELETE FROM estudiante WHERE ID_Estudiante = ?";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement statement = conexion.prepareStatement(consulta)) {

            statement.setInt(1, id);

            int filas = statement.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Eliminación exitosa",
                        "Estudiante eliminado exitosamente.");
                return true;
            } else {
                Utilidad.crearAlertaError("Eliminación fallida",
                        "No se pudo eliminar al estudiante.");
                return false;
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
            throw e;
        }
    }

    public static ArrayList<Estudiante> obtenerEstudiantes() throws SQLException {
        ArrayList<Estudiante> estudiantes = new ArrayList<>();
        String consulta = "SELECT * FROM estudiante";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement statement = conexion.prepareStatement(consulta);
             ResultSet resultado = statement.executeQuery()) {

            while (resultado.next()) {
                estudiantes.add(convertirResultSetEstudiante(resultado));
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
            throw e;
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
