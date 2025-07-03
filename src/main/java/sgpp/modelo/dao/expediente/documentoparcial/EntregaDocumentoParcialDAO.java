/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 02-07-2025
 * Descripción: Clase DAO para manejar las entregas de documentos parciales
 */

package sgpp.modelo.dao.expediente.documentoparcial;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.documentoparcial.EntregaDocumentoParcial;
import sgpp.modelo.dao.ResultadoSQL;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class EntregaDocumentoParcialDAO {
    /**
     * Obtiene una entrega de documento parcial específica por su ID.
     *
     * @param idEntregaDocumentoParcial ID de la entrega de documento parcial
     * @return EntregaDocumentoParcial encontrada o null si no existe
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static EntregaDocumentoParcial obtenerEntregaDocumentoParcial(int idEntregaDocumentoParcial) throws SQLException {
        EntregaDocumentoParcial entregaDocumentoParcial = null;
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT * FROM entrega_doc_parcial WHERE ID_Entrega_Doc_Parcial = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocumentoParcial);
                resultado = sentencia.executeQuery();

                if (resultado.next()) {
                    entregaDocumentoParcial = convertirAEntrega(resultado);
                }
            } else {
                throw new SQLException("No se pudo establecer la conexión a la base de datos.");
            }
        } finally {
            if (resultado != null) {
                resultado.close();
            }
            if (sentencia != null) {
                sentencia.close();
            }
            if (conexionBD != null) {
                conexionBD.close();
            }
        }
        return entregaDocumentoParcial;
    }

    /**
     * Obtiene todas las entregas de documentos parciales disponibles para un estudiante en un período específico.
     * Solo retorna entregas que están dentro del período de apertura y límite.
     *
     * @param idEstudiante ID del estudiante
     * @param idPeriodo    ID del período
     * @return Lista de entregas disponibles ordenadas por fecha límite
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static EntregaDocumentoParcial obtenerEntregaDisponible(int idEstudiante, int idPeriodo) throws SQLException {
        EntregaDocumentoParcial entrega = null;
        Connection conexionBD = ConexionBD.abrirConexion();
        if (conexionBD != null) {
            String consulta = "SELECT * FROM entrega_doc_parcial WHERE ID_Estudiante = ? AND ID_Periodo = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idEstudiante);
                sentencia.setInt(2, idPeriodo);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    System.out.println("Entrega encontrada para el estudiante con ID: " + idEstudiante + " y periodo con ID: " + idPeriodo);
                    entrega = convertirAEntrega(resultado);
                }
            } catch (SQLException e) {
                throw new SQLException("Error al obtener la entrega de documento parcial: " + e.getMessage(), e);
            } finally {
                ConexionBD.cerrarConexion(conexionBD, sentencia, resultado);
            }
        } else {
            throw new SQLException("No se pudo establecer la conexión a la base de datos.");
        }
        return entrega;
    }


    /**
     * Obtiene todas las entregas de documentos parciales para un estudiante en un período específico.
     * @return Lista de entregas de documentos parciales
     * @throws SQLException Si ocurre un error en la consulta
     */
    private static EntregaDocumentoParcial convertirAEntrega(ResultSet resultado) throws SQLException {
        EntregaDocumentoParcial entrega = new EntregaDocumentoParcial();
        entrega.setIdEntregaDocumentoParcial(resultado.getInt("ID_Entrega_Doc_Parcial"));
        entrega.setFechaApertura(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_apertura")));
        entrega.setFechaLimite(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_limite")));
        entrega.setIdEstudiante(resultado.getInt("ID_Estudiante"));
        entrega.setIdPeriodo(resultado.getInt("ID_Periodo"));
        return entrega;
    }

    /**
     * Programa las entregas de documentos parciales para un período específico.
     *
     * @param candidata  EntregaDocumentoParcial con las fechas de apertura y límite
     * @param idPeriodo  ID del período al que se aplican las entregas
     * @return ResultadoSQL con el estado de la operación
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static ResultadoSQL programarEntregas(EntregaDocumentoParcial candidata, int idPeriodo) throws SQLException {
        ResultadoSQL resultadoOperacion = new ResultadoSQL();
        String fechaApertura = candidata.getFechaApertura().toString();
        String fechaLimite = candidata.getFechaLimite().toString();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "UPDATE entrega_doc_parcial SET fecha_apertura = ?, fecha_limite = ? WHERE ID_Periodo = ?";
            PreparedStatement sentencia = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setString(1, fechaApertura);
                sentencia.setString(2, fechaLimite);
                sentencia.setInt(3, idPeriodo);
                int filasAfectadas = sentencia.executeUpdate();
                if (filasAfectadas > 0) {
                    resultadoOperacion.setError(false);
                    resultadoOperacion.setMensaje("Entregas parciales del periodo programadas exitosamente");
                } else {
                    resultadoOperacion.setError(true);
                    resultadoOperacion.setMensaje("No se pudo configurar las entregas parciales del periodo");
                }
            } catch (SQLException sqlex) {
                System.out.println(sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion con la Base de Datos");
        }
        return resultadoOperacion;
    }

    /**
     * Obtiene todas las entregas de documentos parciales para un estudiante en un período específico.
     * @return Lista de entregas de documentos parciales
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static EntregaDocumentoParcial obtenerPrimeraEntregaPorPeriodo(int idPeriodo) throws SQLException {
        EntregaDocumentoParcial entrega = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM entrega_doc_parcial WHERE ID_Periodo = ? AND fecha_apertura IS NOT NULL ORDER BY fecha_apertura ASC";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idPeriodo);
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    entrega = convertirAEntrega(resultado);
                }
            } catch (SQLException sqlex) {
                System.out.println("Error al obtener la entrega parcial: "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la Base de Datos");
        }
        return entrega;
    }
}