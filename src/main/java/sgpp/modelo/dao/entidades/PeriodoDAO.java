/*
 * Autor original: Luis Donaldo
 * Último autor: Abel Yong
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 23-06-2025 00:38
 * Descripción: DAO para la entidad periodo
 */

/*
 * Estado: Terminado
 * Modificaciones: Agregado metodo recuperarPeriodoPorID
 */

package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Periodo;
import sgpp.utilidad.Utilidad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PeriodoDAO {

    public static Periodo obtenerPeriodoActual() throws SQLException {
        Periodo periodo = null;
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        String consulta = "SELECT ID_Periodo, abreviatura, fecha_inicio, fecha_fin FROM periodo WHERE NOW() BETWEEN fecha_inicio AND fecha_fin";
        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            resultado = sentencia.executeQuery();

            if (resultado.next()) {
                periodo = convertirPeriodo(resultado);
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }
        return periodo;
    }

    public static Periodo recuperarPeriodoPorId(int idPeriodo) throws SQLException {
        Periodo periodo = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT ID_Periodo, abreviatura, fecha_inicio, fecha_fin FROM periodo WHERE ID_Periodo = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idPeriodo);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    periodo = convertirPeriodo(resultado);
                }
            } catch (SQLException sqlex) {
                System.out.println("Errro al obtener el periodo "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion con la Base de Datos");
        }
        return periodo;
    }

    private static Periodo convertirPeriodo(ResultSet resultado) throws SQLException {
        Periodo periodo = new Periodo();
        periodo.setIdPeriodo(resultado.getInt("ID_Periodo"));
        periodo.setAbreviatura(resultado.getString("abreviatura"));
        periodo.setFechaInicio(resultado.getString("fecha_inicio"));
        periodo.setFechaFin(resultado.getString("fecha_fin"));
        return periodo;
    }
}
