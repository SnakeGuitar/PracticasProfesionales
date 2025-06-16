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
import sgpp.modelo.beans.expediente.documentoparcial.EntregaReporteMensual;

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

}
