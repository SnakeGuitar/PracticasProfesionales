/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 10-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 11-06-2025
 * Descripción: Clase DAO para manejar las operaciones de la entidad OrganizacionVinculada.
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.OrganizacionVinculada;

import java.sql.*;
import java.util.ArrayList;

public class OrganizacionVinculadaDAO {
    public static ArrayList<OrganizacionVinculada> obtenerOrganizacionesVinculadas() throws SQLException {
        ArrayList<OrganizacionVinculada> organizaciones = new ArrayList<>();
        String consulta = "SELECT * FROM organizacion_vinculada";
        try (Connection conexionBD = ConexionBD.abrirConexion();
             Statement sentencia = conexionBD.createStatement();
             ResultSet resultado = sentencia.executeQuery(consulta)) {
            while (resultado.next()) {
                organizaciones.add(convertirResultSetAOV(resultado));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener organizaciones vinculadas: " + e.getMessage());
            throw e; // Re-lanzar la excepción para que pueda ser manejada por el llamador
        }
        return organizaciones;
    }

    public static boolean registrar(OrganizacionVinculada organizacion) throws SQLException {
        String consulta = "INSERT INTO organizacion_vinculada(nombre, sector, correo, telefono, direccion, ciudad, estado) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conexionBD = ConexionBD.abrirConexion();
             PreparedStatement sentencia = conexionBD.prepareStatement(consulta)) {
            sentencia.setString(1, organizacion.getNombre());
            sentencia.setString(2, organizacion.getSector());
            sentencia.setString(3, organizacion.getCorreo());
            sentencia.setString(4, organizacion.getTelefono());
            sentencia.setString(5, organizacion.getDireccion());
            sentencia.setString(6, organizacion.getCiudad());
            sentencia.setString(7, organizacion.getEstado());
            int filasAfectadas = sentencia.executeUpdate();
            if (filasAfectadas > 0) {
                System.out.println("Organización vinculada registrada exitosamente.");
                return true; // Retornar true si la inserción fue exitosa
            } else {
                System.out.println("No se pudo registrar la organización vinculada.");
                return false; // Retornar false si no se insertó ninguna fila
            }
        } catch (SQLException e) {
            System.err.println("Error al registrar organización vinculada: " + e.getMessage());
            throw e; // Re-lanzar la excepción para que pueda ser manejada por el llamador
        }
    }

    public static OrganizacionVinculada obtenerPorId(int idOrganizacion) throws SQLException {
        OrganizacionVinculada organizacion = null;
        String consulta = "SELECT * FROM organizacion_vinculada WHERE ID_Org_Vinculada = ?";

        try (Connection conexionBD = ConexionBD.abrirConexion();
             PreparedStatement sentencia = conexionBD.prepareStatement(consulta)) {

            sentencia.setInt(1, idOrganizacion);

            try (ResultSet resultado = sentencia.executeQuery()) {
                if (resultado.next()) {
                    organizacion = convertirResultSetAOV(resultado);
                } else {
                    throw new SQLException("No se encontró la organización vinculada con ID: " + idOrganizacion);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener organización vinculada por ID: " + e.getMessage());
            throw e;
        }

        return organizacion;
    }

    public static boolean actualizar(OrganizacionVinculada organizacion) throws SQLException {
        String consulta = "UPDATE organizacion_vinculada " +
                "SET nombre = ?, " +
                "sector = ?, " +
                "correo = ?, " +
                "telefono = ?, " +
                "direccion = ?, " +
                "ciudad = ?, " +
                "estado = ? " +
                "WHERE ID_Org_Vinculada = ?";
        try (Connection conexionBD = ConexionBD.abrirConexion();
             PreparedStatement sentencia = conexionBD.prepareStatement(consulta)) {
            sentencia.setString(1, organizacion.getNombre());
            sentencia.setString(2, organizacion.getSector());
            sentencia.setString(3, organizacion.getCorreo());
            sentencia.setString(4, organizacion.getTelefono());
            sentencia.setString(5, organizacion.getDireccion());
            sentencia.setString(6, organizacion.getCiudad());
            sentencia.setString(7, organizacion.getEstado());
            sentencia.setInt(8, organizacion.getIdOrganizacionVinculada());
            int filasAfectadas = sentencia.executeUpdate();
            if (filasAfectadas > 0) {
                System.out.println("Organización vinculada actualizada exitosamente.");
                return true; // Retornar true si la actualización fue exitosa
            } else {
                System.out.println("No se pudo actualizar la organización vinculada.");
                return false; // Retornar false si no se actualizó ninguna fila
            }
        } catch (SQLException e) {
            System.err.println("Error al actualizar organización vinculada: " + e.getMessage());
            throw e; // Re-lanzar la excepción para que pueda ser manejada por el llamador
        }
    }

    public static boolean eliminar(int id) throws SQLException {
        String consulta = "DELETE FROM organizacion_vinculada WHERE ID_Org_Vinculada = ?";
        try (Connection conexionBD = ConexionBD.abrirConexion();
             PreparedStatement sentencia = conexionBD.prepareStatement(consulta)) {
            sentencia.setInt(1, id);
            int filasAfectadas = sentencia.executeUpdate();
            if (filasAfectadas == 1) {
                System.out.println("Organización vinculada eliminada exitosamente.");
                return true; // Retornar true si la eliminación fue exitosa
            } else {
                System.out.println("No se pudo eliminar la organización vinculada.");
                return false; // Retornar false si no se eliminó ninguna fila
            }
        } catch (SQLException e) {
            System.err.println("Error al eliminar organización vinculada: " + e.getMessage());
            throw e; // Re-lanzar la excepción para que pueda ser manejada por el llamador
        }
    }

    private static OrganizacionVinculada convertirResultSetAOV(ResultSet resultado) throws SQLException {
        OrganizacionVinculada organizacion = new OrganizacionVinculada();

        organizacion.setIdOrganizacionVinculada(resultado.getInt("ID_Org_Vinculada"));
        organizacion.setNombre(resultado.getString("nombre"));
        organizacion.setSector(resultado.getString("sector"));
        organizacion.setCorreo(resultado.getString("correo"));
        organizacion.setTelefono(resultado.getString("telefono"));
        organizacion.setDireccion(resultado.getString("direccion"));
        organizacion.setCiudad(resultado.getString("ciudad"));
        organizacion.setEstado(resultado.getString("estado"));

        return organizacion;
    }
    
      public static ArrayList<OrganizacionVinculada> obtenerIdYNombresOrganizaciones() throws SQLException {
        ArrayList<OrganizacionVinculada> organizaciones = new ArrayList<>();
        String consulta = "SELECT ID_Org_Vinculada, nombre FROM organizacion_vinculada";
        
        try (Connection conexionBD = ConexionBD.abrirConexion();
             PreparedStatement sentencia = conexionBD.prepareStatement(consulta);
             ResultSet resultado = sentencia.executeQuery()) {

            while (resultado.next()) {
                OrganizacionVinculada organizacion = new OrganizacionVinculada();
                organizacion.setIdOrganizacionVinculada(resultado.getInt("ID_Org_Vinculada"));
                organizacion.setNombre(resultado.getString("nombre"));
                organizaciones.add(organizacion);
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener ID y nombres de organizaciones vinculadas: " + e.getMessage());
            throw e;
        }

        return organizaciones;
    }

    public static OrganizacionVinculada obtenerPorAsocionAProyecto(int idProyecto) throws SQLException {
        OrganizacionVinculada ov = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta =
                    "SELECT ov.ID_Org_Vinculada, ov.nombre, ov.sector, ov.correo, ov.telefono, ov.direccion, ov.ciudad, ov.estado FROM Organizacion_Vinculada ov " +
                    "JOIN proyecto p ON ov.ID_Org_Vinculada = p.ID_Org_Vinculada " +
                    "WHERE p.ID_Proyecto = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idProyecto);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    ov = convertirResultSetAOV(resultado);
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al recuperar la OV: "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la Base de Datos");
        }
        return ov;
    }
}