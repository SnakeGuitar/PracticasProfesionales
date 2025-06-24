/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 16-06-2025
 * Descripción: DAO para manejar operaciones CRUD sobre la entidad 'entrega_reporte'.
 *
 * Estado: En funcionamiento
 * Modificaciones:
 *   - 16-06-2025: se agregaron obtenerEntregasAbiertasPorEstudiante y
 *                 obtenerEntregasPorEstudiante.
 */


package sgpp.modelo.dao.expediente.documentoparcial;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.EstadoDocumento;
import sgpp.modelo.beans.expediente.reporte.Mes;
import sgpp.modelo.beans.expediente.reporte.ReporteMensual;

/**
 *
 * @author cuent
 */
public class ReporteMensualDAO {
    public static boolean insertar(int idEntregaReporte, int horas, byte[] pdf) throws SQLException {
        String sql = """
            INSERT INTO reporte_mensual (mes, horas_reportadas, estado, reporte, ID_Entrega_Reporte)
            VALUES (?, ?, 'Entregado', ?, ?)
        """;

        LocalDateTime ahora = LocalDateTime.now();
        String mesActual = ahora.getMonth().getDisplayName(TextStyle.SHORT, new Locale("es")).substring(0, 1).toUpperCase()
                          + ahora.getMonth().getDisplayName(TextStyle.SHORT, new Locale("es")).substring(1, 3);

        try (Connection con = ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, mesActual);
            ps.setInt(2, horas);
            ps.setBytes(3, pdf);
            ps.setInt(4, idEntregaReporte);

            return ps.executeUpdate() > 0;
        }
    }
    
    // checa si ya hay un reporte asociado a una entrega
    public static boolean yaFueEntregado(int idEntregaReporte) throws SQLException {
        String sql = """
            SELECT COUNT(*) FROM reporte_mensual
            WHERE ID_Entrega_Reporte = ?
        """;

        try (Connection con = ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idEntregaReporte);

            try (var rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public static List<ReporteMensual> obtenerTodos() throws SQLException {
        List<ReporteMensual> reportes = new ArrayList<ReporteMensual>();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM reporte_mensual";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    reportes.add(convertirAReporte(resultado));
                }
            } catch (SQLException sqlex) {
                System.err.println("Error al obtener reportes "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la Base de Datos");
        }
        return reportes;
    }
    
    public static boolean actualizarEstado(int idEntregaReporte, String nuevoEstado, String observaciones) throws SQLException {
        String sql = """
            UPDATE reporte_mensual
            SET estado = ?, observaciones = ?
            WHERE ID_Entrega_Reporte = ?""";

        try (Connection c = ConexionBD.abrirConexion();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, nuevoEstado);
            ps.setString(2, observaciones);   // puede ser null
            ps.setInt   (3, idEntregaReporte);

            return ps.executeUpdate() == 1;
        }
    }

    public static ReporteMensual obtenerReportePorExpediente(int idEntregaReporte) throws SQLException {
        ReporteMensual reporte = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM Reporte_Mensual WHERE ID_Entrega_Reporte = ? AND reporte IS NOT NULL";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaReporte);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    reporte = convertirAReporte(resultado);
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al obtener los reportes mensuales "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la Base de Datos");
        }
        return reporte;
    }

    private static ReporteMensual convertirAReporte(ResultSet resultado) throws SQLException {
        ReporteMensual reporte = new ReporteMensual();
        reporte.setIdReporteMensual(resultado.getInt("ID_Reporte_Mensual"));
        reporte.setMes(Mes.valueOf(resultado.getString("mes")));
        reporte.setHorasReportadas(resultado.getInt("horas_reportadas"));
        reporte.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
        reporte.setObservaciones(resultado.getString("observaciones"));
        reporte.setReporte(resultado.getBytes("reporte"));
        reporte.setIdEntregaReporte(resultado.getInt("ID_Entrega_Reporte"));
        return reporte;
    }
}
