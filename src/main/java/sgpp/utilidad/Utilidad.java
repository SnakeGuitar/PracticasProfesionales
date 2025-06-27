/*
 * Autor original: Luis Donaldo
 * Último autor: Luis Donaldo
 * Fecha de creación: 09-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 15-06-2025
 * Descripción: Clase utilitaria general para controladores JavaFX y generación de documentos.
 */

package sgpp.utilidad;

import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Modality;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.controlador.usuarios.coordinador.FXMLGenerarDocumentosController;
import sgpp.modelo.beans.Coordinador;

import java.io.IOException;
import java.util.Objects;

public class Utilidad {

    public static void crearAlerta(Alert.AlertType tipo, String titulo, String contenido) {
        Alert alerta = new Alert(tipo);

        alerta.setTitle(titulo);
        alerta.setHeaderText(null);
        alerta.setContentText(contenido);
        alerta.setResizable(true);
        alerta.showAndWait();
    }

    public static boolean crearAlertaConfirmacion(String titulo, String contenido) {
        Alert alertaConfirmacion = new Alert(Alert.AlertType.CONFIRMATION);

        alertaConfirmacion.setTitle(titulo);
        alertaConfirmacion.setHeaderText(null);
        alertaConfirmacion.setContentText(contenido);
        alertaConfirmacion.setResizable(true);

        return alertaConfirmacion.showAndWait().get() == ButtonType.OK;
    }

    public static boolean confirmarCancelar() {
        return crearAlertaConfirmacion(
                "Cancelar operación",
                "¿Estás seguro de que deseas cancelar?\n" +
                        "Se perderá el progreso no guardado.");
    }

    public static void cancelarOperacion(Control componente) {
        boolean confirmado = confirmarCancelar();

        if(confirmado) {
            cerrarVentana(componente);
        }
    }

    public static void crearAlertaError(String titulo, String contenido) {
        crearAlerta(Alert.AlertType.ERROR, titulo, contenido);
    }

    public static void crearAlertaAdvertencia(String titulo, String contenido) {
        crearAlerta(Alert.AlertType.WARNING, titulo, contenido);
    }

    public static void crearAlertaInformacion(String titulo, String contenido) {
        crearAlerta(Alert.AlertType.INFORMATION, titulo, contenido);
    }

    public static void mostrarError(boolean mostrarAlerta, Exception excepcion, String titulo, String contenido) {
        System.err.println(excepcion.getMessage());
        excepcion.printStackTrace();

        if(mostrarAlerta) {
            crearAlertaError(titulo, contenido + ": " + excepcion.getMessage());
        }
    }

    public static void mostrarErrorBD(boolean mostrarAlerta, Exception exception) {
        mostrarError(mostrarAlerta, exception, "Error de conexión", "Hubo un error de conexión");
    }

    public static Stage getEscenarioComponente(Control componente) {
        return (Stage) componente.getScene().getWindow();
    }

    public static void cerrarVentana(Control componente) {
        getEscenarioComponente(componente).close();
    }

    public static void crearEscenario(String URL, String tituloEscenario) {
        try {
            Stage nuevoEscenario = new Stage();
            Parent vista = FXMLLoader.load(Objects.requireNonNull(SistemaGestionPracticasProfesionales.class.getResource(URL)));
            Scene nuevaEscena = new Scene(vista);
            nuevoEscenario.setScene(nuevaEscena);
            nuevoEscenario.initModality(Modality.APPLICATION_MODAL);
            nuevoEscenario.setTitle(tituloEscenario);
            nuevoEscenario.showAndWait();
        } catch (IOException excepcion) {
            mostrarError(true, excepcion, "Error al cargar la vista", "No se pudo cargar la vista: " + URL);
        }
    }

    // sobrecarga del metodo anterior que permite seguir usando la utilidad pero usar controladores.
    public static void crearEscenario(String URL, String tituloEscenario, Coordinador coordinador) {
        try {
            Stage nuevoEscenario = new Stage();
            FXMLLoader loader = new FXMLLoader(Objects.requireNonNull(SistemaGestionPracticasProfesionales.class.getResource(URL)));
            Parent vista = loader.load();
            Object controlador = loader.getController();


            if (controlador instanceof FXMLGenerarDocumentosController) {
                ((FXMLGenerarDocumentosController) controlador).inicializarCoordinador(coordinador);
            }

            Scene nuevaEscena = new Scene(vista);
            nuevoEscenario.setScene(nuevaEscena);
            nuevoEscenario.initModality(Modality.APPLICATION_MODAL);
            nuevoEscenario.setTitle(tituloEscenario);
            nuevoEscenario.showAndWait();
        } catch (IOException excepcion) {
            mostrarError(true, excepcion, "Error al cargar la vista", "No se pudo cargar la vista: " + URL);
        }
    }


    public static void configurarRadioButton(RadioButton boton, ToggleGroup grupo, int valor) {
        boton.setToggleGroup(grupo);
        boton.setUserData(valor);
    }

    public static void configurarListener(ToggleGroup grupo, float[]valores, int indice) {
        grupo.selectedToggleProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null) valores[indice] = (int) newVal.getUserData();
        });
    }

    public static void configurarListener(ToggleGroup grupo, int[]valores, int indice) {
        grupo.selectedToggleProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null) valores[indice] = (int) newVal.getUserData();
        });
    }
}
