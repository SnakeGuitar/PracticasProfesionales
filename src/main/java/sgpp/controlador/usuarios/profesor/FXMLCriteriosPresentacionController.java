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

    private int[] valorCriterio;

    private int idProfesor, idEstudiante, idPeriodo;

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
        valorCriterio = new int[5];

        tgCriterio1 = new ToggleGroup();
        tgCriterio2 = new ToggleGroup();
        tgCriterio3 = new ToggleGroup();
        tgCriterio4 = new ToggleGroup();
        tgCriterio5 = new ToggleGroup();

        configurarRadioButton(rdBtnCriterio11, tgCriterio1, 10);
        configurarRadioButton(rdBtnCriterio12, tgCriterio1, 9);
        configurarRadioButton(rdBtnCriterio13, tgCriterio1, 8);
        configurarRadioButton(rdBtnCriterio14, tgCriterio1, 7);
        configurarRadioButton(rdBtnCriterio15, tgCriterio1, 6);

        configurarRadioButton(rdBtnCriterio21, tgCriterio2, 10);
        configurarRadioButton(rdBtnCriterio22, tgCriterio2, 9);
        configurarRadioButton(rdBtnCriterio23, tgCriterio2, 8);
        configurarRadioButton(rdBtnCriterio24, tgCriterio2, 7);
        configurarRadioButton(rdBtnCriterio25, tgCriterio2, 6);

        configurarRadioButton(rdBtnCriterio31, tgCriterio3, 10);
        configurarRadioButton(rdBtnCriterio32, tgCriterio3, 9);
        configurarRadioButton(rdBtnCriterio33, tgCriterio3, 8);
        configurarRadioButton(rdBtnCriterio34, tgCriterio3, 7);
        configurarRadioButton(rdBtnCriterio35, tgCriterio3, 6);

        configurarRadioButton(rdBtnCriterio41, tgCriterio4, 10);
        configurarRadioButton(rdBtnCriterio42, tgCriterio4, 9);
        configurarRadioButton(rdBtnCriterio43, tgCriterio4, 8);
        configurarRadioButton(rdBtnCriterio44, tgCriterio4, 7);
        configurarRadioButton(rdBtnCriterio45, tgCriterio4, 6);

        configurarRadioButton(rdBtnCriterio51, tgCriterio5, 10);
        configurarRadioButton(rdBtnCriterio52, tgCriterio5, 9);
        configurarRadioButton(rdBtnCriterio53, tgCriterio5, 8);
        configurarRadioButton(rdBtnCriterio54, tgCriterio5, 7);
        configurarRadioButton(rdBtnCriterio55, tgCriterio5, 6);

        configurarListener(tgCriterio1, valorCriterio, 0);
        configurarListener(tgCriterio2, valorCriterio, 1);
        configurarListener(tgCriterio3, valorCriterio, 2);
        configurarListener(tgCriterio4, valorCriterio, 3);
        configurarListener(tgCriterio5, valorCriterio, 4);
    }

    private void irCalificacionObservaciones() {
        try {
            Stage escenarioBase = Utilidad.getEscenarioComponente(btnContinuar);
            FXMLLoader cargador = new FXMLLoader(
                    SistemaGestionPracticasProfesionales.class.getResource(
                            RUTA_FXML_CALIFICACION_OBSERVACIONES));

            Parent vista = cargador.load();

            FXMLCalificacionObservacionesController controlador = cargador.getController();
            controlador.inicializarInformacion(valorCriterio, idEstudiante, idProfesor, idPeriodo);

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
        boolean confirmado = Utilidad.confirmarCancelar();

        if(confirmado) {
            Utilidad.cerrarVentana(btnContinuar);
        }
    }
}
