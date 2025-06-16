/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase DAO para manejar las entregas de los documentos iniciales de los expedientes
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.modelo.dao.expediente.documentoinicial;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.expediente.documentoinicial.EntregaDocumentoInicial;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
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
                String consulta = "INSERT INTO entrega_documento_inicial (fecha_apertura, fecha_limite, id_estudiante, id_periodo) VALUES (?, ?, ?, ?)";
                sentencia = conexionBD.prepareStatement(consulta, PreparedStatement.RETURN_GENERATED_KEYS);
                sentencia.setString(1, fechaApertura.toString());
                sentencia.setString(2, fechaLimite.toString());
                sentencia.setInt(3, idEstudiante);
                sentencia.setInt(4, idPeriodo);

                int filasAfectadas = sentencia.executeUpdate();
                if (filasAfectadas > 0) {
                    resultado = sentencia.getGeneratedKeys();
                    if (resultado.next()) {
                        entregaDocumentoInicial = convertirAEntrega(resultado);
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
                String consulta = "SELECT * FROM entrega_documento_inicial WHERE id_entrega_documento_inicial = ?";
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

    public static List<EntregaDocumentoInicial> obtenerEntregasDisponibles(int idEstudiante, int idPeriodo) throws SQLException {
        List<EntregaDocumentoInicial> entregas = new ArrayList<>();
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT ID_Entrega_Doc_Inicialcol, fecha_apertura, fecha_limite, " +
                        "ID_Estudiante, ID_Periodo " +
                        "FROM entrega_doc_inicial " +
                        "WHERE ID_Estudiante = ? AND ID_Periodo = ? " +
                        "AND NOW() BETWEEN fecha_apertura AND fecha_limite " +
                        "ORDER BY fecha_limite ASC";

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

    public static List<EntregaDocumentoInicial> obtenerEntregasPorPeriodo(int idPeriodo) throws SQLException {
        ArrayList<EntregaDocumentoInicial> entregas = new ArrayList<>();
        Connection conexionBD = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexionBD = ConexionBD.abrirConexion();
            if (conexionBD != null) {
                String consulta = "SELECT * FROM entrega_doc_inicial WHERE ID_Periodo = ?";
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