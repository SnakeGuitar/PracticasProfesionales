/*
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
 */

package sgpp.modelo.dao.expediente.documentoinicial;

import sgpp.modelo.ConexionBD;

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
