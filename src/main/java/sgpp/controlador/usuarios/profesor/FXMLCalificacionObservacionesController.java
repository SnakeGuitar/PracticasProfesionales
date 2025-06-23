package sgpp.controlador.usuarios.profesor;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import sgpp.modelo.beans.Profesor;
import sgpp.modelo.beans.expediente.presentacion.Evaluador;
import sgpp.modelo.beans.expediente.presentacion.RubricaPresentacion;
import sgpp.modelo.dao.entidades.EstudianteDAO;
import sgpp.modelo.dao.entidades.ProfesorDAO;
import sgpp.modelo.dao.expediente.presentacion.RubricaPresentacionDAO;
import sgpp.utilidad.DocumentoRubrica;
import sgpp.utilidad.Utilidad;
import sgpp.utilidad.UtilidadFormatoDeDatos;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
        slider.setValue(valor);

        slider.setMax(valor);
        slider.setMin(valor - 1);

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
        Evaluador evaluador = new Evaluador();
        evaluador.setIdEvaluador(profesor.getIdProfesor());
        evaluador.setNombre(profesor.getNombre());
        evaluador.setNumeroPersonal(profesor.getNumeroPersonal());

        rubrica.setEvaluador(evaluador);

        boolean exitoso = RubricaPresentacionDAO.insertar(rubrica);

        if(exitoso) {
            // TODO: Generar y descargar documento.
            Utilidad.crearAlertaInformacion("Registro exitoso",
                    "Registro de rúbrica exitosa.");
            descargarRubrica(rubrica);
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

    private void descargarRubrica(RubricaPresentacion rubrica) {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Descargar documento");

        //Generar un nombre apropiado

        String nombreSugerido = String.format(
                "Evaluacion_%s_%s.pdf",
                recuperarNombreEstudiante().replace(" ", ""),
                rubrica.getFechaHora().format(DateTimeFormatter.ofPattern("dd_MM_yyyy")));
        //Configurar el filechooser
        fileChooser.setInitialFileName(nombreSugerido);
        fileChooser.getExtensionFilters().add(
                new FileChooser.ExtensionFilter("Documento PDF", "*.pdf"));

        Stage stage = Utilidad.getEscenarioComponente(lbPromedio);
        File destino = fileChooser.showSaveDialog(stage);

        //Guardar el archivo en el destino
        try {
            byte[] pdf = DocumentoRubrica.generarRubricaEvaluacion(rubrica);
            Files.write(destino.toPath(), pdf);
            Utilidad.crearAlertaInformacion(
                    "Exito",
                    "Documento descargado exitosamente a: \n"+destino.getAbsolutePath()
            );
        } catch (IOException ioex) {
            System.out.println(ioex.getMessage());
            Utilidad.crearAlertaError(
                    "Error",
                    "Lo sentimos, no fue posible guardar la rubrica en su dispositivo");
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

    private String recuperarNombreEstudiante () {
        String nombreEstudiante = "NombreFaltante";
        try {
            nombreEstudiante = EstudianteDAO.obtenerPorId(idEstudiante).getNombre();
        } catch (SQLException sqlex) {
            System.out.println("Error al recuperar el nombre del estudiante "+sqlex.getMessage());
        }
        return nombreEstudiante;
    }
}
