/* Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 02-07-2025
 * Descripción: Clase DAO para el manejo de la tabla 'documento_inicial'.
 *              Permite actualizar documentos PDF generados desde el sistema,
 *              específicamente para el tipo 'OficioAsignacion'.
 */

/*
 * Estado: Completo
 * Modificaciones:
 * - Eliminación de métodos obsoletos.
 */

package sgpp.modelo.dao.expediente.documentoinicial;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.EstadoDocumento;
import sgpp.modelo.beans.expediente.documentoinicial.DocumentoInicial;
import sgpp.modelo.beans.expediente.documentoinicial.TipoDocumentoInicial;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class DocumentoInicialDAO {
    /**
     * Obtiene los documentos iniciales por expediente de estudiante y período.
     * @return Lista de documentos iniciales
     * @throws SQLException Si ocurre un error en la consulta
     */

    public static List<DocumentoInicial> obtenerDocumentosInicialesPorExpediente(int idEntregaDocInicial) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        List<DocumentoInicial> documentosIniciales = new ArrayList<>();

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT * FROM documento_inicial WHERE id_entrega_doc_inicial = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocInicial);

                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    DocumentoInicial documentoInicial = new DocumentoInicial();
                    documentoInicial.setIdDocumento(resultado.getInt("id_doc_inicial"));
                    documentoInicial.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoInicial.setTipo(TipoDocumentoInicial.valueOf(resultado.getString("tipo")));
                    documentoInicial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoInicial.setDocumento(resultado.getBytes("documento"));
                    documentoInicial.setIdEntregaDocumento(resultado.getInt("id_entrega_doc_inicial"));
                    documentosIniciales.add(documentoInicial);
                }
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return documentosIniciales;
    }

    /**
     * Sube un nuevo documento inicial a la base de datos.
     *
     * @param documentoInicial           Objeto DocumentoInicial con los datos
     * @param idEntregaDocumentoInicial ID de entrega del documento
     * @param idEstudiante              ID del estudiante
     * @param idPeriodo                 ID del período
     * @return true si la inserción fue exitosa, false en caso contrario
     * @throws SQLException Si ocurre un error en la inserción
     */
    public static boolean subirDocumentoInicial(DocumentoInicial documentoInicial, int idEntregaDocumentoInicial, int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        boolean exito = false;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "INSERT INTO documento_inicial (fecha_entrega, tipo, estado, documento, id_entrega_doc_inicial) VALUES (?, ?, ?, ?, ?)";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setString(1, UtilidadFormatoDeDatos.localDateTimeToString(documentoInicial.getFechaEntrega()));
                sentencia.setString(2, documentoInicial.getTipo().name());
                sentencia.setString(3, documentoInicial.getEstado().name());
                sentencia.setBytes(4, documentoInicial.getDocumento());
                sentencia.setInt(5, idEntregaDocumentoInicial);

                int filasAfectadas = sentencia.executeUpdate();
                exito = filasAfectadas > 0;
            } else {
                throw new SQLException("No se pudo establecer la conexión a la base de datos.");
            }
        } finally {
            if (sentencia != null) {
                sentencia.close();
            }
            if (conexionBD != null) {
                conexionBD.close();
            }
        }
        return exito;
    }

    /**
     * Obtiene un documento inicial por su ID de entrega y tipo.
     *
     * @param idEntregaDocInicial ID de entrega del documento inicial
     * @param tipo                Tipo de documento inicial
     * @return DocumentoInicial si se encuentra, null en caso contrario
     * @throws SQLException Si ocurre un error al acceder a la base de datos
     */
    public static DocumentoInicial obtenerDocumentoInicialPorTipo(int idEntregaDocInicial, TipoDocumentoInicial tipo) throws SQLException {
        DocumentoInicial documentoInicial = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM documento_inicial WHERE id_entrega_doc_inicial = ? AND tipo = ?";
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocInicial);
                sentencia.setString(2, tipo.name());
                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    documentoInicial = new DocumentoInicial();
                    documentoInicial.setIdDocumento(resultado.getInt("id_doc_inicial"));
                    documentoInicial.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoInicial.setTipo(TipoDocumentoInicial.valueOf(resultado.getString("tipo")));
                    documentoInicial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoInicial.setDocumento(resultado.getBytes("documento"));
                    documentoInicial.setIdEntregaDocumento(resultado.getInt("id_entrega_doc_inicial"));
                }
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        }
        return documentoInicial;
    }

    /**
     * Obtiene una lista de documentos iniciales asociados a un período específico.
     *
     * @param idPeriodo ID del período para filtrar los documentos
     * @return Lista de DocumentoInicial
     * @throws SQLException Si ocurre un error al acceder a la base de datos
     */
    public static List<DocumentoInicial> obtenerDocumentosInicialesPorPeriodo(int idPeriodo) throws SQLException {
        List<DocumentoInicial> documentosIniciales = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        String consulta = "SELECT di.id_doc_inicial, di.fecha_entrega, di.tipo, di.estado, " +
                "di.documento, di.id_entrega_doc_inicial " +
                "FROM documento_inicial di " +
                "INNER JOIN entrega_doc_inicial edi ON di.id_entrega_doc_inicial = edi.id_entrega_doc_inicial " +
                "WHERE edi.id_periodo = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);
            sentencia.setInt(1, idPeriodo);
            resultado = sentencia.executeQuery();

            while (resultado.next()) {
                DocumentoInicial documentoInicial = new DocumentoInicial();

                documentoInicial.setIdDocumento(resultado.getInt("id_doc_inicial"));

                Timestamp fechaEntrega = resultado.getTimestamp("fecha_entrega");
                if (fechaEntrega != null) {
                    documentoInicial.setFechaEntrega(fechaEntrega.toLocalDateTime());
                }

                String tipoStr = resultado.getString("tipo");
                if (tipoStr != null) {
                    documentoInicial.setTipo(TipoDocumentoInicial.valueOf(tipoStr));
                }

                String estadoStr = resultado.getString("estado");
                if (estadoStr != null) {
                    documentoInicial.setEstado(EstadoDocumento.valueOf(estadoStr));
                }

                byte[] documento = resultado.getBytes("documento");
                if (documento != null) {
                    documentoInicial.setDocumento(documento);
                }

                documentoInicial.setIdEntregaDocumento(resultado.getInt("id_entrega_doc_inicial"));

                documentosIniciales.add(documentoInicial);
            }

        } catch (SQLException e) {
            throw new SQLException("Error al obtener documentos iniciales por periodo: " + e.getMessage(), e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return documentosIniciales;
    }

    /**
     * Actualiza el estado de un documento inicial en la base de datos.
     *
     * @param documentoInicial Objeto DocumentoInicial con el nuevo estado
     * @throws SQLException Si ocurre un error al actualizar el estado
     */
    public static void actualizarDocumentoInicial(DocumentoInicial documentoInicial) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;

        String consulta = "UPDATE documento_inicial SET estado = ? WHERE id_doc_inicial = ?";

        try {
            conexion = ConexionBD.abrirConexion();
            sentencia = conexion.prepareStatement(consulta);

            // Establecer parámetros
            sentencia.setString(1, documentoInicial.getEstado().toString());
            sentencia.setInt(2, documentoInicial.getIdDocumento());

            int filasAfectadas = sentencia.executeUpdate();

            if (filasAfectadas == 0) {
                throw new SQLException("No se encontró el documento inicial con ID: " +
                        documentoInicial.getIdDocumento());
            }

        } catch (SQLException e) {
            throw new SQLException("Error al actualizar el estado del documento inicial: " + e.getMessage(), e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }
    }

}