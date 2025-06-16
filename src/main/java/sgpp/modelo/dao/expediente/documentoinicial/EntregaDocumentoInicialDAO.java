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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class EntregaDocumentoInicialDAO {
    public static EntregaDocumentoInicial registrarDocumentoInicial(Date fechaApertura, Date fechaLimite,
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
                sentencia.setDate(1, new java.sql.Date(fechaApertura.getTime()));
                sentencia.setDate(2, new java.sql.Date(fechaLimite.getTime()));
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
                String consulta = "SELECT * FROM entrega_documento_inicial WHERE id_entrega_documento_inicial = ?";
                sentencia = conexionBD.prepareStatement(consulta);
                sentencia.setInt(1, idEntregaDocumentoInicial);
                resultado = sentencia.executeQuery();

                if (resultado.next()) {
                    Date fechaApertura = resultado.getDate("fecha_apertura");
                    Date fechaLimite = resultado.getDate("fecha_limite");
                    int idEstudiante = resultado.getInt("id_estudiante");
                    int idPeriodo = resultado.getInt("id_periodo");

                    entregaDocumentoInicial = new EntregaDocumentoInicial();
                    entregaDocumentoInicial.setIdEntregaDocumentoInicial(idEntregaDocumentoInicial);
                    entregaDocumentoInicial.setFechaApertura(fechaApertura);
                    entregaDocumentoInicial.setFechaLimite(fechaLimite);
                    entregaDocumentoInicial.setIdEstudiante(idEstudiante);
                    entregaDocumentoInicial.setIdPeriodo(idPeriodo);
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
                    EntregaDocumentoInicial entrega = new EntregaDocumentoInicial();
                    entrega.setIdEntregaDocumentoInicial(resultado.getInt("ID_Entrega_Doc_Inicialcol"));
                    entrega.setFechaApertura(resultado.getTimestamp("fecha_apertura"));
                    entrega.setFechaLimite(resultado.getTimestamp("fecha_limite"));
                    entrega.setIdEstudiante(resultado.getInt("ID_Estudiante"));
                    entrega.setIdPeriodo(resultado.getInt("ID_Periodo"));
                    entregas.add(entrega);
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
}