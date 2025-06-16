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
    public static boolean subirDocumentoParcial(DocumentoParcial documentoParcial, int idEntregaDocumentoParcial, int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        boolean exito = false;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "INSERT INTO documento_parcial (fecha_entrega, tipo, estado, documento, ID_Entrega_Doc_Parcial) VALUES (?, ?, ?, ?, ?)";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setDate(1, new java.sql.Date(documentoParcial.getFechaEntrega().getTime()));
                sentencia.setString(2, documentoParcial.getTipo().name());
                sentencia.setString(3, documentoParcial.getEstado().name());
                sentencia.setBytes(4, documentoParcial.getDocumento());
                sentencia.setInt(5, idEntregaDocumentoParcial);

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
     * Obtiene los documentos parciales por ID de entrega.
     *
     * @param idEntregaDocumentoParcial ID de entrega del documento parcial
     * @return Lista de documentos parciales
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static List<DocumentoParcial> obtenerDocumentosParciales(int idEntregaDocumentoParcial) throws SQLException {
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        List<DocumentoParcial> documentosParciales = new ArrayList<>();

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT * FROM documento_parcial WHERE ID_Entrega_Doc_Parcial = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocumentoParcial);

                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    DocumentoParcial documentoParcial = new DocumentoParcial();
                    documentoParcial.setIdDocumentoParcial(resultado.getInt("ID_Doc_Parcial"));
                    documentoParcial.setFechaEntrega(resultado.getDate("fecha_entrega"));
                    documentoParcial.setTipo(TipoDocumentoParcial.valueOf(resultado.getString("tipo")));
                    documentoParcial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoParcial.setDocumento(resultado.getBytes("documento"));
                    documentoParcial.setIdEntregaDocumentoParcial(resultado.getInt("ID_Entrega_Doc_Parcial"));
                    documentosParciales.add(documentoParcial);
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
        return documentosParciales;
    }

    /**
     * Verifica si existe un documento parcial por ID de entrega.
     *
     * @param idEntregaDocumentoParcial ID de entrega del documento parcial
     * @return true si existe al menos un documento, false en caso contrario
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static boolean existeDocumentoParcial(int idEntregaDocumentoParcial) throws SQLException {
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        boolean existe = false;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT COUNT(*) FROM documento_parcial WHERE ID_Entrega_Doc_Parcial = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocumentoParcial);

                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    existe = resultado.getInt(1) > 0;
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
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        boolean exito = false;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "UPDATE documento_parcial SET estado = ? WHERE ID_Doc_Parcial = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setString(1, nuevoEstado.name());
                sentencia.setInt(2, idDocumentoParcial);

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
     * Guarda o actualiza un documento parcial específico por tipo.
     *
     * @param pdfDocumento              Documento PDF en bytes
     * @param idEntregaDocumentoParcial ID de entrega del documento parcial
     * @param tipoDocumento            Tipo de documento parcial
     * @throws SQLException Si ocurre un error al actualizar el registro
     */
    public static void guardarDocumentoParcial(byte[] pdfDocumento, int idEntregaDocumentoParcial, TipoDocumentoParcial tipoDocumento) throws SQLException {
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "UPDATE documento_parcial " +
                    "SET documento = ?, estado = 'Entregado', fecha_entrega = NOW() " +
                    "WHERE tipo = ? AND ID_Entrega_Doc_Parcial = ?";

            PreparedStatement sentencia = conexion.prepareStatement(consulta);
            sentencia.setBytes(1, pdfDocumento);
            sentencia.setString(2, tipoDocumento.name());
            sentencia.setInt(3, idEntregaDocumentoParcial);

            int filasAfectadas = sentencia.executeUpdate();

            sentencia.close();
            conexion.close();

            if (filasAfectadas > 0) {
                System.out.println("Documento parcial de tipo " + tipoDocumento.name() + " guardado correctamente en la base de datos.");
            } else {
                throw new SQLException("No se encontró un documento tipo '" + tipoDocumento.name() + "' con ID_Entrega_Doc_Parcial = " + idEntregaDocumentoParcial);
            }

        } else {
            throw new SQLException("No se pudo establecer la conexión a la base de datos.");
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
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        DocumentoParcial documentoParcial = null;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT * FROM documento_parcial WHERE ID_Doc_Parcial = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idDocumentoParcial);

                resultado = sentencia.executeQuery();
                if (resultado.next()) {
                    documentoParcial = new DocumentoParcial();
                    documentoParcial.setIdDocumentoParcial(resultado.getInt("ID_Doc_Parcial"));
                    documentoParcial.setFechaEntrega(resultado.getDate("fecha_entrega"));
                    documentoParcial.setTipo(TipoDocumentoParcial.valueOf(resultado.getString("tipo")));
                    documentoParcial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoParcial.setDocumento(resultado.getBytes("documento"));
                    documentoParcial.setIdEntregaDocumentoParcial(resultado.getInt("ID_Entrega_Doc_Parcial"));
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
        return documentoParcial;
    }
}