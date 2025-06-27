/*
 * Autor original: Seth Márquez
 * Último autor: Seth Márquez
 * Fecha de creación: 10-06-2025
 * Fecha de la última modificación: 15-06-2025
 * Descripción: DAO para obtener asignaciones desde la vista
 *              vista_estudiante_proyecto_ov_responsable (ya extendida).
 *
 * Estado: Finalizado
 * Modificaciones:
 * - Incluye fecha_inicio, dirección, puesto y departamento del responsable
 *   gracias a la vista actualizada.
 */
package sgpp.modelo.dao.entidades;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.documentoinicial.TablaAsignacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TablaAsignacionDAO {

    public static ObservableList<TablaAsignacion> obtenerAsignaciones() throws SQLException {
        ObservableList<TablaAsignacion> lista = FXCollections.observableArrayList();

        String consulta = """
            SELECT  ID_Estudiante,
                    nombre_estudiante,
                    matricula,
                    ID_Org_Vinculada,
                    nombre_organizacion,
                    direccion,
                    ID_Proyecto,
                    nombre_proyecto,
                    fecha_inicio,
                    ID_Responsable,
                    nombre_responsable,
                    puesto_responsable,
                    departamento_responsable,
                    ID_Periodo
            FROM vista_estudiante_proyecto_ov_responsable
            WHERE ID_Periodo = (
                SELECT MAX(ID_Periodo) FROM vista_estudiante_proyecto_ov_responsable
            )
        """;

        try (Connection conexion = ConexionBD.abrirConexion();
             PreparedStatement ps = conexion.prepareStatement(consulta);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                TablaAsignacion asignacion = new TablaAsignacion(
                        rs.getInt("ID_Estudiante"),
                        rs.getString("nombre_estudiante"),
                        rs.getString("matricula"),
                        rs.getInt("ID_Org_Vinculada"),
                        rs.getString("nombre_organizacion"),
                        rs.getString("direccion"),
                        rs.getInt("ID_Proyecto"),
                        rs.getString("nombre_proyecto"),
                        rs.getDate("fecha_inicio").toLocalDate(),
                        rs.getInt("ID_Responsable"),
                        rs.getString("nombre_responsable"),
                        rs.getString("puesto_responsable"),
                        rs.getString("departamento_responsable"),
                        rs.getInt("ID_Periodo")
                );
                lista.add(asignacion);
            }

        } catch (SQLException e) {
            System.err.println(" Error al obtener las asignaciones: " + e.getMessage());
            throw e;
        }

        return lista;
    }
}
