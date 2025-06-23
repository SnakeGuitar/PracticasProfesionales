package sgpp.modelo.dao.expediente.documentofinal;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.documentofinal.AutoEvaluacion;
import sgpp.utilidad.Utilidad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class AutoEvaluacionDAO {

    public static boolean insertar(AutoEvaluacion autoEvaluacion) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "INSERT INTO autoevaluacion (fecha_hora, criterio1, criterio2, criterio3, criterio4, criterio5, " +
                "criterio6, criterio7, criterio8, criterio9, criterio10, puntuacion_final, ID_Estudiante, " +
                "ID_Org_Vinculada, ID_Responsable, ID_Proyecto, ID_Periodo) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            pasarDatosASentencia(sentencia, autoEvaluacion);

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

    public static AutoEvaluacion obtenerPorId(int id) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        AutoEvaluacion autoEvaluacion = null;

        String consulta = "SELECT * FROM autoevaluacion WHERE ID_Autoevaluacion = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, id);

            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                autoEvaluacion = convertirResultSetAutoEvaluacion(resultado);
            } else {
                throw new SQLException();
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return autoEvaluacion;
    }

    public static AutoEvaluacion obtenerPorIdEstudiante(int id) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        AutoEvaluacion autoEvaluacion = null;

        String consulta = "SELECT * FROM autoevaluacion WHERE ID_Estudiante = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, id);

            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                autoEvaluacion = convertirResultSetAutoEvaluacion(resultado);
            } else {
                throw new SQLException();
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return autoEvaluacion;
    }

    public static boolean actualizar(AutoEvaluacion autoEvaluacion) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "UPDATE autoevaluacion SET fecha_hora = ?, " +
                "criterio1 = ?, criterio2 = ?, criterio3 = ?, criterio4 = ?, criterio5 = ?, " +
                "criterio6 = ?, criterio7 = ?, criterio8 = ?, criterio9 = ?, criterio10 = ?, " +
                "puntuacion_final = ? " +
                "WHERE ID_Autoevaluacion = ? AND ID_Estudiante = ? AND ID_Org_Vinculada = ? " +
                "AND ID_Responsable = ? AND ID_Proyecto = ? AND ID_Periodo = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            pasarDatosActualizacion(sentencia, autoEvaluacion);

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

    public static boolean eliminar(int id) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "DELETE FROM autoevaluacion WHERE ID_Autoevaluacion = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, id);

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Eliminación exitosa", "AutoEvaluacion eliminada exitosamente.");
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

    private static void pasarCriterios(PreparedStatement sentencia, AutoEvaluacion autoEvaluacion) throws SQLException {
        int[] criterios = autoEvaluacion.getCriterios();

        for (int i = 0; i < criterios.length; i++) {
            sentencia.setInt(i + 2, criterios[i]);
        }
    }

    private static void pasarDatosASentencia(PreparedStatement sentencia, AutoEvaluacion autoEvaluacion) throws SQLException {
        sentencia.setTimestamp(1, Timestamp.valueOf(autoEvaluacion.getFechaHora()));

        pasarCriterios(sentencia, autoEvaluacion); // Abarca índices 2 al 11

        sentencia.setInt(12, autoEvaluacion.getPuntuacionFinal());
        sentencia.setInt(13, autoEvaluacion.getIdEstudiante());
        sentencia.setInt(14, autoEvaluacion.getIdOrganizacionVinculada());
        sentencia.setInt(15, autoEvaluacion.getIdResponsable());
        sentencia.setInt(16, autoEvaluacion.getIdProyecto());
        sentencia.setInt(17, autoEvaluacion.getIdPeriodo());
    }

    private static void pasarDatosActualizacion(PreparedStatement sentencia, AutoEvaluacion autoEvaluacion) throws SQLException {
        sentencia.setTimestamp(1, Timestamp.valueOf(autoEvaluacion.getFechaHora()));

        pasarCriterios(sentencia, autoEvaluacion); // Abarca índices 2 al 11

        sentencia.setInt(12, autoEvaluacion.getPuntuacionFinal());
        // Parámetros para la cláusula WHERE
        sentencia.setInt(13, autoEvaluacion.getIdAutoEvaluacion());
        sentencia.setInt(14, autoEvaluacion.getIdEstudiante());
        sentencia.setInt(15, autoEvaluacion.getIdOrganizacionVinculada());
        sentencia.setInt(16, autoEvaluacion.getIdResponsable());
        sentencia.setInt(17, autoEvaluacion.getIdProyecto());
        sentencia.setInt(18, autoEvaluacion.getIdPeriodo());
    }

    private static AutoEvaluacion convertirResultSetAutoEvaluacion(ResultSet rs) throws SQLException {
        AutoEvaluacion autoEvaluacion = new AutoEvaluacion();

        autoEvaluacion.setIdAutoEvaluacion(rs.getInt("ID_Autoevaluacion"));
        autoEvaluacion.setFechaHora(rs.getTimestamp("fecha_hora").toLocalDateTime());
        autoEvaluacion.setPuntuacionFinal(rs.getInt("puntuacion_final"));
        autoEvaluacion.setIdEstudiante(rs.getInt("ID_Estudiante"));
        autoEvaluacion.setIdOrganizacionVinculada(rs.getInt("ID_Org_Vinculada"));
        autoEvaluacion.setIdResponsable(rs.getInt("ID_Responsable"));
        autoEvaluacion.setIdProyecto(rs.getInt("ID_Proyecto"));
        autoEvaluacion.setIdPeriodo(rs.getInt("ID_Periodo"));

        int[] criterios = {
                rs.getInt("criterio1"),
                rs.getInt("criterio2"),
                rs.getInt("criterio3"),
                rs.getInt("criterio4"),
                rs.getInt("criterio5"),
                rs.getInt("criterio6"),
                rs.getInt("criterio7"),
                rs.getInt("criterio8"),
                rs.getInt("criterio9"),
                rs.getInt("criterio10")
        };

        autoEvaluacion.setCriterios(criterios);

        return autoEvaluacion;
    }
}
