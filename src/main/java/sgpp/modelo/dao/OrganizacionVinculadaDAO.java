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

package sgpp.modelo.dao;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.OrganizacionVinculada;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class OrganizacionVinculadaDAO {
    public static ArrayList<OrganizacionVinculada> obtenerOrganizacionesVinculadas() throws SQLException {
        ArrayList<OrganizacionVinculada> organizaciones = new ArrayList<>();
        String consulta = "SELECT * FROM organizacion_vinculada";
        try (Connection conexionBD = ConexionBD.abrirConexion();
             Statement sentencia = conexionBD.createStatement();
             ResultSet resultado = sentencia.executeQuery(consulta)) {
            while (resultado.next()) {
                organizaciones.add(convertirRegistroALumno(resultado));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener organizaciones vinculadas: " + e.getMessage());
            throw e; // Re-lanzar la excepción para que pueda ser manejada por el llamador
        }
        return organizaciones;
    }

    public static boolean registrarOrganizacionVinculada(OrganizacionVinculada organizacion) throws SQLException {
        // Aquí se implementaría la lógica para registrar una nueva organización vinculada en la base de datos.
        // Por ejemplo, se podría usar JDBC para ejecutar una sentencia SQL de inserción.
        return true; // Retornar true si la inserción fue exitosa, false en caso contrario.
    }

    public static boolean actualizarOrganizacionVinculada(OrganizacionVinculada organizacion) throws SQLException {
        // Aquí se implementaría la lógica para actualizar una organización vinculada en la base de datos.
        // Por ejemplo, se podría usar JDBC para ejecutar una sentencia SQL de actualización.
        return true; // Retornar true si la actualización fue exitosa, false en caso contrario.
    }

    public static boolean eliminarOrganizacionVinculada(int id) throws SQLException {
        // Aquí se implementaría la lógica para eliminar una organización vinculada de la base de datos.
        // Por ejemplo, se podría usar JDBC para ejecutar una sentencia SQL de eliminación.
        return true; // Retornar true si la eliminación fue exitosa, false en caso contrario.
    }

    public static OrganizacionVinculada convertirRegistroALumno(ResultSet resultado) throws SQLException {
        OrganizacionVinculada organizacion = new OrganizacionVinculada();
        organizacion.setId(resultado.getInt("ID_Organizacion"));
        organizacion.setNombre(resultado.getString("Nombre"));
        organizacion.setSector(resultado.getString("Sector"));
        organizacion.setCorreo(resultado.getString("Correo"));
        organizacion.setTelefono(resultado.getString("Telefono"));
        organizacion.setDireccion(resultado.getString("Direccion"));
        organizacion.setCiudad(resultado.getString("Ciudad"));
        organizacion.setEstado(resultado.getString("Estado"));
        return organizacion;
    }
}