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
import sgpp.modelo.beans.expediente.documentoinicial.DocumentoInicial;
import sgpp.modelo.beans.expediente.documentoinicial.TipoDocumentoInicial;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
     * @param idEstudiante ID del estudiante
     * @param idPeriodo    ID del período
     * @return Lista de documentos finales
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static List<DocumentoFinal> obtenerDocumentosFinalesPorExpediente(int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        List<DocumentoFinal> documentosFinales = new ArrayList<>();

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT * FROM documento_final WHERE id_estudiante = ? AND id_periodo = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEstudiante);
                sentencia.setInt(2, idPeriodo);

                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    DocumentoFinal documentoFinal = new DocumentoFinal();
                    documentoFinal.setIdDocumento(resultado.getInt("id_documento_final"));
                    documentoFinal.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoFinal.setTipo(TipoDocumentoFinal.valueOf(resultado.getString("tipo")));
                    documentoFinal.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoFinal.setDocumento(resultado.getBytes("documento"));
                    documentoFinal.setIdEntregaDocumento(resultado.getInt("id_entrega_documento_final"));
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
     * Verifica si existe un documento final para un estudiante en un período específico.
     *
     * @param idEstudiante ID del estudiante
     * @param idPeriodo    ID del período
     * @return true si existe al menos un documento, false en caso contrario
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static boolean existeDocumentoFinal(int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        boolean existe = false;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT COUNT(*) FROM documento_final WHERE id_estudiante = ? AND id_periodo = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEstudiante);
                sentencia.setInt(2, idPeriodo);

                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    existe = resultado.getInt(1) > 0;
                }
            } else {
                throw new SQLException("No se pudo establecer la conexión a la base de datos.");
            }
        } finally {
            Utilidad.cerrarRecursosSQL(conexion, sentencia, resultado);
        }
        return existe;
    }

    /**
     * Obtiene los documentos finales por ID de entrega.
     *
     * @param idEntregaDocumentoFinal ID de entrega del documento final
     * @return Lista de documentos finales
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static List<DocumentoFinal> obtenerDocumentosFinales(int idEntregaDocumentoFinal) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        List<DocumentoFinal> documentosFinales = new ArrayList<>();

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT * FROM documento_final WHERE id_entrega_documento_final = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocumentoFinal);

                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    DocumentoFinal documentoFinal = new DocumentoFinal();
                    documentoFinal.setIdDocumento(resultado.getInt("id_documento_final"));
                    documentoFinal.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoFinal.setTipo(TipoDocumentoFinal.valueOf(resultado.getString("tipo")));
                    documentoFinal.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoFinal.setDocumento(resultado.getBytes("documento"));
                    documentoFinal.setIdEntregaDocumento(resultado.getInt("id_entrega_documento_final"));
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
     * Actualiza el estado de un documento final.
     *
     * @param idDocumentoFinal ID del documento final
     * @param nuevoEstado      Nuevo estado del documento
     * @return true si la actualización fue exitosa, false en caso contrario
     * @throws SQLException Si ocurre un error en la actualización
     */
    public static boolean actualizarEstadoDocumentoFinal(int idDocumentoFinal, EstadoDocumento nuevoEstado) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        boolean exito = false;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "UPDATE documento_final SET estado = ? WHERE id_documento_final = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setString(1, nuevoEstado.name());
                sentencia.setInt(2, idDocumentoFinal);

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
     * Guarda o actualiza un documento final específico por tipo.
     *
     * @param pdfDocumento            Documento PDF en bytes
     * @param idEntregaDocumentoFinal ID de entrega del documento final
     * @param tipoDocumento           Tipo de documento final
     * @throws SQLException Si ocurre un error al actualizar el registro
     */
    public static void guardarDocumentoFinal(byte[] pdfDocumento, int idEntregaDocumentoFinal, TipoDocumentoFinal tipoDocumento) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "UPDATE documento_final " +
                        "SET documento = ?, estado = 'Entregado', fecha_entrega = NOW() " +
                        "WHERE tipo = ? AND id_entrega_documento_final = ?";

                sentencia = conexion.prepareStatement(consulta);
                sentencia.setBytes(1, pdfDocumento);
                sentencia.setString(2, tipoDocumento.name());
                sentencia.setInt(3, idEntregaDocumentoFinal);

                int filasAfectadas = sentencia.executeUpdate();

                sentencia.close();
                conexion.close();

                if (filasAfectadas > 0) {
                    System.out.println("Documento final de tipo " + tipoDocumento.name() + " guardado correctamente en la base de datos.");
                } else {
                    throw new SQLException("No se encontró un documento tipo '" + tipoDocumento.name() + "' con id_entrega_documento_final = " + idEntregaDocumentoFinal);
                }

            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, null);
        }
    }

    /**
     * Obtiene un documento final específico por ID.
     *
     * @param idDocumentoFinal ID del documento final
     * @return DocumentoFinal o null si no se encuentra
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static DocumentoFinal obtenerDocumentoFinalPorId(int idDocumentoFinal) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        DocumentoFinal documentoFinal = null;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT * FROM documento_final WHERE id_documento_final = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idDocumentoFinal);

                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    documentoFinal = new DocumentoFinal();
                    documentoFinal.setIdDocumento(resultado.getInt("id_documento_final"));
                    documentoFinal.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoFinal.setTipo(TipoDocumentoFinal.valueOf(resultado.getString("tipo")));
                    documentoFinal.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoFinal.setDocumento(resultado.getBytes("documento"));
                    documentoFinal.setIdEntregaDocumento(resultado.getInt("id_entrega_documento_final"));
                }
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return documentoFinal;
    }

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
                    documentoFinal = new DocumentoFinal();
                    documentoFinal.setIdDocumento(resultado.getInt("id_doc_final"));
                    documentoFinal.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoFinal.setTipo(TipoDocumentoFinal.valueOf(resultado.getString("tipo")));
                    documentoFinal.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoFinal.setDocumento(resultado.getBytes("documento"));
                    documentoFinal.setIdEntregaDocumento(resultado.getInt("id_entrega_doc_final"));
                }
            } finally {
                Utilidad.cerrarRecursosSQL(conexion, sentencia, resultado);
            }
        }
        return documentoFinal;
    }


}
