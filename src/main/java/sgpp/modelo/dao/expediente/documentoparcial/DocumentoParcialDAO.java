/* Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 15-06-2025
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase DAO para el manejo de documentos parciales en la base de datos
 */

package sgpp.modelo.dao.expediente.documentoparcial;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.EstadoDocumento;
import sgpp.modelo.beans.expediente.documentoparcial.DocumentoParcial;
import sgpp.modelo.beans.expediente.documentoparcial.TipoDocumentoParcial;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class DocumentoParcialDAO {

    /**
     * Sube un nuevo documento parcial a la base de datos.
     *
     * @param documentoParcial           Objeto DocumentoParcial con los datos
     * @param idEntregaDocumentoParcial ID de entrega del documento parcial
     * @param idEstudiante              ID del estudiante
     * @param idPeriodo                 ID del período
     * @return true si la inserción fue exitosa, false en caso contrario
     * @throws SQLException Si ocurre un error en la inserción
     */
    public static boolean subirDocumentoParcial(sgpp.modelo.beans.expediente.documentoparcial.DocumentoParcial documentoParcial, int idEntregaDocumentoParcial, int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        boolean exito = false;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "INSERT INTO documento_parcial (fecha_entrega, tipo, estado, documento, ID_Entrega_Doc_Parcial) VALUES (?, ?, ?, ?, ?)";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setString(1, UtilidadFormatoDeDatos.localDateTimeToString(documentoParcial.getFechaEntrega()));
                sentencia.setString(2, documentoParcial.getTipo().name());
                sentencia.setString(3, documentoParcial.getEstado().name());
                sentencia.setBytes(4, documentoParcial.getDocumento());
                sentencia.setInt(5, idEntregaDocumentoParcial);

                int filasAfectadas = sentencia.executeUpdate();
                exito = filasAfectadas > 0;
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }

        return exito;
    }

    /**
     * Obtiene los documentos parciales por ID de entrega.
     *
     * @param idEntregaDocumentoParcial ID de entrega del documento parcial
     * @return Lista de documentos parciales
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static List<DocumentoParcial> obtenerDocumentosParciales(int idEntregaDocumentoParcial) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        List<DocumentoParcial> documentosParciales = new ArrayList<>();

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT * FROM documento_parcial WHERE ID_Entrega_Doc_Parcial = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocumentoParcial);

                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    DocumentoParcial documentoParcial = new DocumentoParcial();
                    documentoParcial.setIdDocumento(resultado.getInt("ID_Doc_Parcial"));
                    documentoParcial.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoParcial.setTipo(TipoDocumentoParcial.valueOf(resultado.getString("tipo")));
                    documentoParcial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoParcial.setDocumento(resultado.getBytes("documento"));
                    documentoParcial.setIdEntregaDocumento(resultado.getInt("ID_Entrega_Doc_Parcial"));

                    documentosParciales.add(documentoParcial);
                }
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return documentosParciales;
    }

    /**
     * Verifica si existe un documento parcial por ID de entrega.
     *
     * @param idEntregaDocumentoParcial ID de entrega del documento parcial
     * @param idPeriodo
     * @return true si existe al menos un documento, false en caso contrario
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static boolean existeDocumentoParcial(int idEntregaDocumentoParcial, int idPeriodo) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        boolean existe = false;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT COUNT(*) FROM documento_parcial WHERE ID_Entrega_Doc_Parcial = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocumentoParcial);

                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    existe = resultado.getInt(1) > 0;
                }
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }
        return existe;
    }

    /**
     * Actualiza el estado de un documento parcial.
     *
     * @param idDocumentoParcial ID del documento parcial
     * @param nuevoEstado       Nuevo estado del documento
     * @return true si la actualización fue exitosa, false en caso contrario
     * @throws SQLException Si ocurre un error en la actualización
     */
    public static boolean actualizarEstadoDocumentoParcial(int idDocumentoParcial, EstadoDocumento nuevoEstado) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        boolean exito = false;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "UPDATE documento_parcial SET estado = ? WHERE ID_Doc_Parcial = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setString(1, nuevoEstado.name());
                sentencia.setInt(2, idDocumentoParcial);

                int filasAfectadas = sentencia.executeUpdate();
                exito = filasAfectadas > 0;
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }

        return exito;
    }


    /**
     * Obtiene una lista de documentos parciales por ID de entrega.
     *
     * @param idEntregaDocParcial ID de entrega del documento parcial
     * @return Lista de documentos parciales
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static List<DocumentoParcial> obtenerDocumentosParcialesPorExpediente(int idEntregaDocParcial) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        List<DocumentoParcial> documentosParciales = new ArrayList<>();

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT * FROM documento_parcial WHERE id_entrega_doc_parcial = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocParcial);

                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    DocumentoParcial documentoParcial = new DocumentoParcial();
                    documentoParcial.setIdDocumento(resultado.getInt("id_doc_parcial"));
                    documentoParcial.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoParcial.setTipo(TipoDocumentoParcial.valueOf(resultado.getString("tipo")));
                    documentoParcial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoParcial.setDocumento(resultado.getBytes("documento"));
                    documentoParcial.setIdEntregaDocumento(resultado.getInt("id_entrega_doc_parcial"));
                    documentosParciales.add(documentoParcial);
                }
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return documentosParciales;
    }

    public static DocumentoParcial obtenerDocumentoParcialPorTipo(int idEntregaDocParcial, TipoDocumentoParcial tipo) throws SQLException {
        DocumentoParcial documentoParcial = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM documento_parcial WHERE id_entrega_doc_parcial = ? AND tipo = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocParcial);
                sentencia.setString(2, tipo.name());
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    documentoParcial = new DocumentoParcial();
                    documentoParcial.setIdDocumento(resultado.getInt("id_doc_parcial"));
                    documentoParcial.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoParcial.setTipo(TipoDocumentoParcial.valueOf(resultado.getString("tipo")));
                    documentoParcial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoParcial.setDocumento(resultado.getBytes("documento"));
                    documentoParcial.setIdEntregaDocumento(resultado.getInt("id_entrega_doc_parcial"));
                }
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        }
        return documentoParcial;
    }

    /**
     * Obtiene una lista de documentos parciales por ID de periodo.
     *
     * @param idPeriodo ID del periodo
     * @return Lista de documentos parciales
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static List<DocumentoParcial> obtenerDocumentosParcialesPorPeriodo(int idPeriodo) throws SQLException {
        List<DocumentoParcial> documentosParciales = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        String consulta = "SELECT dp.id_doc_parcial, dp.fecha_entrega, dp.tipo, dp.estado, " +
                "dp.documento, dp.id_entrega_doc_parcial " +
                "FROM documento_parcial dp " +
                "INNER JOIN entrega_doc_parcial edp ON dp.id_entrega_doc_parcial = edp.id_entrega_doc_parcial " +
                "WHERE edp.id_periodo = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            sentencia.setInt(1, idPeriodo);
            resultado = sentencia.executeQuery();

            while (resultado.next()) {
                DocumentoParcial documentoParcial = new DocumentoParcial();

                documentoParcial.setIdDocumento(resultado.getInt("id_doc_parcial"));

                Timestamp fechaEntrega = resultado.getTimestamp("fecha_entrega");
                if (fechaEntrega != null) {
                    documentoParcial.setFechaEntrega(fechaEntrega.toLocalDateTime());
                }

                String tipoStr = resultado.getString("tipo");
                if (tipoStr != null) {
                    documentoParcial.setTipo(TipoDocumentoParcial.valueOf(tipoStr));
                }

                String estadoStr = resultado.getString("estado");
                if (estadoStr != null) {
                    documentoParcial.setEstado(EstadoDocumento.valueOf(estadoStr));
                }

                byte[] documento = resultado.getBytes("documento");
                if (documento != null) {
                    documentoParcial.setDocumento(documento);
                }

                documentoParcial.setIdEntregaDocumento(resultado.getInt("id_entrega_doc_parcial"));

                documentosParciales.add(documentoParcial);
            }

        } catch (SQLException e) {
            throw new SQLException("Error al obtener documentos parciales por periodo: " + e.getMessage(), e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return documentosParciales;
    }

    /**
     * Actualiza el estado de un documento parcial.
     *
     * @param documentoParcial Objeto DocumentoParcial con el nuevo estado
     * @throws SQLException Si ocurre un error en la actualización
     */
    public static void actualizarDocumentoParcial(DocumentoParcial documentoParcial) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "UPDATE documento_parcial SET estado = ? WHERE id_doc_parcial = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            // Establecer parámetros
            sentencia.setString(1, documentoParcial.getEstado().toString());
            sentencia.setInt(2, documentoParcial.getIdDocumento());

            int filasAfectadas = sentencia.executeUpdate();

            if (filasAfectadas == 0) {
                throw new SQLException("No se encontró el documento parcial con ID: " +
                        documentoParcial.getIdDocumento());
            }

        } catch (SQLException e) {
            throw new SQLException("Error al actualizar el estado del documento parcial: " + e.getMessage(), e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }
    }
}