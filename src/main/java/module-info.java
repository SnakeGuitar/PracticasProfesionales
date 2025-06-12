module com.sgpp.sistemagestionpracticasprofesionales {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;
    requires java.desktop;

    opens sgpp.controlador to javafx.fxml;

    opens sgpp.controlador.usuarios.coordinador to javafx.fxml;
    opens sgpp.controlador.usuarios.estudiante to javafx.fxml;
    opens sgpp.controlador.usuarios.profesor to javafx.fxml;

    opens sgpp.controlador.usuarios.coordinador.organizacionvinculada to javafx.fxml;

    // Paquete usuarios
    exports sgpp.controlador.usuarios.coordinador to javafx.fxml;
    exports sgpp.controlador.usuarios.estudiante to javafx.fxml;
    exports sgpp.controlador.usuarios.profesor to javafx.fxml;

    exports sgpp.controlador.usuarios.coordinador.organizacionvinculada to javafx.fxml;


    // Paquete de aplicación principal
    exports sgpp;
}