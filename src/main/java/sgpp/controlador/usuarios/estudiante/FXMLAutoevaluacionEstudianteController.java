package sgpp.controlador.usuarios.estudiante;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.control.ToggleGroup;
import sgpp.modelo.beans.Estudiante;
import sgpp.modelo.beans.Proyecto;
import sgpp.modelo.beans.ResponsableTecnico;
import sgpp.modelo.beans.expediente.documentofinal.AutoEvaluacion;
import sgpp.modelo.dao.entidades.*;
import sgpp.modelo.dao.expediente.documentofinal.AutoEvaluacionDAO;
import sgpp.modelo.dao.expediente.presentacion.RubricaPresentacionDAO;
import sgpp.utilidad.Utilidad;

import java.net.URL;
import java.sql.SQLException;
import java.time.LocalDateTime;
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
    public Label lbPuntuacionFinal;

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

    private ToggleGroup[] toggleGroups;

    private RadioButton[][] radioButtons;

    private int[] valorCriterio;

    private int idEstudiante = 0, idOrganizacionVinculada = 0, idResponsable = 0, idProyecto = 0, idPeriodo = 0;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        configurarCriterios();
    }

    public void inicializarInformacion(Estudiante estudiante) throws SQLException {
        this.idEstudiante = estudiante.getIdEstudiante();
        this.idPeriodo = PeriodoDAO.obtenerPeriodoActual().getIdPeriodo();
        this.idProyecto = estudiante.getIdProyecto();

        Proyecto proyecto = ProyectoDAO.obtenerPorId(idProyecto);

        this.idOrganizacionVinculada = proyecto.getIdOrganizacionVinculada();
        this.idResponsable = proyecto.getIdResponsable();

        lbNombreAlumno.setText(estudiante.getNombre());
        lbMatricula.setText(estudiante.getMatricula());
        lbOV.setText(proyecto.getNombreOV());
        lbDepartamento.setText(ResponsableTecnicoDAO.obtenerPorId(idResponsable).getDepartamento());
        lbProyecto.setText(proyecto.getNombre());
        lbResponsable.setText(proyecto.getNombreResponsable());
    }

    private void configurarCriterios() {
        valorCriterio = new int[10];

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

        toggleGroups = new ToggleGroup[] {
                tgCriterio1, tgCriterio2,
                tgCriterio3, tgCriterio4,
                tgCriterio5, tgCriterio6,
                tgCriterio7, tgCriterio8,
                tgCriterio9, tgCriterio10
        };

        radioButtons = new RadioButton[][] {
                {rdBtnCriterio11, rdBtnCriterio12, rdBtnCriterio13, rdBtnCriterio14, rdBtnCriterio15},
                {rdBtnCriterio21, rdBtnCriterio22, rdBtnCriterio23, rdBtnCriterio24, rdBtnCriterio25},
                {rdBtnCriterio31, rdBtnCriterio32, rdBtnCriterio33, rdBtnCriterio34, rdBtnCriterio35},
                {rdBtnCriterio41, rdBtnCriterio42, rdBtnCriterio43, rdBtnCriterio44, rdBtnCriterio45},
                {rdBtnCriterio51, rdBtnCriterio52, rdBtnCriterio53, rdBtnCriterio54, rdBtnCriterio55},
                {rdBtnCriterio61, rdBtnCriterio62, rdBtnCriterio63, rdBtnCriterio64, rdBtnCriterio65},
                {rdBtnCriterio71, rdBtnCriterio72, rdBtnCriterio73, rdBtnCriterio74, rdBtnCriterio75},
                {rdBtnCriterio81, rdBtnCriterio82, rdBtnCriterio83, rdBtnCriterio84, rdBtnCriterio85},
                {rdBtnCriterio91, rdBtnCriterio92, rdBtnCriterio93, rdBtnCriterio94, rdBtnCriterio95},
                {rdBtnCriterio101, rdBtnCriterio102, rdBtnCriterio103, rdBtnCriterio104, rdBtnCriterio105}
        };

        for (int criterio = 0; criterio < 10; criterio++) {
            for (int valorIndex = 0; valorIndex < 5; valorIndex++) {
                configurarRadioButton(radioButtons[criterio][valorIndex],
                        toggleGroups[criterio],
                        5 - valorIndex); // 5, 4, 3, 2, 1
            }

            configurarListener(toggleGroups[criterio], valorCriterio, criterio);
            configurarToggleGroup(toggleGroups[criterio]);
        }
    }

    private void obtenerPuntuacionFinal() {
        int puntuacionFinal = 0;

        for (int puntaje : valorCriterio) {
            puntuacionFinal += puntaje;
        }

        lbPuntuacionFinal.setText(String.valueOf(puntuacionFinal));
    }

    private void configurarToggleGroup(ToggleGroup group) {
        group.selectedToggleProperty().addListener((observable, oldValue, newValue) -> {
            obtenerPuntuacionFinal();
        });
    }

    private void guardarAutoevaluacion() throws SQLException {
        AutoEvaluacion autoevaluacion = new AutoEvaluacion();

        autoevaluacion.setFechaHora(LocalDateTime.now());
        autoevaluacion.setPuntuacionFinal(Integer.parseInt(lbPuntuacionFinal.getText()));
        autoevaluacion.setIdEstudiante(idEstudiante);
        autoevaluacion.setIdOrganizacionVinculada(idOrganizacionVinculada);
        autoevaluacion.setIdResponsable(idResponsable);
        autoevaluacion.setIdProyecto(idProyecto);
        autoevaluacion.setIdPeriodo(idPeriodo);
        autoevaluacion.setCriterios(valorCriterio);

        boolean exitoso = AutoEvaluacionDAO.insertar(autoevaluacion);

        if(exitoso) {
            Utilidad.crearAlertaInformacion("Registro exitoso",
                    "Registro de autoevaluación exitosa.");
            Utilidad.cerrarVentana(lbOV);
        } else {
            Utilidad.crearAlertaError("Error",
                    "No se pudo registrar la autoevaluación.");
        }
    }

    public void btnClicSubir(ActionEvent actionEvent) throws SQLException {
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
}
