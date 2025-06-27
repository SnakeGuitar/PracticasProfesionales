/* Autor original: Luis Donaldo
 * Último autor: Seth Marquez
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase DAO para el manejo de la tabla 'documento_inicial'.
 *              Permite actualizar documentos PDF generados desde el sistema,
 *              específicamente para el tipo 'OficioAsignacion'.
 */

/*
 * Estado: En progreso
 * Modificaciones:
 * - Implementación del método guardarOficioAsignacion()
 * - Uso de conexión JDBC con cierre manual de recursos
 * - Fusión de definiciones duplicadas de la clase
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
     * Guarda el PDF generado para un documento tipo 'OficioAsignacion' y actualiza su estado y fecha de entrega.
     *
     * @param pdfDocumento Documento PDF en bytes.
     * @param idEntrega    ID_Entrega_Doc_Inicial correspondiente al alumno.
     * @throws SQLException Si ocurre un error al actualizar el registro.
     */
    public static void guardarOficioAsignacion(byte[] pdfDocumento, int idEntrega) throws SQLException {
        Connection conexion = null;
        PreparedStatement sentencia = null;

        try {
            conexion = ConexionBD.abrirConexion();
            if (conexion != null) {
                String consulta = "UPDATE documento_inicial " +
                        "SET documento = ?, estado = 'Entregado', fecha_entrega = NOW() " +
                        "WHERE tipo = 'OficioAsignacion' AND ID_Entrega_Doc_Inicial = ?";

                sentencia = conexion.prepareStatement(consulta);
                sentencia.setBytes(1, pdfDocumento);
                sentencia.setInt(2, idEntrega);

                int filasAfectadas = sentencia.executeUpdate();

                sentencia.close();
                conexion.close();

                if (filasAfectadas > 0) {
                    System.out.println("Documento de OficioAsignacion guardado correctamente en la base de datos.");
                } else {
                    throw new SQLException("No se encontró un documento tipo 'OficioAsignacion' con ID_Entrega_Doc_Inicial = " + idEntrega);
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
     * Verifica si existe un documento inicial para un estudiante en un período específico.
     *
     * @param idEstudiante ID del estudiante
     * @param idPeriodo    ID del período
     * @return true si existe al menos un documento, false en caso contrario
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static boolean existeDocumentoInicial(int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        boolean existe = false;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT COUNT(*) FROM documento_inicial WHERE id_estudiante = ? AND id_periodo = ?";
                sentencia = conexionBD.prepareStatement(consulta);
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
            ConexionBD.cerrarConexion(conexionBD, sentencia, resultado);
        }
        return existe;
    }

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