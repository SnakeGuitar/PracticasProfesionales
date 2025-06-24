package sgpp.modelo.dao.expediente;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.EstadoExpediente;
import sgpp.modelo.beans.expediente.Expediente;
import sgpp.utilidad.Utilidad;

import java.sql.*;
import java.util.ArrayList;

public class ExpedienteDAO {

    // Método READ - Obtener expediente por ID de estudiante y periodo
    public static Expediente obtenerPorId(int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        Expediente expediente = null;

        String consulta = "SELECT * FROM expediente WHERE ID_Estudiante = ? AND ID_Periodo = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setInt(1, idEstudiante);
            sentencia.setInt(2, idPeriodo);

            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                expediente = convertirResultSetExpediente(resultado);
            } else {
                throw new SQLException("No se encontró el expediente para estudiante ID: " + idEstudiante + " y periodo ID: " + idPeriodo);
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return expediente;
    }

    // Método READ - Obtener todos los expedientes
    public static ArrayList<Expediente> obtenerExpedientes() throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        ArrayList<Expediente> expedientes = new ArrayList<>();
        String consulta = "SELECT * FROM expediente";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            resultado = sentencia.executeQuery();

            while (resultado.next()) {
                expedientes.add(convertirResultSetExpediente(resultado));
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return expedientes;
    }

    // Método UPDATE - Actualizar expediente
    public static boolean actualizar(Expediente expediente) throws SQLException {
        boolean exitoso = false;
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "UPDATE expediente SET estado = ?, horas_acumuladas = ? WHERE ID_Estudiante = ? AND ID_Periodo = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            sentencia.setString(1, expediente.getEstado().toString());
            sentencia.setInt(2, expediente.getHorasAcumuladas());
            sentencia.setInt(3, expediente.getIdEstudiante());
            sentencia.setInt(4, expediente.getIdPeriodo());

            int filas = sentencia.executeUpdate();

            if (filas > 0) {
                Utilidad.crearAlertaInformacion("Actualización exitosa",
                        "Expediente actualizado exitosamente.");
                exitoso = true;
            } else {
                throw new SQLException("No se pudo actualizar el expediente");
            }

        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }

        return exitoso;
    }

    // Método para convertir ResultSet a objeto Expediente
    public static Expediente convertirResultSetExpediente(ResultSet resultado) throws SQLException {
        Expediente expediente = new Expediente();

        expediente.setIdEstudiante(resultado.getInt("ID_Estudiante"));
        expediente.setIdPeriodo(resultado.getInt("ID_Periodo"));

        // Convertir el string del enum a EstadoExpediente
        String estadoString = resultado.getString("estado");
        if (estadoString != null) {
            expediente.setEstado(EstadoExpediente.valueOf(estadoString));
        }

        expediente.setHorasAcumuladas(resultado.getInt("horas_acumuladas"));

        return expediente;
    }
}
