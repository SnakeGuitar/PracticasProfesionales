/*
 * Autor original: Diego Iván Enríquez Morales
 * Último autor: Abel Yong
 * Fecha de creación: 15-06-2025
 * Descripción: Controlador para calificar (un poco) más a detalle e ingresar observaciones para la evaluación de la presentación oral del estudiante.
 */

package sgpp.controlador.usuarios.profesor;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.Slider;
import javafx.scene.control.TextArea;
import sgpp.modelo.beans.Profesor;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;
import sgpp.modelo.dao.entidades.ProfesorDAO;
import sgpp.modelo.dao.expediente.presentacion.RubricaPresentacionDAO;
import sgpp.utilidad.Impresora;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

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
    @FXML
    public Label lbContadorCaracteres;

    private float[] calificaciones;

    private int idEstudiante = 0, idProfesor = 0, idPeriodo = 0;

    public void inicializarInformacion(float[] valorCriterio, int idProfesor, int idEstudiante, int idPeriodo) {
        this.idEstudiante = idEstudiante;
        this.idProfesor = idProfesor;
        this.idPeriodo = idPeriodo;

        this.calificaciones = valorCriterio;

        Slider[] sliders = {sldCalificacion1, sldCalificacion2, sldCalificacion3, sldCalificacion4, sldCalificacion5};

        for(int i = 0; i < sliders.length; i++) {
            configurarSlider(sliders[i], calificaciones[i], i);
        }

        obtenerPromedio();
        configurarTextArea(txArObservaciones, lbContadorCaracteres);
    }

    public void configurarTextArea(TextArea textArea, Label labelContador) {
        this.txArObservaciones = textArea;
        this.lbContadorCaracteres = labelContador;

        UtilidadFormatoDeDatos.configurarTextAreaConFormatter(txArObservaciones, lbContadorCaracteres, 500);
    }

    private void configurarSlider(Slider slider, float valor, int indice) {
        slider.setMax(valor);
        slider.setMin(valor - 1);

        slider.setValue(valor);

        slider.valueProperty().addListener((observable, oldValue, newValue) -> {
            float valorRedondeado = redondearValor(newValue.floatValue(), valor);

            calificaciones[indice] = valorRedondeado;

            obtenerPromedio();
        });
    }

    private float redondearValor(float valor, float valorMaximo) {
        if (valor >= valorMaximo - 0.25) {
            return valorMaximo;
        } else if (valor >= valorMaximo - 0.75) {
            return (float) (valorMaximo - 0.5);
        } else {
            return valorMaximo - 1;
        }
    }

    private void obtenerPromedio() {
        float promedio = 0;

        for (float calificacion : calificaciones) {
            promedio += calificacion;
        }

        promedio /= calificaciones.length;

        lbPromedio.setText(String.format("%.2f", promedio));
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

        rubrica.setEvaluador(profesor);

        boolean exitoso = RubricaPresentacionDAO.insertar(rubrica);

        if(exitoso) {
            Utilidad.crearAlertaInformacion("Registro exitoso",
                    "Registro de rúbrica exitosa.");
            Impresora.descargarRubrica(rubrica, lbPromedio, idEstudiante);
            Utilidad.cerrarVentana(lbPromedio);
        } else {
            Utilidad.crearAlertaError("Error",
                    "No se pudo registrar la rúbrica.");
            Utilidad.cerrarVentana(lbPromedio);
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
        Utilidad.cancelarOperacion(btnCancelar);
    }

    public void btnClicRegresar(ActionEvent actionEvent) {
        Utilidad.cerrarVentana(lbPromedio);
    }
}
