package sgpp.utilidad;

import javafx.stage.Stage;

public class ResultadoFXML<T> {
    private final T controlador;
    private final Stage stage;

    public ResultadoFXML(T controlador, Stage stage) {
        this.controlador = controlador;
        this.stage = stage;
    }

    public T getControlador() {
        return controlador;
    }

    public Stage getStage() {
        return stage;
    }
}
