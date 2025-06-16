/*
<<<<<<< HEAD
 * Autor original: Seth Marquez
 * Último autor: Seth Marquez
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase DAO para el manejo de la tabla 'documento_inicial'.
 *              Permite actualizar documentos PDF generados desde el sistema,
 *              específicamente para el tipo 'OficioAsignacion'.
 *
 * Estado: En funcionamiento
 * Modificaciones:
 * - Implementación del método guardarOficioAsignacion()
 * - Uso de conexión JDBC con cierre manual de recursos
=======
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase DAO para manejar los documentos iniciales de los expedientes
 */

/*
 * Estado: En progreso
 * Modificaciones:
>>>>>>> 228b8cbc072b999a0bf0835ec14af714381c1dd2
 */

package sgpp.modelo.dao.expediente.documentoinicial;

import sgpp.modelo.ConexionBD;
<<<<<<< HEAD

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DocumentoInicialDAO {

    /**
     * Guarda el PDF generado para un documento tipo 'OficioAsignacion' y actualiza su estado y fecha de entrega.
     *
     * @param pdfDocumento Documento PDF en bytes.
     * @param idEntrega    ID_Entrega_Doc_Inicial correspondiente al alumno.
     * @throws SQLException Si ocurre un error al actualizar el registro.
     */
    public static void guardarOficioAsignacion(byte[] pdfDocumento, int idEntrega) throws SQLException {
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "UPDATE documento_inicial " +
                              "SET documento = ?, estado = 'Entregado', fecha_entrega = NOW() " +
                              "WHERE tipo = 'OficioAsignacion' AND ID_Entrega_Doc_Inicial = ?";

            PreparedStatement sentencia = conexion.prepareStatement(consulta);
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
            throw new SQLException("No se pudo establecer la conexión a la base de datos.");
        }
    }
}
=======
import sgpp.modelo.beans.expediente.EstadoDocumento;
import sgpp.modelo.beans.expediente.documentoinicial.DocumentoInicial;
import sgpp.modelo.beans.expediente.documentoinicial.TipoDocumentoInicial;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DocumentoInicialDAO {
    public static List<DocumentoInicial> obtenerDocumentosInicialesPorExpediente(int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        List<DocumentoInicial> documentosIniciales = new ArrayList<>();

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT * FROM documento_inicial WHERE id_estudiante = ? AND id_periodo = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idEstudiante);
                sentencia.setInt(2, idPeriodo);

                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    DocumentoInicial documentoInicial = new DocumentoInicial();
                    documentoInicial.setIdDocumentoInicial(resultado.getInt("id_documento_inicial"));
                    documentoInicial.setFechaEntrega(resultado.getDate("fecha_entrega"));
                    documentoInicial.setTipo(TipoDocumentoInicial.valueOf(resultado.getString("tipo")));
                    documentoInicial.setEstado(EstadoDocumento.valueOf(resultado.getString("estado")));
                    documentoInicial.setDocumento(resultado.getBytes("documento"));
                    documentoInicial.setIdEntregaDocumentoInicial(resultado.getInt("id_entrega_documento_inicial"));
                    documentosIniciales.add(documentoInicial);
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
        return documentosIniciales;
    }

    public static boolean subirDocumentoInicial(DocumentoInicial documentoInicial, int idEntregaDocumentoInicial, int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        boolean exito = false;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "INSERT INTO documento_inicial (fecha_entrega, tipo, estado, documento, id_entrega_documento_inicial, id_estudiante, id_periodo) VALUES (?, ?, ?, ?, ?, ?, ?)";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setDate(1, new java.sql.Date(documentoInicial.getFechaEntrega().getTime()));
                sentencia.setString(2, documentoInicial.getTipo().name());
                sentencia.setString(3, documentoInicial.getEstado().name());
                sentencia.setBytes(4, documentoInicial.getDocumento());
                sentencia.setInt(5, idEntregaDocumentoInicial);
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
            if (conexionBD != null) {
                conexionBD.close();
            }
        }
        return exito;
    }

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
}
>>>>>>> 228b8cbc072b999a0bf0835ec14af714381c1dd2
