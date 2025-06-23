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
import javafx.stage.Modality;
import javafx.stage.Stage;
import sgpp.SistemaGestionPracticasProfesionales;
import sgpp.utilidad.Utilidad;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import static sgpp.utilidad.Utilidad.configurarListener;
import static sgpp.utilidad.Utilidad.configurarRadioButton;

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

    private ToggleGroup[] toggleGroups;

    private RadioButton[][] radioButtons;

    private float[] valorCriterio;

    private int idProfesor;
    private int idEstudiante;
    private int idPeriodo;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        configurarCriterios();
    }

    public void inicializarInformacion(int idProfesor, int idEstudiante, int idPeriodo) {
        this.idEstudiante = idEstudiante;
        this.idProfesor = idProfesor;
        this.idPeriodo = idPeriodo;
    }

    private void configurarCriterios() {
        valorCriterio = new float[5];

        tgCriterio1 = new ToggleGroup();
        tgCriterio2 = new ToggleGroup();
        tgCriterio3 = new ToggleGroup();
        tgCriterio4 = new ToggleGroup();
        tgCriterio5 = new ToggleGroup();

        toggleGroups = new ToggleGroup[]{
                tgCriterio1, tgCriterio2,
                tgCriterio3, tgCriterio4,
                tgCriterio5
        };

        radioButtons = new RadioButton[][]{
                {rdBtnCriterio11, rdBtnCriterio12, rdBtnCriterio13, rdBtnCriterio14, rdBtnCriterio15},
                {rdBtnCriterio21, rdBtnCriterio22, rdBtnCriterio23, rdBtnCriterio24, rdBtnCriterio25},
                {rdBtnCriterio31, rdBtnCriterio32, rdBtnCriterio33, rdBtnCriterio34, rdBtnCriterio35},
                {rdBtnCriterio41, rdBtnCriterio42, rdBtnCriterio43, rdBtnCriterio44, rdBtnCriterio45},
                {rdBtnCriterio51, rdBtnCriterio52, rdBtnCriterio53, rdBtnCriterio54, rdBtnCriterio55}
        };

        for (int criterio = 0; criterio < 5; criterio++) {
            for (int valorIndex = 0; valorIndex < 5; valorIndex++) {
                configurarRadioButton(radioButtons[criterio][valorIndex],
                        toggleGroups[criterio],
                        10 - valorIndex); // 10, 9, 8, 7, 6
            }

            configurarListener(toggleGroups[criterio], valorCriterio, criterio);
        }
    }

    private void irCalificacionObservaciones() {
        try {
            Stage escenarioBase = new Stage();
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(
                            RUTA_FXML_CALIFICACION_OBSERVACIONES));

            Parent vista = cargador.load();

            FXMLCalificacionObservacionesController controlador = cargador.getController();
            controlador.inicializarInformacion(valorCriterio, idEstudiante, idProfesor, idPeriodo);

            Scene escenaPrincipal = new Scene(vista);
            escenarioBase.setScene(escenaPrincipal);
            escenarioBase.setTitle("Calificaciones y Observaciones");
            escenarioBase.initModality(Modality.APPLICATION_MODAL);
            escenarioBase.show();
        } catch (IOException excepcion) {
            Utilidad.mostrarError(true, excepcion,
                    "Error al cargar calificaciones",
                    "No se pudo cargar la ventana de calificaciones y observaciones.");
        }
    }

    public void btnClicContinuar(ActionEvent actionEvent) {
        boolean criteriosSeleccionados = true;

        for (float criterio : valorCriterio) {
            if (criterio == 0) {
                criteriosSeleccionados = false;
                break;
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
        boolean confirmado = Utilidad.confirmarCancelar();

        if(confirmado) {
            Utilidad.cerrarVentana(btnContinuar);
        }
    }
}
