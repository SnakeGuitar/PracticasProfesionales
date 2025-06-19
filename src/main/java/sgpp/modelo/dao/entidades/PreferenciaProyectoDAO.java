package sgpp.modelo.dao.entidades;

import sgpp.modelo.ConexionBD;
import sgpp.modelo.beans.PreferenciaProyecto;
import sgpp.utilidad.Utilidad;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PreferenciaProyectoDAO {
    public static List<PreferenciaProyecto> obtenerPreferenciasDelEstudiante(int idEstudiante) throws SQLException {
        List<PreferenciaProyecto> preferencias = new ArrayList<PreferenciaProyecto>();
        Connection conexion = ConexionBD.abrirConexion();
        if (conexion != null) {
            PreparedStatement sentencia = null;
            ResultSet resultado = null;
            try {
                String consulta = "SELECT num_preferencia, ID_Proyecto, ID_Estudiante FROM Preferencia WHERE ID_Estudiante = ?";
                sentencia = conexion.prepareStatement(consulta);
                sentencia.setInt(1, idEstudiante);
                resultado = sentencia.executeQuery();
                while (resultado.next()) {
                    preferencias.add(convertirPreferenciaProyecto(resultado));
                }
            } finally {
                Utilidad.cerrarRecursosSQL(conexion, sentencia, resultado);
            }
        } else {
            throw new SQLException("Se ha perdido la conexion a la base de datos");
        }
        return preferencias;
    }

    private static PreferenciaProyecto convertirPreferenciaProyecto(ResultSet resultado) throws SQLException {
        PreferenciaProyecto preferencia = new PreferenciaProyecto();
        preferencia.setIdProyecto(resultado.getInt("ID_Proyecto"));
        preferencia.setIdEstudiante(resultado.getInt("ID_Estudiante"));
        preferencia.setNumPreferencia(resultado.getInt("num_preferencia"));
        return preferencia;
    }
}
