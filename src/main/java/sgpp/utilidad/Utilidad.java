/*
 * Autor original: Luis Donaldo
 * Ultimo autor: Luis Donaldo
 * Fecha de creación: 09-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 10-06-2025
 * Descripción: Clase DAO para manejar las operaciones de la entidad OrganizacionVinculada.
 */

/*
 * Estado: En progreso
 * Modificaciones:
 */

package sgpp.utilidad;

import sgpp.SistemaGestionPracticasProfesionales;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Control;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;

public class Utilidad {
    public static void crearAlerta(Alert.AlertType tipo, String titulo, String contenido) {
        Alert alerta = new Alert(tipo);
        alerta.setTitle(titulo);
        alerta.setHeaderText(null);
        alerta.setContentText(contenido);
        alerta.showAndWait();
    }

    public static boolean crearAlertaConfirmacion(String titulo, String contenido) {
        Alert alertaConfirmacion = new Alert(Alert.AlertType.CONFIRMATION);
        alertaConfirmacion.setTitle(titulo);
        alertaConfirmacion.setHeaderText(null);
        alertaConfirmacion.setContentText(contenido);
        return alertaConfirmacion.showAndWait().get() == ButtonType.OK;
    }

    public static Stage getEscenarioComponente(Control componente) {
        return (Stage) componente.getScene().getWindow();
    }

    public static void crearEscenario(String URL, String tituloEscenario) {
        try {
            Stage nuevoEscenario = new Stage();
            Parent vista = FXMLLoader.load(SistemaGestionPracticasProfesionales.class.getResource(URL));
            Scene nuevaEscena = new Scene(vista);
            nuevoEscenario.setScene(nuevaEscena);
            nuevoEscenario.initModality(Modality.APPLICATION_MODAL);
            nuevoEscenario.setTitle(tituloEscenario);
            nuevoEscenario.showAndWait();
        } catch(IOException e) {
            crearAlerta(Alert.AlertType.ERROR, "Error al cargar la vista", "No se pudo cargar la vista: " + URL);
            e.printStackTrace();
        }
    }
}
