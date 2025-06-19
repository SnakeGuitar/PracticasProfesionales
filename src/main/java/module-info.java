module com.sgpp.sistemagestionpracticasprofesionales {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;
    requires java.desktop;
    requires java.base;

    opens sgpp.controlador to javafx.fxml;

    opens sgpp.controlador.usuarios.coordinador to javafx.fxml;
    opens sgpp.controlador.usuarios.estudiante to javafx.fxml;
    opens sgpp.controlador.usuarios.profesor to javafx.fxml;

    opens sgpp.controlador.usuarios.coordinador.organizacionvinculada to javafx.fxml;
    opens sgpp.controlador.usuarios.coordinador.proyecto to javafx.fxml;
    opens sgpp.controlador.usuarios.coordinador.responsabletecnico to javafx.fxml;
    opens sgpp.controlador.usuarios.estudiante.documentopracticas to javafx.fxml;

    opens sgpp.modelo.beans to javafx.base;

    // Paquete usuarios
    exports sgpp.controlador.usuarios.coordinador to javafx.fxml;
    exports sgpp.controlador.usuarios.estudiante to javafx.fxml;
    exports sgpp.controlador.usuarios.profesor to javafx.fxml;

    exports sgpp.controlador.usuarios.coordinador.organizacionvinculada to javafx.fxml;
    exports sgpp.controlador.usuarios.coordinador.proyecto to javafx.fxml;
    exports sgpp.controlador.usuarios.coordinador.responsabletecnico to javafx.fxml;
    exports sgpp.controlador.usuarios.estudiante.documentopracticas to javafx.fxml;

    exports sgpp.modelo.beans to javafx.fxml;

    // Paquete de aplicación principal
    exports sgpp;
    requires org.apache.pdfbox;
}