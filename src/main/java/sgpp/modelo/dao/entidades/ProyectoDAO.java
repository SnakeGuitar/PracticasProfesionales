/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 14-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 17-06-2025
 * Descripción: Clase DAO para la entidad proyecto
 */

/*
 * Estado: En progreso
 * Modificaciones: Agregado metodo para recuperar un proyecto con preferencia
 */

package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.dao.ResultadoSQL;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
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
            throw new SQLException("Errro: Se ha perdido la conexion a con la Base de Datos");
        }
        return proyectos;
    }

    public static Proyecto obtenerPorId(int idProyecto) throws SQLException {
        Proyecto proyecto = null;
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        String consulta = "SELECT p.ID_Proyecto, p.nombre, p.objetivo_general, p.metodologia, " +
                "p.max_participantes, p.fecha_inicio, p.fecha_fin, p.ID_Org_Vinculada, p.ID_Responsable, " +
                "ov.nombre AS nombre_ov, rt.nombre AS nombre_responsable " +
                "FROM proyecto p " +
                "JOIN organizacion_vinculada ov ON p.ID_Org_Vinculada = ov.ID_Org_Vinculada " +
                "JOIN responsable_tecnico rt ON p.ID_Responsable = rt.ID_Responsable " +
                "WHERE p.ID_Proyecto = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idProyecto);
                resultado = sentencia.executeQuery();

                if (resultado.next()) {
                    proyecto = convertirProyecto(resultado);
                } else {
                    throw new SQLException("No se encontró el proyecto con ID: " + idProyecto);
                }
            } else {
                throw new SQLException("Error: Se ha perdido la conexión con la Base de Datos");
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener proyecto por ID: " + e.getMessage());
            throw e;
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return proyecto;
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

    public static List<Proyecto> obtenerProyectosDisponibles() throws SQLException {
        List<Proyecto> proyectosDisponibles = new ArrayList<>();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "{CALL consultar_proyectos_disponibles}";
            CallableStatement llamada = conexion.prepareCall(consulta);
            llamada.execute();
            ResultSet resultado = llamada.getResultSet();
            while (resultado.next()) {
                Proyecto proyecto = new Proyecto();
                proyecto.setIdProyecto(resultado.getInt("ID_proyecto"));
                proyecto.setNombre(resultado.getString("nombre"));
                proyecto.setNumeroMaximoParticipantes(resultado.getInt("max_participantes"));
                proyecto.setLugaresDisponibles(resultado.getInt("lugares_disponibles"));
                proyectosDisponibles.add(proyecto);
            }
            ConexionBD.cerrarConexion(conexion, llamada, resultado);
        } else {
            throw new SQLException("Se ha perdido la conexion con la Base de Datos");
        }
        return proyectosDisponibles;
    }

    public static List<Proyecto> nombreProyectos(int[] idsProyectos) throws SQLException {
        List<Proyecto> proyectos = new ArrayList<>();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                String consulta = "SELECT ID_Proyecto, nombre FROM Proyecto WHERE ID_Proyecto = ?";
                for (int idProyecto : idsProyectos) {
                    sentencia = conexion.prepareStatement(consulta);
                    sentencia.setInt(1, idProyecto);
                    resultado = sentencia.executeQuery();
                    if (resultado.next()) {
                        Proyecto proyecto = new Proyecto();
                        proyecto.setIdProyecto(resultado.getInt("ID_Proyecto"));
                        proyecto.setNombre(resultado.getString("nombre"));
                        proyectos.add(proyecto);
                    }
                }
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la base de datos");
        }
        return proyectos;
    }

    public static ResultadoSQL asignarProyecto(int idProyecto, int idEstudiante) throws SQLException {
        ResultadoSQL resultadoAsignacion = new ResultadoSQL();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            CallableStatement llamada = null;
            try {
                String consulta = "{CALL asignar_proyecto(?, ?, ?)}";
                llamada = conexion.prepareCall(consulta);
                llamada.setInt(1, idProyecto);
                llamada.setInt(2, idEstudiante);
                llamada.registerOutParameter(3, Types.BOOLEAN);
                llamada.execute();
                boolean exito = llamada.getBoolean("exito");
                if (exito) {
                    resultadoAsignacion.setError(false);
                    resultadoAsignacion.setMensaje("Asignación realizada exitosamente");
                } else {
                    resultadoAsignacion.setError(true);
                    resultadoAsignacion.setMensaje("Error al asignar el proyecto");
                }
            } finally {
                ConexionBD.cerrarConexion(conexion, llamada);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la base de datos");
        }
        return resultadoAsignacion;
    }

    public static Proyecto obtenerPorAsociacionEstudiante(int idEstudiante) throws SQLException {
        Proyecto proyecto = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta =
                    "SELECT p.ID_Proyecto, p.nombre, p.objetivo_general, p.ID_Org_Vinculada FROM Proyecto p " +
                    "JOIN estudiante e on e.ID_Proyecto = p.ID_Proyecto WHERE ID_Estudiante = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEstudiante);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    proyecto = new Proyecto();
                    proyecto.setIdProyecto(resultado.getInt("ID_Proyecto"));
                    proyecto.setNombre(resultado.getString("nombre"));
                    proyecto.setObjetivoGeneral(resultado.getString("objetivo_general"));
                    proyecto.setIdOrganizacionVinculada(resultado.getInt("ID_Org_Vinculada"));
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al obtener el proyecto "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion con la Base de Datos");
        }
        return proyecto;
    }
}