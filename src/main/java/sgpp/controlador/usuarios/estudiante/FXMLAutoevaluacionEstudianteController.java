package sgpp.controlador.usuarios.estudiante;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.control.ToggleGroup;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.util.ResourceBundle;

import static sgpp.utilidad.Utilidad.configurarListener;
import static sgpp.utilidad.Utilidad.configurarRadioButton;

public class FXMLAutoevaluacionEstudianteController implements Initializable {

    @FXML
    public Label lbNombreAlumno;

    @FXML
    public Label lbMatricula;

    @FXML
    public Label lbOV;

    @FXML
    public Label lbDepartamento;

    @FXML
    public Label lbProyecto;

    @FXML
    public Label lbResponsable;

    @FXML
    public Button btnRegresar;

    @FXML
    public Button btnSubir;

    @FXML
    public Button btnCancelar;

    // RadioButtons
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
    public RadioButton rdBtnCriterio61;
    @FXML
    public RadioButton rdBtnCriterio62;
    @FXML
    public RadioButton rdBtnCriterio63;
    @FXML
    public RadioButton rdBtnCriterio64;
    @FXML
    public RadioButton rdBtnCriterio65;

    @FXML
    public RadioButton rdBtnCriterio71;
    @FXML
    public RadioButton rdBtnCriterio72;
    @FXML
    public RadioButton rdBtnCriterio73;
    @FXML
    public RadioButton rdBtnCriterio74;
    @FXML
    public RadioButton rdBtnCriterio75;

    @FXML
    public RadioButton rdBtnCriterio81;
    @FXML
    public RadioButton rdBtnCriterio82;
    @FXML
    public RadioButton rdBtnCriterio83;
    @FXML
    public RadioButton rdBtnCriterio84;
    @FXML
    public RadioButton rdBtnCriterio85;

    @FXML
    public RadioButton rdBtnCriterio91;
    @FXML
    public RadioButton rdBtnCriterio92;
    @FXML
    public RadioButton rdBtnCriterio93;
    @FXML
    public RadioButton rdBtnCriterio94;
    @FXML
    public RadioButton rdBtnCriterio95;

    @FXML
    public RadioButton rdBtnCriterio101;
    @FXML
    public RadioButton rdBtnCriterio102;
    @FXML
    public RadioButton rdBtnCriterio103;
    @FXML
    public RadioButton rdBtnCriterio104;
    @FXML
    public RadioButton rdBtnCriterio105;

    @FXML
    private ToggleGroup tgCriterio1,
                        tgCriterio2,
                        tgCriterio3,
                        tgCriterio4,
                        tgCriterio5,
                        tgCriterio6,
                        tgCriterio7,
                        tgCriterio8,
                        tgCriterio9,
                        tgCriterio10;

    private int[] valorCriterio;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        configurarCriterios();
    }

    private void configurarCriterios() {
        valorCriterio = new int[9];

        tgCriterio1 = new ToggleGroup();
        tgCriterio2 = new ToggleGroup();
        tgCriterio3 = new ToggleGroup();
        tgCriterio4 = new ToggleGroup();
        tgCriterio5 = new ToggleGroup();
        tgCriterio6 = new ToggleGroup();
        tgCriterio7 = new ToggleGroup();
        tgCriterio8 = new ToggleGroup();
        tgCriterio9 = new ToggleGroup();
        tgCriterio10 = new ToggleGroup();

        configurarRadioButton(rdBtnCriterio11, tgCriterio1, 5);
        configurarRadioButton(rdBtnCriterio12, tgCriterio1, 4);
        configurarRadioButton(rdBtnCriterio13, tgCriterio1, 3);
        configurarRadioButton(rdBtnCriterio14, tgCriterio1, 2);
        configurarRadioButton(rdBtnCriterio15, tgCriterio1, 1);

        configurarRadioButton(rdBtnCriterio21, tgCriterio2, 5);
        configurarRadioButton(rdBtnCriterio22, tgCriterio2, 4);
        configurarRadioButton(rdBtnCriterio23, tgCriterio2, 3);
        configurarRadioButton(rdBtnCriterio24, tgCriterio2, 2);
        configurarRadioButton(rdBtnCriterio25, tgCriterio2, 1);

        configurarRadioButton(rdBtnCriterio31, tgCriterio3, 5);
        configurarRadioButton(rdBtnCriterio32, tgCriterio3, 4);
        configurarRadioButton(rdBtnCriterio33, tgCriterio3, 3);
        configurarRadioButton(rdBtnCriterio34, tgCriterio3, 2);
        configurarRadioButton(rdBtnCriterio35, tgCriterio3, 1);

        configurarRadioButton(rdBtnCriterio41, tgCriterio4, 5);
        configurarRadioButton(rdBtnCriterio42, tgCriterio4, 4);
        configurarRadioButton(rdBtnCriterio43, tgCriterio4, 3);
        configurarRadioButton(rdBtnCriterio44, tgCriterio4, 2);
        configurarRadioButton(rdBtnCriterio45, tgCriterio4, 1);

        configurarRadioButton(rdBtnCriterio51, tgCriterio5, 5);
        configurarRadioButton(rdBtnCriterio52, tgCriterio5, 4);
        configurarRadioButton(rdBtnCriterio53, tgCriterio5, 3);
        configurarRadioButton(rdBtnCriterio54, tgCriterio5, 2);
        configurarRadioButton(rdBtnCriterio55, tgCriterio5, 1);

        configurarRadioButton(rdBtnCriterio61, tgCriterio6, 5);
        configurarRadioButton(rdBtnCriterio62, tgCriterio6, 4);
        configurarRadioButton(rdBtnCriterio63, tgCriterio6, 3);
        configurarRadioButton(rdBtnCriterio64, tgCriterio6, 2);
        configurarRadioButton(rdBtnCriterio65, tgCriterio6, 1);

        configurarRadioButton(rdBtnCriterio71, tgCriterio7, 5);
        configurarRadioButton(rdBtnCriterio72, tgCriterio7, 4);
        configurarRadioButton(rdBtnCriterio73, tgCriterio7, 3);
        configurarRadioButton(rdBtnCriterio74, tgCriterio7, 2);
        configurarRadioButton(rdBtnCriterio75, tgCriterio7, 1);

        configurarRadioButton(rdBtnCriterio81, tgCriterio8, 5);
        configurarRadioButton(rdBtnCriterio82, tgCriterio8, 4);
        configurarRadioButton(rdBtnCriterio83, tgCriterio8, 3);
        configurarRadioButton(rdBtnCriterio84, tgCriterio8, 2);
        configurarRadioButton(rdBtnCriterio85, tgCriterio8, 1);

        configurarRadioButton(rdBtnCriterio91, tgCriterio9, 5);
        configurarRadioButton(rdBtnCriterio92, tgCriterio9, 4);
        configurarRadioButton(rdBtnCriterio93, tgCriterio9, 3);
        configurarRadioButton(rdBtnCriterio94, tgCriterio9, 2);
        configurarRadioButton(rdBtnCriterio95, tgCriterio9, 1);

        configurarRadioButton(rdBtnCriterio101, tgCriterio10, 5);
        configurarRadioButton(rdBtnCriterio102, tgCriterio10, 4);
        configurarRadioButton(rdBtnCriterio103, tgCriterio10, 3);
        configurarRadioButton(rdBtnCriterio104, tgCriterio10, 2);
        configurarRadioButton(rdBtnCriterio105, tgCriterio10, 1);

        configurarListener(tgCriterio1, valorCriterio, 0);
        configurarListener(tgCriterio2, valorCriterio, 1);
        configurarListener(tgCriterio3, valorCriterio, 2);
        configurarListener(tgCriterio4, valorCriterio, 3);
        configurarListener(tgCriterio5, valorCriterio, 4);
        configurarListener(tgCriterio6, valorCriterio, 5);
        configurarListener(tgCriterio7, valorCriterio, 6);
        configurarListener(tgCriterio8, valorCriterio, 7);
        configurarListener(tgCriterio9, valorCriterio, 8);
        configurarListener(tgCriterio10, valorCriterio, 9);
    }

    private void guardarAutoevaluacion() {
        // TODO
    }

    public void btnClicSubir(ActionEvent actionEvent) {
        boolean confirmado = Utilidad.crearAlertaConfirmacion(
                "Subir autoevaluación",
                "¿Estás seguro de que deseas subir la autoevaluación?\n" +
                        "Verifica que los datos sean correctos."
        );

        if(confirmado) {
            guardarAutoevaluacion();
        }
    }

    public void btnClicCancelar(ActionEvent actionEvent) {
        boolean confirmado = Utilidad.confirmarCancelar();

        if(confirmado) {
            Utilidad.cerrarVentana(btnCancelar);
        }
    }

    public void btnClicRegresar(ActionEvent actionEvent) {
        Utilidad.cerrarVentana(lbDepartamento);
    }
}
