/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: DAO para insertar y recuperar oficios de asignación desde la base de datos.
 */

package sgpp.modelo.dao.expediente.documentoinicial;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.documentoinicial.OficioAsignacion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OficioAsignacionDAO {

    public static boolean guardar(OficioAsignacion oficio) {
        try (Connection conexion = ConexionBD.abrirConexion()) {
            if (conexion == null) {
                System.err.println("No se pudo establecer conexión con la base de datos.");
                return false;
            }

            String sql = "INSERT INTO oficio_asignacion (ID_Periodo, ID_Estudiante, documento) VALUES (?, ?, ?)";
            PreparedStatement stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, oficio.getIdPeriodo());
            stmt.setInt(2, oficio.getIdEstudiante());
            stmt.setBytes(3, oficio.getDocumento());

            int filas = stmt.executeUpdate();
            stmt.close();

            return filas > 0;

        } catch (SQLException e) {
            System.err.println("Error al guardar el oficio: " + e.getMessage());
            return false;
        }
    }

    public static List<OficioAsignacion> obtenerTodos() {
        List<OficioAsignacion> oficios = new ArrayList<>();

        try (Connection conexion = ConexionBD.abrirConexion()) {
            if (conexion == null) {
                System.err.println("No se pudo establecer conexión con la base de datos.");
                return oficios;
            }

            String sql = "SELECT * FROM oficio_asignacion";
            PreparedStatement stmt = conexion.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OficioAsignacion oficio = new OficioAsignacion();
                oficio.setIdOficio(rs.getInt("ID_Oficio"));
                oficio.setIdPeriodo(rs.getInt("ID_Periodo"));
                oficio.setIdEstudiante(rs.getInt("ID_Estudiante"));
                oficio.setDocumento(rs.getBytes("documento"));
                oficios.add(oficio);
            }

            rs.close();
            stmt.close();

        } catch (SQLException e) {
            System.err.println("Error al obtener oficios: " + e.getMessage());
        }

        return oficios;
    }

    public static boolean yaExiste(int idEstudiante, int idPeriodo) {
        boolean existe = false;

        try (Connection conexion = ConexionBD.abrirConexion()) {
            if (conexion == null) {
                System.err.println("No se pudo establecer conexión con la base de datos.");
                return false;
            }

            String consulta = "SELECT COUNT(*) FROM oficio_asignacion WHERE ID_Estudiante = ? AND ID_Periodo = ?";
            PreparedStatement sentencia = conexion.prepareStatement(consulta);
            sentencia.setInt(1, idEstudiante);
            sentencia.setInt(2, idPeriodo);
            ResultSet resultado = sentencia.executeQuery();

            if (resultado.next()) {
                existe = resultado.getInt(1) > 0;
            }

            resultado.close();
            sentencia.close();

        } catch (SQLException e) {
            System.err.println("Error al verificar existencia del oficio: " + e.getMessage());
        }

        return existe;
    }

    public static OficioAsignacion obtenerPorEstudianteYPeriodo(int idEstudiante, int idPeriodo) {
        OficioAsignacion oficio = null;

        try (Connection conexion = ConexionBD.abrirConexion()) {
            if (conexion == null) {
                System.err.println("No se pudo establecer conexión con la base de datos.");
                return null;
            }

            String sql = "SELECT * FROM oficio_asignacion WHERE ID_Estudiante = ? AND ID_Periodo = ?";
            PreparedStatement stmt = conexion.prepareStatement(sql);
            stmt.setInt(1, idEstudiante);
            stmt.setInt(2, idPeriodo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                oficio = new OficioAsignacion();
                oficio.setIdOficio(rs.getInt("ID_Oficio"));
                oficio.setIdPeriodo(rs.getInt("ID_Periodo"));
                oficio.setIdEstudiante(rs.getInt("ID_Estudiante"));
                oficio.setDocumento(rs.getBytes("documento"));
            }

            rs.close();
            stmt.close();

        } catch (SQLException e) {
            System.err.println("Error al obtener el oficio: " + e.getMessage());
        }

        return oficio;
    }
    
    public static boolean actualizar(OficioAsignacion oficio) {
    try (Connection conexion = ConexionBD.abrirConexion()) {
        if (conexion == null) {
            System.err.println("No se pudo establecer conexión con la base de datos.");
            return false;
        }

        String sql = "UPDATE oficio_asignacion SET documento = ? WHERE ID_Estudiante = ? AND ID_Periodo = ?";
        PreparedStatement stmt = conexion.prepareStatement(sql);
        stmt.setBytes(1, oficio.getDocumento());
        stmt.setInt(2, oficio.getIdEstudiante());
        stmt.setInt(3, oficio.getIdPeriodo());

        int filas = stmt.executeUpdate();
        stmt.close();

        return filas > 0;
    } catch (SQLException e) {
        System.err.println("Error al actualizar el oficio: " + e.getMessage());
        return false;
    }
}

}
