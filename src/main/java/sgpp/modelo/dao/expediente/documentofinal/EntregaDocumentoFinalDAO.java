/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase DAO para manejar las entregas de documentos finales
 */

/*
 * Estado: En progreso
 * Modificaciones:
 * - Implementación basada en EntregaDocumentoParcialDAO
 * - Adaptado para tabla entrega_doc_final
 * - Eliminado codigo sin utilizar obtenerEntregaDisponible()
 */

package sgpp.modelo.dao.expediente.documentofinal;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.documentofinal.EntregaDocumentoFinal;
import sgpp.modelo.dao.ResultadoSQL;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class EntregaDocumentoFinalDAO {

    /**
     * Registra una nueva entrega de documento final en la base de datos.
     *
     * @param fechaApertura Fecha de apertura de la entrega
     * @param fechaLimite   Fecha límite de la entrega
     * @param idEstudiante  ID del estudiante
     * @param idPeriodo     ID del período
     * @return EntregaDocumentoFinal creada con el ID generado
     * @throws SQLException Si ocurre un error en la inserción
     */
    public static EntregaDocumentoFinal registrarEntrega(Date fechaApertura, Date fechaLimite,
                                                         int idEstudiante, int idPeriodo) throws SQLException {
        EntregaDocumentoFinal entregaDocumentoFinal = null;
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "INSERT INTO entrega_doc_final (fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo) VALUES (?, ?, ?, ?)";
                sentencia = conexionBD.prepareStatement(consulta, PreparedStatement.RETURN_GENERATED_KEYS);
                sentencia.setTimestamp(1, new java.sql.Timestamp(fechaApertura.getTime()));
                sentencia.setTimestamp(2, new java.sql.Timestamp(fechaLimite.getTime()));
                sentencia.setInt(3, idEstudiante);
                sentencia.setInt(4, idPeriodo);

                int filasAfectadas = sentencia.executeUpdate();
                if (filasAfectadas > 0) {
                    resultado = sentencia.getGeneratedKeys();
                    if (resultado.next()) {
                        entregaDocumentoFinal = convertirAEntrega(resultado);
                    }
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
        return entregaDocumentoFinal;
    }

    /**
     * Obtiene una entrega de documento final específica por su ID.
     *
     * @param idEntregaDocumentoFinal ID de la entrega de documento final
     * @return EntregaDocumentoFinal encontrada o null si no existe
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static EntregaDocumentoFinal obtenerEntregaDocumentoFinal(int idEntregaDocumentoFinal) throws SQLException {
        EntregaDocumentoFinal entregaDocumentoFinal = null;
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT * FROM entrega_doc_final WHERE ID_Entrega_Doc_Final = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocumentoFinal);
                resultado = sentencia.executeQuery();

                if (resultado.next()) {
                    entregaDocumentoFinal = convertirAEntrega(resultado);
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
        return entregaDocumentoFinal;
    }

    public static EntregaDocumentoFinal obtenerEntregaDisponible(int idEstudiante, int idPeriodo) throws SQLException {
        EntregaDocumentoFinal entrega = null;
        Connection conexionBD = ConexionBD.abrirConexion();
        if (conexionBD != null) {
            String consulta = "SELECT * FROM entrega_doc_final WHERE ID_Estudiante = ? AND ID_Periodo = ?";
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
                throw new SQLException("Error al obtener la entrega de documento final: " + e.getMessage(), e);
            } finally {
                ConexionBD.cerrarConexion(conexionBD, sentencia, resultado);
            }
        } else {
            throw new SQLException("No se pudo establecer la conexión a la base de datos.");
        }
        return entrega;
    }

    /**
     * Obtiene todas las entregas de documentos finales de un estudiante en un período específico.
     * Sin filtro de fechas, retorna todas las entregas.
     *
     * @param idEstudiante ID del estudiante
     * @param idPeriodo    ID del período
     * @return Lista de todas las entregas del estudiante en el período
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static List<EntregaDocumentoFinal> obtenerEntregasPorEstudianteYPeriodo(int idEstudiante, int idPeriodo) throws SQLException {
        List<EntregaDocumentoFinal> entregas = new ArrayList<>();
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT ID_Entrega_Doc_Final, fecha_apertura, fecha_limite, " +
                        "ID_Estudiante, ID_Periodo " +
                        "FROM entrega_doc_final " +
                        "WHERE ID_Estudiante = ? AND ID_Periodo = ? " +
                        "ORDER BY fecha_apertura DESC";

                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idEstudiante);
                sentencia.setInt(2, idPeriodo);
                resultado = sentencia.executeQuery();

                while (resultado.next()) {
                    entregas.add(convertirAEntrega(resultado));
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
        return entregas;
    }

    /**
     * Verifica si existe una entrega de documento final activa para un estudiante en un período.
     *
     * @param idEstudiante ID del estudiante
     * @param idPeriodo    ID del período
     * @return true si existe una entrega activa, false en caso contrario
     * @throws SQLException Si ocurre un error en la consulta
     */
    public static boolean existeEntregaActiva(int idEstudiante, int idPeriodo) throws SQLException {
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        boolean existe = false;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT COUNT(*) FROM entrega_doc_final " +
                        "WHERE ID_Estudiante = ? AND ID_Periodo = ? " +
                        "AND NOW() BETWEEN fecha_apertura AND fecha_limite";
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

    /**
     * Actualiza las fechas de una entrega de documento final existente.
     *
     * @param idEntregaDocumentoFinal ID de la entrega a actualizar
     * @param nuevaFechaApertura      Nueva fecha de apertura
     * @param nuevaFechaLimite        Nueva fecha límite
     * @return true si la actualización fue exitosa, false en caso contrario
     * @throws SQLException Si ocurre un error en la actualización
     */
    public static boolean actualizarFechasEntrega(int idEntregaDocumentoFinal, Date nuevaFechaApertura, Date nuevaFechaLimite) throws SQLException {
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        boolean exito = false;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "UPDATE entrega_doc_final SET fecha_apertura = ?, fecha_limite = ? WHERE ID_Entrega_Doc_Final = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setTimestamp(1, new java.sql.Timestamp(nuevaFechaApertura.getTime()));
                sentencia.setTimestamp(2, new java.sql.Timestamp(nuevaFechaLimite.getTime()));
                sentencia.setInt(3, idEntregaDocumentoFinal);

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

    public static List<EntregaDocumentoFinal> obtenerEntregasPorPeriodo(int idPeriodo) throws SQLException {
        ArrayList<EntregaDocumentoFinal> entregas = new ArrayList<>();
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT * FROM entrega_doc_final WHERE ID_Periodo = ? ORDER BY fecha_apertura ASC";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idPeriodo);
                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    entregas.add(convertirAEntrega(resultado));
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
        return entregas;
    }

    private static EntregaDocumentoFinal convertirAEntrega(ResultSet resultado) throws SQLException {
        EntregaDocumentoFinal entrega = new EntregaDocumentoFinal();
        entrega.setIdEntregaDocumentoFinal(resultado.getInt("ID_Entrega_Doc_Final"));
        entrega.setFechaApertura(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_apertura")));
        entrega.setFechaLimite(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_limite")));
        entrega.setIdEstudiante(resultado.getInt("ID_Estudiante"));
        entrega.setIdPeriodo(resultado.getInt("ID_Periodo"));
        return entrega;
    }

    public static ResultadoSQL programarEntregas(EntregaDocumentoFinal candidata, int idPeriodo) throws SQLException {
        ResultadoSQL resultadoOperacion = new ResultadoSQL();
        String fechaApertura = candidata.getFechaApertura().toString();
        String fechaLimite = candidata.getFechaLimite().toString();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "UPDATE entrega_doc_final SET fecha_apertura = ?, fecha_limite = ? WHERE ID_Periodo = ?";
            PreparedStatement sentencia = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setString(1, fechaApertura);
                sentencia.setString(2, fechaLimite);
                sentencia.setInt(3, idPeriodo);
                int filasAfectadas = sentencia.executeUpdate();
                if (filasAfectadas > 0) {
                    resultadoOperacion.setError(false);
                    resultadoOperacion.setMensaje("Entregas finales del periodo programadas exitosamente");
                } else {
                    resultadoOperacion.setError(true);
                    resultadoOperacion.setMensaje("No se pudo configurar las entregas finales del periodo");
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

    public static EntregaDocumentoFinal obtenerPrimeraEntregaPorPeriodo(int idPeriodo) throws SQLException {
        EntregaDocumentoFinal entrega = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM entrega_doc_final WHERE ID_Periodo = ? AND fecha_apertura IS NOT NULL ORDER BY fecha_apertura ASC";
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
                System.out.println("Error al obtener la entrega final: "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la Base de Datos");
        }
        return entrega;
    }
}