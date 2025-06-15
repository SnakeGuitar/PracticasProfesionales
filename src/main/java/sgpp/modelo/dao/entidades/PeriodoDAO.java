/*
 * Autor original: Luis Donaldo
 * Último autor: Abel Yong
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025 00:38
 * Descripción: DAO para la entidad periodo
 */

/*
 * Estado: En progreso
 * Modificaciones: Agregado metodo obtenerPeriodoActual()
 */

package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.Periodo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PeriodoDAO {

    public static Periodo obtenerPeriodoActual() throws SQLException {
        Periodo periodo = null;
        Connection conexion = ConexionBD.abrirConexion();
        String consulta = "SELECT ID_Periodo, abreviatura, fecha_inicio, fecha_fin FROM periodo where NOW() BETWEEN fecha_inicio AND fecha_fin";
        PreparedStatement sentencia = conexion.prepareStatement(consulta);
        ResultSet resultado = sentencia.executeQuery();
        if (resultado.next()) {
            periodo = new Periodo();
            periodo.setIdPeriodo(resultado.getInt("ID_Periodo"));
            periodo.setAbreviatura(resultado.getString("abreviatura"));
            periodo.setFechaInicio(resultado.getString("fecha_inicio"));
            periodo.setFechaFin(resultado.getString("fecha_fin"));
        }
        return periodo;
    }
}
