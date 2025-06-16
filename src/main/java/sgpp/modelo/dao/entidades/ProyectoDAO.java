package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.dao.ResultadoSQL;

import java.sql.*;
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

    public static ResultadoSQL registrar(Proyecto proyecto) {
        ResultadoSQL resultado = new ResultadoSQL();
        String llamada = "{CALL insertar_proyecto(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        try (Connection conexion = ConexionBD.abrirConexion();
             CallableStatement sentencia = conexion.prepareCall(llamada)) {
            int idGenerado = -1;
            sentencia.setString(1, proyecto.getNombre());
            sentencia.setString(2, proyecto.getObjetivoGeneral());
            sentencia.setString(3, proyecto.getMetodologia());
            sentencia.setInt(4, proyecto.getNumeroMaximoParticipantes());
            sentencia.setString(5, proyecto.getFechaInicio());
            sentencia.setString(6, proyecto.getFechaFin());
            sentencia.setInt(7, proyecto.getIdOrganizacionVinculada());
            sentencia.setInt(8, proyecto.getIdResponsable());
            sentencia.registerOutParameter(9, Types.INTEGER);
            sentencia.execute();
            idGenerado = sentencia.getInt("ID_generado_out");
            if (idGenerado != -1) {
                resultado.setError(false);
                resultado.setMensaje("Registro exitoso");
            } else {
                resultado.setError(true);
                resultado.setMensaje("No se pudo registrar el proyecto");
            }
        } catch (SQLException ex) {
            System.err.println("Error al insertar el proyecto: "+ex.getMessage());
            resultado.setError(true);
            resultado.setMensaje("Error: Se ha perdido la conexión con la base de datos");
        }
        return resultado;
    }

    public static ResultadoSQL actualizar(Proyecto proyecto) {
        ResultadoSQL resultado = new ResultadoSQL();
        String llamada = "{CALL actualizar_proyecto(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        try (Connection conexion = ConexionBD.abrirConexion();
             CallableStatement sentencia = conexion.prepareCall(llamada)) {
            sentencia.setInt(1, proyecto.getIdProyecto());
            sentencia.setString(2, proyecto.getNombre());
            sentencia.setString(3, proyecto.getObjetivoGeneral());
            sentencia.setString(4, proyecto.getMetodologia());
            sentencia.setInt(5, proyecto.getNumeroMaximoParticipantes());
            sentencia.setString(6, proyecto.getFechaInicio());
            sentencia.setString(7, proyecto.getFechaFin());
            sentencia.setInt(8, proyecto.getIdOrganizacionVinculada());
            sentencia.setInt(9, proyecto.getIdResponsable());
            sentencia.executeUpdate();
            if (sentencia.getUpdateCount() == 1) {
                resultado.setError(false);
                resultado.setMensaje("Cambios guardados");
            } else {
                resultado.setError(true);
                resultado.setMensaje("No se pudo actualizar el proyecto");
            }
        } catch (SQLException sqlex) {
            System.err.println("Error al actualizar el proyecto: "+sqlex.getMessage());
            resultado.setError(true);
            resultado.setMensaje("Error: Se ha perdido la conexión con la base de datos");
        }
        return resultado;
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