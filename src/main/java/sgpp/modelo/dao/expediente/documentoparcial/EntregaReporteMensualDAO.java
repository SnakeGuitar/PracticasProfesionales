/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 16-06-2025
 * Descripción: DAO para manejar operaciones CRUD sobre la entidad 'entrega_reporte'.
 *
 * Estado: En funcionamiento
 * Modificaciones:
 *   - 17-06-2025: se agregaron obtenerEntregasAbiertasPorEstudiante y
 *                 obtenerEntregasPorEstudiante.
 */

package sgpp.modelo.dao.expediente.documentoparcial;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaReporteMensual;

import java.sql.*;
import java.util.ArrayList;

public class EntregaReporteMensualDAO {

    /* ---------- EXISTENTES ---------- */

    public static ArrayList<EntregaReporteMensual> obtenerPorEstudianteYPeriodo(int idEstudiante, int idPeriodo)
            throws SQLException {

        ArrayList<EntregaReporteMensual> entregas = new ArrayList<>();
        String sql = "SELECT * FROM entrega_reporte WHERE ID_Estudiante = ? AND ID_Periodo = ?";

        try (Connection con = ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idEstudiante);
            ps.setInt(2, idPeriodo);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) entregas.add(convertir(rs));
            }
        }
        return entregas;
    }

    public static boolean insertar(EntregaReporteMensual entrega) throws SQLException {
        String sql = """
            INSERT INTO entrega_reporte
            (num_reporte, fecha_apertura, fecha_limite, fecha_entrega, ID_Estudiante, ID_Periodo)
            VALUES (?, ?, ?, ?, ?, ?)
        """;

        try (Connection con = ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, entrega.getNumReporte());
            ps.setTimestamp(2, Timestamp.valueOf(entrega.getFechaApertura()));
            ps.setTimestamp(3, Timestamp.valueOf(entrega.getFechaLimite()));
            if (entrega.getFechaEntrega() != null) {
                ps.setTimestamp(4, Timestamp.valueOf(entrega.getFechaEntrega()));
            } else {
                ps.setNull(4, Types.TIMESTAMP);
            }
            ps.setInt(5, entrega.getIdEstudiante());
            ps.setInt(6, entrega.getIdPeriodo());

            return ps.executeUpdate() > 0;
        }
    }

    public static EntregaReporteMensual obtenerEntrega(int numReporte, int idPeriodo) {
        String sql = "SELECT * FROM entrega_reporte WHERE num_reporte = ? AND ID_Periodo = ?";
        EntregaReporteMensual entrega = null;

        try (Connection con = ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, numReporte);
            ps.setInt(2, idPeriodo);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) entrega = convertir(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener la entrega del reporte " + numReporte + ": " + e.getMessage());
        }
        return entrega;
    }

   
    public static ArrayList<EntregaReporteMensual> obtenerEntregasPorEstudiante(int idEstudiante) throws SQLException {
        ArrayList<EntregaReporteMensual> lista = new ArrayList<>();
        String sql = "SELECT * FROM entrega_reporte WHERE ID_Estudiante = ?";

        try (Connection con = ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idEstudiante);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(convertir(rs));
            }
        }
        return lista;
    }

    /** Devuelve solo las entregas que están ABIERTAS ahora mismo para un estudiante. */
    public static ArrayList<EntregaReporteMensual> obtenerEntregasAbiertasPorEstudiante(int idEstudiante) throws SQLException {
        ArrayList<EntregaReporteMensual> lista = new ArrayList<>();
        String sql = """
            SELECT *
            FROM entrega_reporte
            WHERE ID_Estudiante = ?
              AND NOW() BETWEEN fecha_apertura AND fecha_limite
        """;

        try (Connection con = ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idEstudiante);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(convertir(rs));
            }
        }
        return lista;
    }

 

    private static EntregaReporteMensual convertir(ResultSet rs) throws SQLException {
        EntregaReporteMensual er = new EntregaReporteMensual();
        er.setIdEntregaReporte(rs.getInt("ID_Entrega_Reporte"));
        er.setNumReporte(rs.getInt("num_reporte"));
        er.setFechaApertura(rs.getTimestamp("fecha_apertura").toLocalDateTime());
        er.setFechaLimite(rs.getTimestamp("fecha_limite").toLocalDateTime());
        Timestamp t = rs.getTimestamp("fecha_entrega");
        er.setFechaEntrega(t != null ? t.toLocalDateTime() : null);
        er.setIdEstudiante(rs.getInt("ID_Estudiante"));
        er.setIdPeriodo(rs.getInt("ID_Periodo"));
        return er;
    }
    
    public static boolean marcarComoEntregado(int idEntregaReporte) throws SQLException {
    String sql = "UPDATE entrega_reporte SET fecha_entrega = NOW() WHERE ID_Entrega_Reporte = ?";

    try (Connection con = ConexionBD.abrirConexion();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, idEntregaReporte);
        return ps.executeUpdate() > 0;
    }
    
    
}

    public static ArrayList<EntregaReporteMensual> obtenerPorPeriodo(int idPeriodo) throws SQLException {
    ArrayList<EntregaReporteMensual> lista = new ArrayList<>();
    String sql = "SELECT * FROM entrega_reporte WHERE ID_Periodo = ? ORDER BY num_reporte";

    try (Connection con = ConexionBD.abrirConexion();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, idPeriodo);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(convertir(rs));
        }
    }
    return lista;
}

}
