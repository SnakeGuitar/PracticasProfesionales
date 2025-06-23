package sgpp.dominio;

import javafx.scene.control.Alert;
import sgpp.utilidad.Utilidad;

public class OrganizacionVinculadaDM {
    public static boolean validarTelefono(String telefono) {
        if (telefono.length() != 10) {
            Utilidad.crearAlerta(Alert.AlertType.WARNING,
                    "Número de teléfono inválido",
                    "El número de teléfono debe tener 10 dígitos.");
            return false;
        } else {
            try {
                Long.parseLong(telefono);
            } catch (NumberFormatException e) {
                Utilidad.crearAlerta(Alert.AlertType.WARNING,
                        "Número de teléfono inválido",
                        "El número de teléfono debe contener solo dígitos.");
                return false;
            }
        }
        return true;
    }

    public static boolean validarSector(String sector) {
        String[] sectoresValidos = {"PUBLICO", "PRIVADO", "SOCIAL"};
        for (String s : sectoresValidos) {
            if (s.equalsIgnoreCase(sector)) {
                return true;
            }
        }
        Utilidad.crearAlerta(Alert.AlertType.WARNING,
                "Sector inválido",
                "El sector debe ser uno de los siguientes: PUBLICO, PRIVADO, SOCIAL.");
        return false;
    }
}
