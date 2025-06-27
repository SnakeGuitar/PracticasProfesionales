/*
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 12-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 12-06-2025
 * Descripción: Clase DAO para manejar las operaciones de la entidad Responsable Tecnico.
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.ResponsableTecnico;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ResponsableTecnicoDAO {

    public static ArrayList<ResponsableTecnico> obtenerResponsables() throws SQLException {
        ArrayList<ResponsableTecnico> lista = new ArrayList<>();
        String consulta = "SELECT * FROM responsable_tecnico";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement stmt = conexion.prepareStatement(consulta);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(convertirResultSetAResponsable(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener responsables técnicos: " + e.getMessage());
            throw e;
        }

        return lista;
    }

    public static ResponsableTecnico obtenerPorId(int id) throws SQLException {
        ResponsableTecnico responsable = null;
        String consulta = "SELECT * FROM responsable_tecnico WHERE ID_Responsable = ?";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement stmt = conexion.prepareStatement(consulta)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    responsable = convertirResultSetAResponsable(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener responsable técnico por ID: " + e.getMessage());
            throw e;
        }

        return responsable;
    }

    public static List<ResponsableTecnico> obtenerPorOrganizacion(int idOV) throws SQLException {
        List<ResponsableTecnico> lista = new ArrayList<>();
        String consulta = "SELECT * FROM responsable_tecnico WHERE ID_Org_Vinculada = ?";
        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement sentencia = conexion.prepareStatement(consulta)) {
            sentencia.setInt(1, idOV);
            try (ResultSet rs = sentencia.executeQuery()) {
                while (rs.next()) {
                    lista.add(convertirResultSetAResponsable(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener los responsables técnicos por Organizacion: "+e.getMessage());
            throw e;
        }
        return lista;
    }

    public static boolean insertar(ResponsableTecnico r) throws SQLException {
        String consulta = "INSERT INTO responsable_tecnico (nombre, departamento, puesto, correo, ID_Org_Vinculada) " +
                          "VALUES (?, ?, ?, ?, ?)";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement stmt = conexion.prepareStatement(consulta)) {

            stmt.setString(1, r.getNombre());
            stmt.setString(2, r.getDepartamento());
            stmt.setString(3, r.getPuesto());
            stmt.setString(4, r.getCorreo());
            stmt.setInt(5, r.getIdOrganizacionVinculada());

            int filas = stmt.executeUpdate();
            if (filas > 0) {
                System.out.println("Responsable técnico registrado exitosamente.");
                return true;
            } else {
                System.out.println("No se pudo registrar el responsable técnico.");
                return false;
            }

        } catch (SQLException e) {
            System.err.println("Error al insertar responsable técnico: " + e.getMessage());
            throw e;
        }
    }

    public static boolean actualizar(ResponsableTecnico r) throws SQLException {
        String consulta = "UPDATE responsable_tecnico SET nombre = ?, departamento = ?, puesto = ?, correo = ?, ID_Org_Vinculada = ? " +
                          "WHERE ID_Responsable = ?";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement stmt = conexion.prepareStatement(consulta)) {

            stmt.setString(1, r.getNombre());
            stmt.setString(2, r.getDepartamento());
            stmt.setString(3, r.getPuesto());
            stmt.setString(4, r.getCorreo());
            stmt.setInt(5, r.getIdOrganizacionVinculada());
            stmt.setInt(6, r.getIdResponsable());

            int filas = stmt.executeUpdate();
            if (filas > 0) {
                System.out.println("Responsable técnico actualizado exitosamente.");
                return true;
            } else {
                System.out.println("No se pudo actualizar el responsable técnico.");
                return false;
            }

        } catch (SQLException e) {
            System.err.println("Error al actualizar responsable técnico: " + e.getMessage());
            throw e;
        }
    }

    public static boolean eliminar(int id) throws SQLException {
        String consulta = "DELETE FROM responsable_tecnico WHERE ID_Responsable = ?";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement stmt = conexion.prepareStatement(consulta)) {

            stmt.setInt(1, id);

            int filas = stmt.executeUpdate();

            if (filas > 0) {
                System.out.println("Responsable técnico eliminado exitosamente.");
                return true;
            } else {
                System.out.println("No se pudo eliminar el responsable técnico.");
                return false;
            }

        } catch (SQLException e) {
            System.err.println("Error al eliminar responsable técnico: " + e.getMessage());
            throw e;
        }
    }

    public static boolean tieneProyectosAsociados(int idResponsable) throws SQLException {
        boolean tieneProyectos = false;
        String consulta = "SELECT COUNT(*) > 0 AS tieneProyectos FROM proyecto WHERE ID_Responsable = ?";

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement stmt = conexion.prepareStatement(consulta)) {

            stmt.setInt(1, idResponsable);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    tieneProyectos = rs.getBoolean("tieneProyectos");
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al verificar proyectos asociados al responsable técnico: " + e.getMessage());
            throw e;
        }

        return tieneProyectos;
    }

    private static ResponsableTecnico convertirResultSetAResponsable(ResultSet rs) throws SQLException {
        ResponsableTecnico r = new ResponsableTecnico();
        r.setIdResponsable(rs.getInt("ID_Responsable"));
        r.setNombre(rs.getString("nombre"));
        r.setDepartamento(rs.getString("departamento"));
        r.setPuesto(rs.getString("puesto"));
        r.setCorreo(rs.getString("correo"));
        r.setIdOrganizacionVinculada(rs.getInt("ID_Org_Vinculada"));
        return r;
    }
}