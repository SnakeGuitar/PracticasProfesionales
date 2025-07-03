/* Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 15-06-2025
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase DAO para el manejo de documentos finales en la base de datos
 */

package sgpp.modelo.dao.expediente.documentofinal;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.EstadoDocumento;
import sgpp.modelo.beans.expediente.documentofinal.DocumentoFinal;
import sgpp.modelo.beans.expediente.documentofinal.TipoDocumentoFinal;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentoFinalDAO {

    /**
     * Sube un nuevo documento final a la base de datos.
     *
     * @param documentoFinal           Objeto DocumentoFinal con los datos
     * @param idEntregaDocumentoFinal  ID de entrega del documento final
     * @param idEstudiante            ID del estudiante
     * @param idPeriodo               ID del período
     * @return true si la inserción fue exitosa, false en caso contrario
     * @throws SQLException Si ocurre un error en la inserción
     */
    public static boolean subirDocumentoFinal(DocumentoFinal documentoFinal, int idEntregaDocumentoFinal,
                                              int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        boolean exito = false;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "INSERT INTO documento_final (fecha_entrega, tipo, estado, documento, " +
                        "id_entrega_documento_final, id_estudiante, id_periodo) VALUES (?, ?, ?, ?, ?, ?, ?)";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setString(1, UtilidadFormatoDeDatos.localDateTimeToString(documentoFinal.getFechaEntrega()));
                sentencia.setString(2, documentoFinal.getTipo().name());
                sentencia.setString(3, documentoFinal.getEstado().name());
                sentencia.setBytes(4, documentoFinal.getDocumento());
                sentencia.setInt(5, idEntregaDocumentoFinal);
                sentencia.setInt(6, idEstudiante);
                sentencia.setInt(7, idPeriodo);

                int filasAfectadas = sentencia.executeUpdate();
                exito = filasAfectadas > 0;
            } else {
                throw new SQLException("No se pudo establecer la conexión a la base de datos.");
            }
        } finally {
            if (sentencia != null) {
                sentencia.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
        return exito;
    }

    /**
     * Obtiene los documentos finales por expediente de estudiante y período.
     *
     * @return Lista de documentos finales
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static List<DocumentoFinal> obtenerDocumentosFinalesPorExpediente(int idEntregaDocFinal) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        List<DocumentoFinal> documentosFinales = new ArrayList<>();

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT * FROM documento_final WHERE id_entrega_doc_final = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocFinal);

                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    DocumentoFinal documentoFinal = convertirDocFinal(resultado);
                    documentosFinales.add(documentoFinal);
                }
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return documentosFinales;
    }

    /**
     * Convierte un ResultSet a un objeto DocumentoFinal.
     *
     * @param resultado ResultSet con los datos del documento final
     * @return Objeto DocumentoFinal
     * @throws SQLException Si ocurre un error al leer el ResultSet
     */
    private static DocumentoFinal convertirDocFinal(ResultSet resultado) throws SQLException {
        DocumentoFinal documento = new DocumentoFinal();
        documento.setIdDocumento(resultado.getInt("id_doc_final"));
        documento.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
        documento.setTipo(TipoDocumentoFinal.valueOf(resultado.getString("tipo")));
        documento.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
        documento.setDocumento(resultado.getBytes("documento"));
        documento.setIdEntregaDocumento(resultado.getInt("id_entrega_doc_final"));
        return documento;
    }

    /**
     * Obtiene un documento final por su ID de entrega y tipo.
     *
     * @param idEntregaDocFinal ID de entrega del documento final
     * @param tipo              Tipo de documento final
     * @return DocumentoFinal si se encuentra, null en caso contrario
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static DocumentoFinal obtenerDocumentoFinalPorTipo(int idEntregaDocFinal, TipoDocumentoFinal tipo) throws SQLException {
        DocumentoFinal documentoFinal = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM documento_final WHERE id_entrega_doc_final = ? AND tipo = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocFinal);
                sentencia.setString(2, tipo.name());
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    documentoFinal = convertirDocFinal(resultado);
                }
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        }
        return documentoFinal;
    }

    /**
     * Obtiene una lista de documentos finales por el ID del período.
     *
     * @param idPeriodo ID del período
     * @return Lista de DocumentoFinal
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static List<DocumentoFinal> obtenerDocumentosFinalesPorPeriodo(int idPeriodo) throws SQLException {
        List<DocumentoFinal> documentosFinales = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        String consulta = "SELECT df.id_doc_final, df.fecha_entrega, df.tipo, df.estado, " +
                "df.documento, df.id_entrega_doc_final " +
                "FROM documento_final df " +
                "INNER JOIN entrega_doc_final edf ON df.id_entrega_doc_final = edf.id_entrega_doc_final " +
                "WHERE edf.id_periodo = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            sentencia.setInt(1, idPeriodo);
            resultado = sentencia.executeQuery();

            while (resultado.next()) {
                DocumentoFinal documentoFinal = new DocumentoFinal();

                documentoFinal.setIdDocumento(resultado.getInt("id_documento_final"));

                Timestamp fechaEntrega = resultado.getTimestamp("fecha_entrega");
                if (fechaEntrega != null) {
                    documentoFinal.setFechaEntrega(fechaEntrega.toLocalDateTime());
                }

                String tipoStr = resultado.getString("tipo");
                if (tipoStr != null) {
                    documentoFinal.setTipo(TipoDocumentoFinal.valueOf(tipoStr));
                }

                String estadoStr = resultado.getString("estado");
                if (estadoStr != null) {
                    documentoFinal.setEstado(EstadoDocumento.valueOf(estadoStr));
                }

                byte[] documento = resultado.getBytes("documento");
                if (documento != null) {
                    documentoFinal.setDocumento(documento);
                }

                documentoFinal.setIdEntregaDocumento(resultado.getInt("id_entrega_documento_final"));

                documentosFinales.add(documentoFinal);
            }

        } catch (SQLException e) {
            throw new SQLException("Error al obtener documentos finales por periodo: " + e.getMessage(), e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return documentosFinales;
    }

    /**
     * Actualiza el estado de un documento final en la base de datos.
     *
     * @param documentoFinal Objeto DocumentoFinal con el nuevo estado
     * @throws SQLException Si ocurre un error en la actualización
     */
    public static void actualizarDocumentoFinal(DocumentoFinal documentoFinal) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "UPDATE documento_final SET estado = ? WHERE id_doc_final = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            // Establecer parámetros
            sentencia.setString(1, documentoFinal.getEstado().toString());
            sentencia.setInt(2, documentoFinal.getIdDocumento());

            int filasAfectadas = sentencia.executeUpdate();

            if (filasAfectadas == 0) {
                throw new SQLException("No se encontró el documento final con ID: " +
                        documentoFinal.getIdDocumento());
            }

        } catch (SQLException e) {
            throw new SQLException("Error al actualizar el estado del documento final: " + e.getMessage(), e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }
    }
}
