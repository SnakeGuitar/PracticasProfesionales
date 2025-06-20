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
     * Guarda o actualiza un documento parcial específico por tipo.
     *
     * @param pdfDocumento              Documento PDF en bytes
     * @param idEntregaDocumentoParcial ID de entrega del documento parcial
     * @param tipoDocumento            Tipo de documento parcial
     * @throws SQLException Si ocurre un error al actualizar el registro
     */
    public static void guardarDocumentoParcial(byte[] pdfDocumento, int idEntregaDocumentoParcial, TipoDocumentoParcial tipoDocumento) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;

        try {
            conexion = ConexionBD.abrirConexion();

            if (conexion != null) {
                String consulta = "UPDATE documento_parcial " +
                        "SET documento = ?, estado = 'Entregado', fecha_entrega = NOW() " +
                        "WHERE tipo = ? AND ID_Entrega_Doc_Parcial = ?";

                sentencia = conexion.prepareStatement(consulta);
                sentencia.setBytes(1, pdfDocumento);
                sentencia.setString(2, tipoDocumento.name());
                sentencia.setInt(3, idEntregaDocumentoParcial);

                int filasAfectadas = sentencia.executeUpdate();

                ConexionBD.cerrarConexion(conexion, sentencia, null);

                if (filasAfectadas > 0) {
                    System.out.println("Documento parcial de tipo " + tipoDocumento.name() + " guardado correctamente en la base de datos.");
                } else {
                    throw new SQLException("No se encontró un documento tipo '" + tipoDocumento.name() + "' con ID_Entrega_Doc_Parcial = " + idEntregaDocumentoParcial);
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
     * Obtiene un documento parcial específico por ID.
     *
     * @param idDocumentoParcial ID del documento parcial
     * @return DocumentoParcial o null si no se encuentra
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static DocumentoParcial obtenerDocumentoParcialPorId(int idDocumentoParcial) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        DocumentoParcial documentoParcial = null;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT * FROM documento_parcial WHERE ID_Doc_Parcial = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idDocumentoParcial);

                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    documentoParcial = new DocumentoParcial();
                    documentoParcial.setIdDocumento(resultado.getInt("ID_Doc_Parcial"));
                    documentoParcial.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoParcial.setTipo(TipoDocumentoParcial.valueOf(resultado.getString("tipo")));
                    documentoParcial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoParcial.setDocumento(resultado.getBytes("documento"));
                    documentoParcial.setIdEntregaDocumento(resultado.getInt("ID_Entrega_Doc_Parcial"));
                }
            } else {
                throw new SQLException();
            }
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        } finally {
            ConexionBD.cerrarConexion(conexion, sentencia, resultado);
        }

        return documentoParcial;
    }

    public static List<DocumentoParcial> obtenerDocumentosParcialesPorExpediente(int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        List<DocumentoParcial> documentosParciales = new ArrayList<>();

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "SELECT * FROM documento_parcial WHERE id_estudiante = ? AND id_periodo = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEstudiante);
                sentencia.setInt(2, idPeriodo);

                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    DocumentoParcial documentoParcial = new DocumentoParcial();
                    documentoParcial.setIdDocumento(resultado.getInt("id_documento_parcial"));
                    documentoParcial.setFechaEntrega(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_entrega")));
                    documentoParcial.setTipo(TipoDocumentoParcial.valueOf(resultado.getString("tipo")));
                    documentoParcial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoParcial.setDocumento(resultado.getBytes("documento"));
                    documentoParcial.setIdEntregaDocumento(resultado.getInt("id_entrega_documento_parcial"));
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

}