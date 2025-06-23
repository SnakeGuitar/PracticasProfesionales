package sgpp.utilidad;

import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.Window;

import java.io.IOException;

import static sgpp.utilidad.Utilidad.crearAlertaError;

public class UtilFXML {

    public <T> ResultadoFXML<T> abrirFXMLModal(String rutaFXML, String titulo, Class<T> claseControlador, Window owner) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource(rutaFXML));
            Parent root = loader.load();

            Stage stage = new Stage();
            stage.setTitle(titulo);
            stage.setScene(new Scene(root));

            if (owner != null) {
                stage.initOwner(owner);
                stage.initModality(Modality.APPLICATION_MODAL);
            }

            T controlador = loader.getController();
            if (!claseControlador.isInstance(controlador)) {
                System.err.println("El controlador no es del tipo esperado " +
                        claseControlador.getSimpleName());
                return null;
            }
            return new ResultadoFXML<>(controlador, stage);
        } catch (IOException e) {
            crearAlertaError("Error al abrir" + titulo,
                    "Volverá a la ventana anterior");
            System.err.println("Error al abrir " + titulo + e.getMessage());
            return null;
        }
    }

    public <T> T abrirFXML(String rutaFXML, String titulo, Class<T> claseControlador) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource(rutaFXML));
            Parent root = loader.load();

            Stage stage = new Stage();
            stage.setTitle(titulo);
            stage.setScene(new Scene(root));
            stage.show();

            T loaderController;
            loaderController = loader.getController();
            if (claseControlador.isInstance(loaderController)) {
                return claseControlador.cast(loaderController);
            } else {
                System.err.println("El controlador no es del tipo esperdado: {}" +
                        claseControlador.getSimpleName());
                return null;
            }
        } catch (IOException e) {
            Utilidad.crearAlertaError("Error al abrir" + titulo,
                    "Volverá a la ventana anterior");
            System.err.println("Error al abrir " + titulo + e.getMessage());
            return null;
        }
    }
}
