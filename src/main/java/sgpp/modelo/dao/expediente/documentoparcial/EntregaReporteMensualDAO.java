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
import sgpp.modelo.beans.expediente.reporte.EntregaReporteMensual;
import sgpp.modelo.dao.ResultadoSQL;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

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
        EntregaReporteMensual entrega = new EntregaReporteMensual();
        entrega.setIdEntregaReporte(rs.getInt("ID_Entrega_Reporte"));
        entrega.setNumReporte(rs.getInt("num_reporte"));
        entrega.setFechaApertura(UtilidadFormatoDeDatos.stringToLocalDateTime(rs.getString("fecha_apertura")));
        entrega.setFechaLimite(UtilidadFormatoDeDatos.stringToLocalDateTime(rs.getString("fecha_limite")));
        String fechaEntrega = rs.getString("fecha_entrega");
        entrega.setFechaEntrega(fechaEntrega != null ? UtilidadFormatoDeDatos.stringToLocalDateTime(fechaEntrega) : null);
        entrega.setIdEstudiante(rs.getInt("ID_Estudiante"));
        entrega.setIdPeriodo(rs.getInt("ID_Periodo"));
        return entrega;
    }
    
    public static boolean marcarComoEntregado(int idEntregaReporte) throws SQLException {
        String sql = "UPDATE entrega_reporte SET fecha_entrega = NOW() WHERE ID_Entrega_Reporte = ?";

        try (Connection con = ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idEntregaReporte);
            return ps.executeUpdate() > 0;
        }
    }

    public static EntregaReporteMensual obtenerPrimeraEntregaPorPeriodo(int numReporte, int idPeriodo) throws SQLException {
        EntregaReporteMensual entrega = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM entrega_reporte WHERE num_reporte = ? AND ID_Periodo = ? AND fecha_apertura IS NOT NULL ORDER BY fecha_apertura ASC LIMIT 1";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, numReporte);
                sentencia.setInt(2, idPeriodo);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    entrega = convertir(resultado);
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al recuperar la entrega "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException(String.format("No se pudo obtener la entrega %s del periodo", numReporte));
        }
        return entrega;
    }

    public static EntregaReporteMensual obtenerEntregaReporteDisponible(int idEstudiante, int idPeriodo, int numReporte) throws SQLException {
        EntregaReporteMensual entrega = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM entrega_reporte WHERE ID_Estudiante = ? AND ID_Periodo = ? AND num_reporte = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEstudiante);
                sentencia.setInt(2, idPeriodo);
                sentencia.setInt(3, numReporte);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    entrega = convertir(resultado);
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al recuperar la entrega de reporte "+numReporte+" "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la base de datos");
        }
        return entrega;
    }

    public static List<EntregaReporteMensual> obtenerPorPeriodo(int idPeriodo) throws SQLException {
        ArrayList<EntregaReporteMensual> lista = new ArrayList<>();
        String sql = "SELECT * FROM entrega_reporte WHERE ID_Periodo = ? ORDER BY num_reporte ASC";

        try (Connection con = ConexionBD.abrirConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idPeriodo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(convertir(rs));
            }
        }
        return lista;
    }

    public static ResultadoSQL programarEntregas(EntregaReporteMensual entregaReporte, int idPeriodo) throws SQLException {
        ResultadoSQL resultadoOperacion = new ResultadoSQL();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "UPDATE entrega_reporte SET fecha_apertura = ?, fecha_limite = ? WHERE ID_Periodo = ? AND num_reporte = ?";
            PreparedStatement sentencia = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setString(1, entregaReporte.getFechaApertura().toString());
                sentencia.setString(2, entregaReporte.getFechaLimite().toString());
                sentencia.setInt(3, idPeriodo);
                sentencia.setInt(4, entregaReporte.getNumReporte());
                int filasAfectadas = sentencia.executeUpdate();
                if (filasAfectadas > 0) {
                    resultadoOperacion.setError(false);
                    resultadoOperacion.setMensaje(String.format(
                            "Entrega del reporte %s configurada exitosamente", entregaReporte.getNumReporte()));
                } else {
                    resultadoOperacion.setError(true);
                    resultadoOperacion.setMensaje(String.format(
                            "No se pudo configurar la entrega del reporte %s", entregaReporte.getNumReporte()));
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al configurar la entrega: "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la Base de Datos");
        }
        return resultadoOperacion;
    }
}
