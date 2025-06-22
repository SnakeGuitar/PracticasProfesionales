package sgpp.controlador.usuarios.profesor;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import sgpp.modelo.beans.Profesor;
import sgpp.modelo.beans.expediente.presentacion.Evaluador;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;
import sgpp.modelo.dao.entidades.ProfesorDAO;
import sgpp.modelo.dao.expediente.presentacion.RubricaPresentacionDAO;
import sgpp.utilidad.Utilidad;

import java.sql.SQLException;
import java.time.LocalDateTime;

public class FXMLCalificacionObservacionesController {

    @FXML
    public Button btnSubir;

    @FXML
    public Button btnCancelar;

    @FXML
    public Button btnRegresar;

    @FXML
    public TextArea txArObservaciones;

    @FXML
    public Label lbPromedio;
    @FXML
    public Slider sldCalificacion1;
    @FXML
    public Slider sldCalificacion2;
    @FXML
    public Slider sldCalificacion3;
    @FXML
    public Slider sldCalificacion4;
    @FXML
    public Slider sldCalificacion5;

    private float[] calificaciones;

    private int idEstudiante = 0, idProfesor = 0, idPeriodo = 0;

    public void inicializarInformacion(float[] valorCriterio, int idProfesor, int idEstudiante, int idPeriodo) {
        this.idEstudiante = idEstudiante;
        this.idProfesor = idProfesor;
        this.idPeriodo = idPeriodo;

        this.calificaciones = valorCriterio;

        Slider[] sliders = {sldCalificacion1, sldCalificacion2, sldCalificacion3, sldCalificacion4, sldCalificacion5};

        for(int i = 0; i < sliders.length; i++) {
            configurarSlider(sliders[i], calificaciones[i]);
        }

        obtenerPromedio();
    }

    private void configurarSlider(Slider slider, float valor) {
        slider.setValue(valor);

        slider.setMax(valor);
        slider.setMin(valor - 1);

        slider.valueProperty().addListener((observable, oldValue, newValue) -> {
            obtenerPromedio();
        });
    }

    private void obtenerPromedio() {
        float promedio = 0;

        for (float calificacion : calificaciones) {
            promedio += calificacion;
        }

        promedio /= 5;

        lbPromedio.setText(String.valueOf(promedio));
    }

    private void guardarRubricaPresentacion() throws SQLException {
        RubricaPresentacion rubrica = new RubricaPresentacion();

        rubrica.setFechaHora(LocalDateTime.now());
        rubrica.setCalificacion(Float.parseFloat(lbPromedio.getText()));
        rubrica.setObservaciones(txArObservaciones.getText());
        rubrica.setIdEstudiante(idEstudiante);
        rubrica.setIdProfesor(idProfesor);
        rubrica.setIdPeriodo(idPeriodo);
        rubrica.setCriterios(calificaciones);

        Profesor profesor = ProfesorDAO.obtenerPorId(idProfesor);
        Evaluador evaluador = new Evaluador();
        evaluador.setIdEvaluador(profesor.getIdProfesor());
        evaluador.setNombre(profesor.getNombre());
        evaluador.setNumeroPersonal(profesor.getNumeroPersonal());

        rubrica.setEvaluador(evaluador);

        boolean exitoso = RubricaPresentacionDAO.insertar(rubrica);

        if(exitoso) {
            Utilidad.crearAlertaInformacion("Registro exitoso",
                    "Registro de rúbrica exitosa.");
        } else {
            Utilidad.crearAlertaError("Error",
                    "No se pudo registrar la rúbrica.");
        }
    }

    public void btnClicSubir(ActionEvent actionEvent) throws SQLException {
        boolean confirmado = Utilidad.crearAlertaConfirmacion(
                "Subir rúbrica",
                "¿Estás seguro de que deseas subir la rúbrica?\n" +
                        "Verifica que los datos sean correctos."
        );

        if(confirmado) {
            guardarRubricaPresentacion();
        }
    }

    public void btnClicCancelar(ActionEvent actionEvent) {
        boolean confirmado = Utilidad.confirmarCancelar();

        if(confirmado) {
            Utilidad.cerrarVentana(lbPromedio);
        }
    }

    public void btnClicRegresar(ActionEvent actionEvent) {
        Utilidad.cerrarVentana(lbPromedio);
    }
}
