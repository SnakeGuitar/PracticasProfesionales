/*
 * Autor original: Luis Donaldo
 * Último autor: Abel Yong
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 16-06-2025
 * Descripción: Clase DAO para manejar las entregas de los documentos iniciales de los expedientes
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.modelo.dao.expediente.documentoinicial;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.modelo.dao.ResultadoSQL;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class EntregaDocumentoInicialDAO {
    public static EntregaDocumentoInicial registrarDocumentoInicial(LocalDateTime fechaApertura, LocalDateTime fechaLimite,
                                                                    int idEstudiante, int idPeriodo) throws SQLException {
        EntregaDocumentoInicial entregaDocumentoInicial = null;
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "INSERT INTO entrega_doc_inicial (fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo) VALUES (?, ?, ?, ?)";
                sentencia = conexionBD.prepareStatement(consulta, PreparedStatement.RETURN_GENERATED_KEYS);
                sentencia.setString(1, fechaApertura.toString());
                sentencia.setString(2, fechaLimite.toString());
                sentencia.setInt(3, idEstudiante);
                sentencia.setInt(4, idPeriodo);

                int filasAfectadas = sentencia.executeUpdate();
                if (filasAfectadas > 0) {
                    resultado = sentencia.getGeneratedKeys();
                    if (resultado.next()) {
                        entregaDocumentoInicial = new EntregaDocumentoInicial();
                        entregaDocumentoInicial.setIdEntregaDocumentoInicial(resultado.getInt(1));
                        entregaDocumentoInicial.setFechaApertura(fechaApertura);
                        entregaDocumentoInicial.setFechaLimite(fechaLimite);
                        entregaDocumentoInicial.setIdEstudiante(idEstudiante);
                        entregaDocumentoInicial.setIdPeriodo(idPeriodo);
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
        return entregaDocumentoInicial;
    }

    public static EntregaDocumentoInicial obtenerEntregaDocumentoInicial(int idEntregaDocumentoInicial) throws SQLException {
        EntregaDocumentoInicial entregaDocumentoInicial = null;
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT * FROM entrega_doc_inicial WHERE ID_Entrega_Doc_Inicial = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocumentoInicial);
                resultado = sentencia.executeQuery();

                if (resultado.next()) {
                    entregaDocumentoInicial = convertirAEntrega(resultado);
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
        return entregaDocumentoInicial;
    }

    public static EntregaDocumentoInicial obtenerEntregaDisponible(int idEstudiante, int idPeriodo) throws SQLException {
        EntregaDocumentoInicial entrega = null;
        Connection conexionBD = ConexionBD.abrirConexion();
        if (conexionBD != null) {
            String consulta = "SELECT * FROM entrega_doc_inicial WHERE ID_Estudiante = ? AND ID_Periodo = ?";
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
                throw new SQLException("Error al obtener la entrega de documento inicial: " + e.getMessage(), e);
            } finally {
                ConexionBD.cerrarConexion(conexionBD, sentencia, resultado);
            }
        } else {
            throw new SQLException("No se pudo establecer la conexión a la base de datos.");
        }
        return entrega;
    }

    public static List<EntregaDocumentoInicial> obtenerEntregasPorPeriodo(int idPeriodo) throws SQLException {
        ArrayList<EntregaDocumentoInicial> entregas = new ArrayList<>();
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT * FROM entrega_doc_inicial WHERE ID_Periodo = ? ORDER BY fecha_apertura ASC";
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

    public static ResultadoSQL programarEntregas(EntregaDocumentoInicial muestra, int idPeriodo) throws SQLException {
        ResultadoSQL resultadoOperacion = new ResultadoSQL();
        String fechaApertura = muestra.getFechaApertura().toString();
        String fechaLimite = muestra.getFechaLimite().toString();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "UPDATE entrega_doc_inicial SET fecha_apertura = ?, fecha_limite = ? WHERE ID_Periodo = ?";
            PreparedStatement sentencia = null;
            try {
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setString(1, fechaApertura);
                sentencia.setString(2, fechaLimite);
                sentencia.setInt(3, idPeriodo);
                int filasAfectadas = sentencia.executeUpdate();
                if (filasAfectadas > 0) {
                    resultadoOperacion.setError(false);
                    resultadoOperacion.setMensaje("Entregas iniciales del periodo programadas exitosamente");
                } else {
                    resultadoOperacion.setError(true);
                    resultadoOperacion.setMensaje("No se pudo configurar las entregas iniciales del periodo");
                }
            } catch (SQLException sqlex) {
                System.out.println(sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la Base de Datos");
        }
        return resultadoOperacion;
    }

    public static EntregaDocumentoInicial obtenerPrimeraEntregaPorPeriodo(int idPeriodo) throws SQLException {
        EntregaDocumentoInicial entrega = null;
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            String consulta = "SELECT * FROM entrega_doc_inicial WHERE ID_Periodo = ? AND fecha_apertura IS NOT NULL ORDER BY fecha_apertura ASC";
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
                System.out.println("Error al obtener la entrega inicial: "+sqlex.getMessage());
            } finally {
                ConexionBD.cerrarConexion(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la Base de Datos");
        }
        return entrega;
    }

    private static EntregaDocumentoInicial convertirAEntrega(ResultSet resultado) throws SQLException {
        EntregaDocumentoInicial entrega = new EntregaDocumentoInicial();
        entrega.setIdEntregaDocumentoInicial(resultado.getInt("ID_Entrega_Doc_Inicial"));
        entrega.setFechaApertura(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_apertura")));
        entrega.setFechaLimite(UtilidadFormatoDeDatos.stringToLocalDateTime(resultado.getString("fecha_limite")));
        entrega.setIdEstudiante(resultado.getInt("ID_Estudiante"));
        entrega.setIdPeriodo(resultado.getInt("ID_Periodo"));
        return entrega;
    }
}
