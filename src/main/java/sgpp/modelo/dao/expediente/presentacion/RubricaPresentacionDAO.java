package sgpp.modelo.dao.expediente.presentacion;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;
import sgpp.modelo.dao.entidades.ProfesorDAO;
import sgpp.utilidad.Utilidad;

import java.sql.*;

public class RubricaPresentacionDAO {

    public static boolean insertar(RubricaPresentacion rubrica) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "INSERT INTO rubrica_presentacion (fecha_hora, criterio1, criterio2, criterio3, criterio4, criterio5, " +
                "calificacion, observaciones, ID_Estudiante, ID_Periodo, ID_Profesor) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            pasarDatosASentencia(sentencia, rubrica);

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

    public static RubricaPresentacion obtenerPorEstudiante(int idEstudiante) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        RubricaPresentacion rubrica = null;

        String consulta = "SELECT * FROM rubrica_presentacion WHERE ID_Estudiante = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, idEstudiante);

            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                rubrica = convertirResultSetRubrica(resultado);
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return rubrica;
    }

    private static void pasarCriterios(PreparedStatement sentencia, RubricaPresentacion rubrica) throws SQLException {
        float[] criterios = rubrica.getCriterios();

        for(int i = 0; i < criterios.length; i++) {
            sentencia.setFloat(i + 2, criterios[i]);
        }
    }

    private static void pasarDatosASentencia(PreparedStatement sentencia, RubricaPresentacion rubrica) throws SQLException {
        sentencia.setTimestamp(1, Timestamp.valueOf(rubrica.getFechaHora()));

        pasarCriterios(sentencia, rubrica); // Abarca índices 2 al 6

        sentencia.setFloat(7, rubrica.getCalificacion());
        sentencia.setString(8, rubrica.getObservaciones());
        sentencia.setInt(9, rubrica.getIdEstudiante());
        sentencia.setInt(10, rubrica.getIdPeriodo());
        sentencia.setInt(11, rubrica.getIdProfesor());
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
        rubrica.setEvaluador(ProfesorDAO.obtenerPorId(rubrica.getIdProfesor()));

        float[] criterios = {
                rs.getFloat("criterio1"),
                rs.getFloat("criterio2"),
                rs.getFloat("criterio3"),
                rs.getFloat("criterio4"),
                rs.getFloat("criterio5"),
        };

        rubrica.setCriterios(criterios);

        return rubrica;
    }
}

