/*
 * Autor original: Abel Yong
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 10-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 11-06-2025
 * Descripción: Clase DAO para manejar las operaciones de la entidad OrganizacionVinculada.
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.modelo;

import sgpp.utilidad.Utilidad;

import java.sql.*;

public class ConexionBD {
    private static final String IP = "localhost";
    private static final String PUERTO = "3306";
    private static final String NOMBRE_BD = "practicasprofesionales1";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = String.format(
            "jdbc:mysql://%s:%s/%s?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8", IP, PUERTO, NOMBRE_BD);

    // Por ahora hay que poner root y la contraseña de la base de datos.

    private static final String DEFAULT_USERNAME = "";
    private static final String DEFAULT_PASSWORD = "";

    public static Connection abrirConexion() {
        return abrirConexion(DEFAULT_USERNAME, DEFAULT_PASSWORD);
    }

    public static Connection abrirConexion(String username, String password) {
        Connection conexionBD = null;
        String urlConexion = URL;

        try {
            Class.forName(DRIVER);
            conexionBD = DriverManager.getConnection(urlConexion, username, password);
            System.out.println("Conexión exitosa a la base de datos: " + NOMBRE_BD);
        } catch (ClassNotFoundException e) {
            System.err.println("Error al cargar el driver: " + DRIVER);
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error al conectar a la base de datos: " + urlConexion);
            e.printStackTrace();
        }
        return conexionBD;
    }

    public static void cerrarConexion(Connection conexion, PreparedStatement consulta, ResultSet resultado) {
        try {
            if(resultado != null) {
                resultado.close();
            }

            if(consulta != null) {
                consulta.close();
            }

            if(conexion != null) {
                conexion.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar conexión con la base de datos");
            e.printStackTrace();
        }
    }

    public static void cerrarConexion(Connection conexion, PreparedStatement consulta) {
        try {
            if(consulta != null) {
                consulta.close();
            }

            if(conexion != null) {
                conexion.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar conexión con la base de datos");
            e.printStackTrace();
        }
    }
    // Para DAOs que utilizen procedimientos almacenados.
    public static void cerrarConexionProcedimiento(Connection conexion, CallableStatement consulta) {
        try {
            if(consulta != null) {
                consulta.close();
            }

            if(conexion != null) {
                conexion.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar conexión con la base de datos");
            e.printStackTrace();
        }
    }
}
