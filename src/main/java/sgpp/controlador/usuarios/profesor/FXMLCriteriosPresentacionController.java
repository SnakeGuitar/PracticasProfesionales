package sgpp.controlador.usuarios.profesor;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.RadioButton;
import javafx.scene.control.ToggleGroup;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.utilidad.Utilidad;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class FXMLCriteriosPresentacionController implements Initializable {
    private static final String RUTA_FXML_CALIFICACION_OBSERVACIONES = "/sgpp/vista/usuarios/profesor/FXMLCalificacionObservaciones.fxml";

    @FXML
    public Button btnContinuar;

    @FXML
    public Button btnCancelar;

    // Más RadioButtons :D
    @FXML
    public RadioButton rdBtnCriterio11;
    @FXML
    public RadioButton rdBtnCriterio12;
    @FXML
    public RadioButton rdBtnCriterio13;
    @FXML
    public RadioButton rdBtnCriterio14;
    @FXML
    public RadioButton rdBtnCriterio15;
    @FXML
    public RadioButton rdBtnCriterio21;
    @FXML
    public RadioButton rdBtnCriterio22;
    @FXML
    public RadioButton rdBtnCriterio23;
    @FXML
    public RadioButton rdBtnCriterio24;
    @FXML
    public RadioButton rdBtnCriterio25;
    @FXML
    public RadioButton rdBtnCriterio31;
    @FXML
    public RadioButton rdBtnCriterio32;
    @FXML
    public RadioButton rdBtnCriterio33;
    @FXML
    public RadioButton rdBtnCriterio34;
    @FXML
    public RadioButton rdBtnCriterio35;
    @FXML
    public RadioButton rdBtnCriterio41;
    @FXML
    public RadioButton rdBtnCriterio42;
    @FXML
    public RadioButton rdBtnCriterio43;
    @FXML
    public RadioButton rdBtnCriterio44;
    @FXML
    public RadioButton rdBtnCriterio45;
    @FXML
    public RadioButton rdBtnCriterio51;
    @FXML
    public RadioButton rdBtnCriterio52;
    @FXML
    public RadioButton rdBtnCriterio53;
    @FXML
    public RadioButton rdBtnCriterio54;
    @FXML
    public RadioButton rdBtnCriterio55;

    @FXML
    private ToggleGroup tgCriterio1,
                        tgCriterio2,
                        tgCriterio3,
                        tgCriterio4,
                        tgCriterio5;

    private int[] valorCriterio;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        configurarCriterios();
    }

    private void configurarCriterios() {
        valorCriterio = new int[5];

        tgCriterio1 = new ToggleGroup();
        tgCriterio2 = new ToggleGroup();
        tgCriterio3 = new ToggleGroup();
        tgCriterio4 = new ToggleGroup();
        tgCriterio5 = new ToggleGroup();

        rdBtnCriterio11.setToggleGroup(tgCriterio1); rdBtnCriterio11.setUserData(10);
        rdBtnCriterio12.setToggleGroup(tgCriterio1); rdBtnCriterio12.setUserData(9);
        rdBtnCriterio13.setToggleGroup(tgCriterio1); rdBtnCriterio13.setUserData(8);
        rdBtnCriterio14.setToggleGroup(tgCriterio1); rdBtnCriterio14.setUserData(7);
        rdBtnCriterio15.setToggleGroup(tgCriterio1); rdBtnCriterio15.setUserData(6);

        rdBtnCriterio21.setToggleGroup(tgCriterio2); rdBtnCriterio21.setUserData(10);
        rdBtnCriterio22.setToggleGroup(tgCriterio2); rdBtnCriterio22.setUserData(9);
        rdBtnCriterio23.setToggleGroup(tgCriterio2); rdBtnCriterio23.setUserData(8);
        rdBtnCriterio24.setToggleGroup(tgCriterio2); rdBtnCriterio24.setUserData(7);
        rdBtnCriterio25.setToggleGroup(tgCriterio2); rdBtnCriterio25.setUserData(6);

        rdBtnCriterio31.setToggleGroup(tgCriterio3); rdBtnCriterio31.setUserData(10);
        rdBtnCriterio32.setToggleGroup(tgCriterio3); rdBtnCriterio32.setUserData(9);
        rdBtnCriterio33.setToggleGroup(tgCriterio3); rdBtnCriterio33.setUserData(8);
        rdBtnCriterio34.setToggleGroup(tgCriterio3); rdBtnCriterio34.setUserData(7);
        rdBtnCriterio35.setToggleGroup(tgCriterio3); rdBtnCriterio35.setUserData(6);

        rdBtnCriterio41.setToggleGroup(tgCriterio4); rdBtnCriterio41.setUserData(10);
        rdBtnCriterio42.setToggleGroup(tgCriterio4); rdBtnCriterio42.setUserData(9);
        rdBtnCriterio43.setToggleGroup(tgCriterio4); rdBtnCriterio43.setUserData(8);
        rdBtnCriterio44.setToggleGroup(tgCriterio4); rdBtnCriterio44.setUserData(7);
        rdBtnCriterio45.setToggleGroup(tgCriterio4); rdBtnCriterio45.setUserData(6);

        rdBtnCriterio51.setToggleGroup(tgCriterio5); rdBtnCriterio51.setUserData(10);
        rdBtnCriterio52.setToggleGroup(tgCriterio5); rdBtnCriterio52.setUserData(9);
        rdBtnCriterio53.setToggleGroup(tgCriterio5); rdBtnCriterio53.setUserData(8);
        rdBtnCriterio54.setToggleGroup(tgCriterio5); rdBtnCriterio54.setUserData(7);
        rdBtnCriterio55.setToggleGroup(tgCriterio5); rdBtnCriterio55.setUserData(6);

        tgCriterio1.selectedToggleProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null) valorCriterio[0] = (int) newVal.getUserData();
        });

        tgCriterio2.selectedToggleProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null) valorCriterio[1] = (int) newVal.getUserData();
        });

        tgCriterio3.selectedToggleProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null) valorCriterio[2] = (int) newVal.getUserData();
        });

        tgCriterio4.selectedToggleProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null) valorCriterio[3] = (int) newVal.getUserData();
        });

        tgCriterio5.selectedToggleProperty().addListener((obs, oldVal, newVal) -> {
            if (newVal != null) valorCriterio[4] = (int) newVal.getUserData();
        });
    }

    private void irCalificacionObservaciones() {
        try {
            Stage escenarioBase = Utilidad.getEscenarioComponente(btnContinuar);
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(
                            RUTA_FXML_CALIFICACION_OBSERVACIONES));

            Parent vista = cargador.load();

            FXMLCalificacionObservacionesController controlador = cargador.getController();
            controlador.inicializarInformacion(valorCriterio);

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle("Calificaciones y Observaciones");
            escenarioBase.show();
        } catch (IOException excepcion) {
            Utilidad.mostrarError(true, excepcion,
                    "Error al cargar calificaciones",
                    "No se pudo cargar la ventana de calificaciones y observaciones.");
        }
    }

    public void btnClicContinuar(ActionEvent actionEvent) {
        boolean criteriosSeleccionados = true;

        for (int criterio : valorCriterio) {
            if (criterio == 0) {
                criteriosSeleccionados = false;
            }
        }

        if(criteriosSeleccionados) {
            irCalificacionObservaciones();
        } else {
            Utilidad.crearAlertaAdvertencia("Criterios vacíos",
                    "Selecciona un valor por cada criterio para continuar.");
        }
    }

    public void BtnClicCancelar(ActionEvent actionEvent) {
    }
}
