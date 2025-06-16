package sgpp.controlador.usuarios.profesor;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;
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
    public TextField txFiCalificacion1;

    @FXML
    public TextField txFiCalificacion2;

    @FXML
    public TextField txFiCalificacion3;

    @FXML
    public TextField txFiCalificacion4;

    @FXML
    public TextField txFiCalificacion5;

    @FXML
    public TextArea txArObservaciones;

    @FXML
    public Label lbPromedio;

    private int[] calificaciones;

    public void inicializarInformacion(int[] valorCriterio) {
        calificaciones = valorCriterio;

        txFiCalificacion1.setText(String.valueOf(calificaciones[0]));
        txFiCalificacion2.setText(String.valueOf(calificaciones[1]));
        txFiCalificacion3.setText(String.valueOf(calificaciones[2]));
        txFiCalificacion4.setText(String.valueOf(calificaciones[3]));
        txFiCalificacion5.setText(String.valueOf(calificaciones[4]));

        obtenerPromedio();
    }

    private void obtenerPromedio() {
        int promedio = 0;

        for (int calificacion : calificaciones) {
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

        // TODO: Obtener y asignar ID de Estudiante, Profesor y Periodo.

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
        // TODO
    }
}
