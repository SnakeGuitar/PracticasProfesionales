package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Proyecto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProyectoDAO {
    public static List<Proyecto> obtenerProyectos() throws SQLException {
        List<Proyecto> proyectos = new ArrayList<Proyecto>();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT p.ID_Proyecto, p.nombre, p.objetivo_general, p.metodologia, ov.nombre AS nombre_ov, rt.nombre AS nombre_responsable, p.max_participantes, p.fecha_inicio, p.fecha_fin, p.ID_Org_Vinculada, p.ID_Responsable FROM proyecto p " +
                    "JOIN organizacion_vinculada ov ON p.ID_Org_Vinculada = ov.ID_Org_Vinculada " +
                    "JOIN responsable_tecnico rt ON rt.ID_Org_Vinculada = ov.ID_Org_Vinculada";
            PreparedStatement sentencia = conexion.prepareStatement(consulta);
            ResultSet resultado = sentencia.executeQuery();
            while (resultado.next()) {
                proyectos.add(convertirProyecto(resultado));
            }
            resultado.close();
            sentencia.close();
            conexion.close();
        } else {
            throw new SQLException("No se pudieron recuperar los proyectos");
        }
        return proyectos;
    }

    private static Proyecto convertirProyecto(ResultSet rs) throws SQLException {
        Proyecto proyecto = new Proyecto();
        proyecto.setIdProyecto(rs.getInt("ID_Proyecto"));
        proyecto.setNombre(rs.getString("nombre"));
        proyecto.setObjetivoGeneral(rs.getString("objetivo_general"));
        proyecto.setMetodologia(rs.getString("metodologia"));
        proyecto.setNumeroMaximoParticipantes(rs.getInt("max_participantes"));
        proyecto.setFechaInicio(rs.getString("fecha_inicio"));
        proyecto.setFechaFin(rs.getString("fecha_fin"));
        proyecto.setIdOrganizacionVinculada(rs.getInt("ID_Org_Vinculada"));
        proyecto.setIdResponsable(rs.getInt("ID_Responsable"));
        proyecto.setNombreOV(rs.getString("nombre_ov"));
        proyecto.setNombreResponsable(rs.getString("nombre_responsable"));
        return proyecto;
    }

}