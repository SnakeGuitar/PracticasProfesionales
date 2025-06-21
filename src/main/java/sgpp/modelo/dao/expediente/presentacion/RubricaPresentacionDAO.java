package sgpp.modelo.dao.expediente.presentacion;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;
import sgpp.utilidad.Utilidad;

import java.sql.*;

public class RubricaPresentacionDAO {

    public static boolean insertar(RubricaPresentacion rubrica) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "INSERT INTO rubrica_presentacion (fecha_hora, calificacion, observaciones, ID_Estudiante, ID_Periodo, ID_Profesor) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setTimestamp(1, Timestamp.valueOf(rubrica.getFechaHora()));
            sentencia.setFloat(2, rubrica.getCalificacion());
            sentencia.setString(3, rubrica.getObservaciones());
            sentencia.setInt(4, rubrica.getIdEstudiante());
            sentencia.setInt(5, rubrica.getIdPeriodo());
            sentencia.setInt(6, rubrica.getIdProfesor());

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
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

    public static RubricaPresentacion obtenerPorId(int id) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        RubricaPresentacion rubrica = null;

        String consulta = "SELECT * FROM rubrica_presentacion WHERE ID_Presentacion = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, id);

            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                rubrica = convertirResultSetRubrica(resultado);
            } else {
                throw new SQLException();
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return rubrica;
    }

    public static boolean actualizar(RubricaPresentacion rubrica) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "UPDATE rubrica_presentacion SET fecha_hora = ?, calificacion = ?, observaciones = ? " +
                "WHERE ID_Presentacion = ? AND ID_Estudiante = ? AND ID_Periodo = ? AND ID_Profesor = ?";
        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setTimestamp(1, Timestamp.valueOf(rubrica.getFechaHora()));
            sentencia.setFloat(2, rubrica.getCalificacion());
            sentencia.setString(3, rubrica.getObservaciones());
            sentencia.setInt(4, rubrica.getIdPresentacion());
            sentencia.setInt(5, rubrica.getIdEstudiante());
            sentencia.setInt(6, rubrica.getIdPeriodo());
            sentencia.setInt(7, rubrica.getIdProfesor());

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Modificación exitosa", "Rubrica modificada exitosamente.");
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

        String consulta = "DELETE FROM rubrica_presentacion WHERE ID_Presentacion = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, id);

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Eliminación exitosa", "Rubrica eliminada exitosamente.");
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

    private static RubricaPresentacion convertirResultSetRubrica(ResultSet rs) throws SQLException {
        RubricaPresentacion rubrica = new RubricaPresentacion();

        rubrica.setIdPresentacion(rs.getInt("ID_Presentacion"));
        rubrica.setFechaHora(rs.getTimestamp("fecha_hora").toLocalDateTime());
        rubrica.setCalificacion(rs.getFloat("calificacion"));
        rubrica.setObservaciones(rs.getString("observaciones"));
        rubrica.setIdEstudiante(rs.getInt("ID_Estudiante"));
        rubrica.setIdPeriodo(rs.getInt("ID_Periodo"));
        rubrica.setIdProfesor(rs.getInt("ID_Profesor"));

        return rubrica;
    }
}

