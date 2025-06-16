/*
 * Autor original: Abel Yong
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 09-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 10-06-2025
 * Descripción: Clase controlador para manejar las operaciones de la vista FXMLInicioSesion.fxml
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.controlador;

import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.controlador.usuarios.profesor.FXMLPrincipalProfesorController;
import sgpp.modelo.IControladorPrincipal;
import sgpp.modelo.beans.Profesor;
import sgpp.modelo.beans.Usuario;
import sgpp.modelo.dao.InicioSesionDAO;
import sgpp.modelo.dao.entidades.ProfesorDAO;
import sgpp.utilidad.Utilidad;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.SQLException;

public class FXMLInicioSesionController {
    private static final String RUTA_PANTALLA_PRINCIPAL_COORDINADOR = "vista/usuarios/coordinador/FXMLPrincipalCoordinador.fxml";
    private static final String RUTA_PANTALLA_PRINCIPAL_PROFESOR = "vista/usuarios/profesor/FXMLPrincipalProfesor.fxml";
    private static final String RUTA_PANTALLA_PRINCIPAL_ESTUDIANTE = "vista/usuarios/estudiante/FXMLPrincipalEstudiante.fxml";

    @FXML
    public TextField tfUsuario;
    @FXML
    public TextField tfContrasena;
    @FXML
    public Label lbUsuarioRequerido;
    @FXML
    public Label lbContrasenaRequerida;

    @FXML
    public void btnIniciarSesion(ActionEvent actionEvent) {
        if (validarCampos()) {
            String username = tfUsuario.getText();
            String password = tfContrasena.getText();

            Usuario sesionUsuario = validarCredenciales(username, password);

            if (sesionUsuario != null) {
                irPantallaPrincipal(sesionUsuario);
            }
        }
    }

    private boolean validarCampos() {
        lbUsuarioRequerido.setText("");
        lbContrasenaRequerida.setText("");
        boolean camposValidos = true;
        if (tfUsuario.getText().isEmpty()) {
            lbUsuarioRequerido.setText("*");
            camposValidos = false;
        }
        if (tfContrasena.getText().isEmpty()) {
            lbContrasenaRequerida.setText("*");
            camposValidos = false;
        }
        return camposValidos;
    }

    private Usuario validarCredenciales(String username, String password) {
        try {
            Usuario sesionUsuario = InicioSesionDAO.verificarCredenciales(username, password);
            if (sesionUsuario != null) {
                Utilidad.crearAlerta(
                        Alert.AlertType.INFORMATION,
                        "Credenciales correctas",
                        String.format("%s%S", "Bienvenido(a) ", sesionUsuario.toString()));
                return sesionUsuario; // ACCESO EXITOSO
            } else {
                Utilidad.crearAlerta(
                        Alert.AlertType.WARNING,
                        "Credenciales incorrectas",
                        "El usuario y/o contraseña no coinciden");
                return null; // ACCESO FALLIDO
            }
        } catch (SQLException e) {
            Utilidad.crearAlerta(Alert.AlertType.ERROR,
                    "Problema de conexión",
                    e.getMessage());
            return null;
        }
    }

    private void irPantallaPrincipal(Usuario sesionUsuario) {
        try {
            Stage escenarioBase = Utilidad.getEscenarioComponente(tfUsuario);
            FXMLLoader cargador = null;
            String titulo = "";

            switch (sesionUsuario.getTipoUsuario()) {
                case COORDINADOR:
                    cargador = new FXMLLoader(
                            SistemaGestionPracticasProfesionales.class.getResource(
                                    "vista/usuarios/coordinador/FXMLPrincipalCoordinador.fxml"));
                    titulo = "Sistema de Prácticas Profesionales - Coordinador";
                    break;
                case ESTUDIANTE:
                    cargador = new FXMLLoader(
                            SistemaGestionPracticasProfesionales.class.getResource(
                                    "vista/usuarios/estudiante/FXMLPrincipalEstudiante.fxml"));
                    titulo = "Sistema de Prácticas Profesionales - Estudiante";
                    break;
                case PROFESOR:
                    cargador = new FXMLLoader(
                            SistemaGestionPracticasProfesionales.class.getResource(
                                    "vista/usuarios/profesor/FXMLPrincipalProfesor.fxml"));
                    titulo = "Sistema de Prácticas Profesionales - Profesor";

                    int idProfesor = ProfesorDAO.obtenerIdProfesorPorIdUsuario(sesionUsuario.getIdUsuario());

                    FXMLPrincipalProfesorController controladorProfesor = cargador.getController();
                    controladorProfesor.inicializarInformacion(idProfesor);

                    break;
                default:
                    Utilidad.crearAlertaError("Error en tipo de usuario",
                            "Tipo de usuario no reconocido");

                    return;
            }

            Parent vista = cargador.load();

            Object controlador = cargador.getController();
            if (controlador instanceof IControladorPrincipal) {
                ((IControladorPrincipal) controlador).inicializarUsuario(sesionUsuario);
            }

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle(titulo);
            escenarioBase.show();
        } catch (IOException e) {
            Utilidad.mostrarError(true, e, "Error al cargar pantalla",
                    "No se pudo cargar la ventana principal");
        } catch (SQLException e) {
            Utilidad.mostrarErrorBD(true, e);
        }
    }
}
