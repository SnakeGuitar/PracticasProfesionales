package test.organizacionvinculada;

import org.junit.Test;
import org.junit.jupiter.api.DisplayName;
import sgpp.dominio.OrganizacionVinculadaDM;

import static org.junit.Assert.*;

public class OrganizacionVinculadaDMTest {
    // Pruebas para validarLongitudNombre
    @Test
    @DisplayName("Validar nombre con longitud válida")
    public void testValidarLongitudNombre_LongitudValida() {
        assertTrue(OrganizacionVinculadaDM.validarLongitudNombre("Organización ABC"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudNombre("A"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudNombre(""));
    }

    @Test
    @DisplayName("Validar nombre con longitud exacta de 100 caracteres")
    public void testValidarLongitudNombre_LongitudExacta100() {
        String nombre100 = "A".repeat(100);
        assertTrue(OrganizacionVinculadaDM.validarLongitudNombre(nombre100));
    }

    @Test
    @DisplayName("Validar nombre con longitud mayor a 100 caracteres")
    public void testValidarLongitudNombre_LongitudInvalida() {
        String nombre101 = "A".repeat(101);
        assertFalse(OrganizacionVinculadaDM.validarLongitudNombre(nombre101));

        String nombre150 = "A".repeat(150);
        assertFalse(OrganizacionVinculadaDM.validarLongitudNombre(nombre150));
    }

    // Pruebas para validarLongitudTelefono
    @Test
    @DisplayName("Validar teléfono con longitud válida de 10 dígitos")
    public void testValidarLongitudTelefono_LongitudValida() {
        assertTrue(OrganizacionVinculadaDM.validarLongitudTelefono("1234567890"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudTelefono("9876543210"));
    }

    @Test
    @DisplayName("Validar teléfono con longitud inválida")
    public void testValidarLongitudTelefono_LongitudInvalida() {
        // Menos de 10 dígitos
        assertFalse(OrganizacionVinculadaDM.validarLongitudTelefono("123456789"));
        assertFalse(OrganizacionVinculadaDM.validarLongitudTelefono("123"));
        assertFalse(OrganizacionVinculadaDM.validarLongitudTelefono(""));

        // Más de 10 dígitos
        assertFalse(OrganizacionVinculadaDM.validarLongitudTelefono("12345678901"));
        assertFalse(OrganizacionVinculadaDM.validarLongitudTelefono("123456789012"));
    }

    // Pruebas para validarLongitudCorreo
    @Test
    @DisplayName("Validar correo con longitud válida")
    public void testValidarLongitudCorreo_LongitudValida() {
        assertTrue(OrganizacionVinculadaDM.validarLongitudCorreo("test@example.com"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudCorreo(""));
        assertTrue(OrganizacionVinculadaDM.validarLongitudCorreo("a@b.co"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudCorreo("usuario@dominio.org"));
    }

    @Test
    @DisplayName("Validar correo con longitud exacta de 50 caracteres")
    public void testValidarLongitudCorreo_LongitudExacta50() {
        String correo50 = "test@" + "a".repeat(40) + ".com"; // 50 caracteres exactos
        assertTrue(OrganizacionVinculadaDM.validarLongitudCorreo(correo50));
    }

    @Test
    @DisplayName("Validar correo con longitud mayor a 50 caracteres")
    public void testValidarLongitudCorreo_LongitudInvalida() {
        String correo51 = "test@" + "a".repeat(42) + ".com"; // 51 caracteres
        assertFalse(OrganizacionVinculadaDM.validarLongitudCorreo(correo51));

        String correo100 = "test@" + "a".repeat(90) + ".com"; // 100 caracteres
        assertFalse(OrganizacionVinculadaDM.validarLongitudCorreo(correo100));
    }

    // Pruebas para validarLongitudDireccion
    @Test
    @DisplayName("Validar dirección con longitud válida")
    public void testValidarLongitudDireccion_LongitudValida() {
        assertTrue(OrganizacionVinculadaDM.validarLongitudDireccion("Calle Principal 123"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudDireccion(""));
        assertTrue(OrganizacionVinculadaDM.validarLongitudDireccion("Av. Independencia #45, Col. Centro"));
    }

    @Test
    @DisplayName("Validar dirección con longitud exacta de 100 caracteres")
    public void testValidarLongitudDireccion_LongitudExacta100() {
        String direccion100 = "A".repeat(100);
        assertTrue(OrganizacionVinculadaDM.validarLongitudDireccion(direccion100));
    }

    @Test
    @DisplayName("Validar dirección con longitud mayor a 100 caracteres")
    public void testValidarLongitudDireccion_LongitudInvalida() {
        String direccion101 = "A".repeat(101);
        assertFalse(OrganizacionVinculadaDM.validarLongitudDireccion(direccion101));

        String direccion200 = "A".repeat(200);
        assertFalse(OrganizacionVinculadaDM.validarLongitudDireccion(direccion200));
    }

    // Pruebas para validarLongitudCiudad
    @Test
    @DisplayName("Validar ciudad con longitud válida")
    public void testValidarLongitudCiudad_LongitudValida() {
        assertTrue(OrganizacionVinculadaDM.validarLongitudCiudad("México"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudCiudad(""));
        assertTrue(OrganizacionVinculadaDM.validarLongitudCiudad("Guadalajara"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudCiudad("Ciudad de México"));
    }

    @Test
    @DisplayName("Validar ciudad con longitud exacta de 50 caracteres")
    public void testValidarLongitudCiudad_LongitudExacta50() {
        String ciudad50 = "A".repeat(50);
        assertTrue(OrganizacionVinculadaDM.validarLongitudCiudad(ciudad50));
    }

    @Test
    @DisplayName("Validar ciudad con longitud mayor a 50 caracteres")
    public void testValidarLongitudCiudad_LongitudInvalida() {
        String ciudad51 = "A".repeat(51);
        assertFalse(OrganizacionVinculadaDM.validarLongitudCiudad(ciudad51));

        String ciudad75 = "A".repeat(75);
        assertFalse(OrganizacionVinculadaDM.validarLongitudCiudad(ciudad75));
    }

    // Pruebas para validarLongitudEstado
    @Test
    @DisplayName("Validar estado con longitud válida")
    public void testValidarLongitudEstado_LongitudValida() {
        assertTrue(OrganizacionVinculadaDM.validarLongitudEstado("Veracruz"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudEstado(""));
        assertTrue(OrganizacionVinculadaDM.validarLongitudEstado("Jalisco"));
        assertTrue(OrganizacionVinculadaDM.validarLongitudEstado("Estado de México"));
    }

    @Test
    @DisplayName("Validar estado con longitud exacta de 50 caracteres")
    public void testValidarLongitudEstado_LongitudExacta50() {
        String estado50 = "A".repeat(50);
        assertTrue(OrganizacionVinculadaDM.validarLongitudEstado(estado50));
    }

    @Test
    @DisplayName("Validar estado con longitud mayor a 50 caracteres")
    public void testValidarLongitudEstado_LongitudInvalida() {
        String estado51 = "A".repeat(51);
        assertFalse(OrganizacionVinculadaDM.validarLongitudEstado(estado51));

        String estado100 = "A".repeat(100);
        assertFalse(OrganizacionVinculadaDM.validarLongitudEstado(estado100));
    }

    // Pruebas para verificarSector
    @Test
    @DisplayName("Verificar sector válido en mayúsculas")
    public void testVerificarSector_SectorValidoMayusculas() {
        assertTrue(OrganizacionVinculadaDM.verificarSector("PUBLICO"));
        assertTrue(OrganizacionVinculadaDM.verificarSector("PRIVADO"));
        assertTrue(OrganizacionVinculadaDM.verificarSector("SOCIAL"));
    }

    @Test
    @DisplayName("Verificar sector válido en minúsculas")
    public void testVerificarSector_SectorValidoMinusculas() {
        assertTrue(OrganizacionVinculadaDM.verificarSector("publico"));
        assertTrue(OrganizacionVinculadaDM.verificarSector("privado"));
        assertTrue(OrganizacionVinculadaDM.verificarSector("social"));
    }

    @Test
    @DisplayName("Verificar sector válido con capitalización mixta")
    public void testVerificarSector_SectorValidoMixto() {
        assertTrue(OrganizacionVinculadaDM.verificarSector("Publico"));
        assertTrue(OrganizacionVinculadaDM.verificarSector("Privado"));
        assertTrue(OrganizacionVinculadaDM.verificarSector("Social"));
        assertTrue(OrganizacionVinculadaDM.verificarSector("pUbLiCo"));
        assertTrue(OrganizacionVinculadaDM.verificarSector("PrIvAdO"));
    }

    @Test
    @DisplayName("Verificar sector inválido")
    public void testVerificarSector_SectorInvalido() {
        assertFalse(OrganizacionVinculadaDM.verificarSector("GUBERNAMENTAL"));
        assertFalse(OrganizacionVinculadaDM.verificarSector("COMERCIAL"));
        assertFalse(OrganizacionVinculadaDM.verificarSector("ONG"));
        assertFalse(OrganizacionVinculadaDM.verificarSector(""));
        assertFalse(OrganizacionVinculadaDM.verificarSector("INVALID"));
        assertFalse(OrganizacionVinculadaDM.verificarSector("PUBLICO "));
        assertFalse(OrganizacionVinculadaDM.verificarSector(" PUBLICO"));
    }

    // Pruebas para verificarFormatoCorreo
    @Test
    @DisplayName("Verificar formato de correo válido")
    public void testVerificarFormatoCorreo_FormatoValido() {
        assertTrue(OrganizacionVinculadaDM.verificarFormatoCorreo("test@example.com"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoCorreo("usuario@dominio.org"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoCorreo("nombre.apellido@empresa.mx"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoCorreo("user123@test-domain.co.uk"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoCorreo("a@b.co"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoCorreo("correo_usuario@dominio.net"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoCorreo("usuario-test@ejemplo.com.mx"));
    }

    @Test
    @DisplayName("Verificar formato de correo inválido")
    public void testVerificarFormatoCorreo_FormatoInvalido() {
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo("correo-sin-arroba.com"));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo("@dominio.com"));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo("usuario@"));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo("usuario@dominio"));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo("usuario@dominio."));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo(""));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo("usuario espacios@dominio.com"));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo("usuario@dom inio.com"));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo("usuario@@dominio.com"));
    }


    // Pruebas para verificarFormatoTelefono
    @Test
    @DisplayName("Verificar formato de teléfono válido")
    public void testVerificarFormatoTelefono_FormatoValido() {
        assertTrue(OrganizacionVinculadaDM.verificarFormatoTelefono("1234567890"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoTelefono("0123456789"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoTelefono("9876543210"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoTelefono("2281234567"));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoTelefono("5555555555"));
    }

    @Test
    @DisplayName("Verificar formato de teléfono inválido")
    public void testVerificarFormatoTelefono_FormatoInvalido() {
        // Longitud incorrecta
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("123456789"));      // 9 dígitos
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("12345678901"));    // 11 dígitos
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono(""));               // Vacío
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("123"));            // Muy corto

        // Formato incorrecto
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("123-456-7890"));   // Con guiones
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("123 456 7890"));   // Con espacios
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("(123)456-7890"));  // Con paréntesis
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("12345abcde"));     // Con letras
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("abc1234567"));     // Letras y números
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("123.456.7890"));   // Con puntos
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono("+1234567890"));    // Con símbolo +
    }

    // Pruebas de integración - validación completa
    @Test
    @DisplayName("Validación completa de organización válida")
    public void testValidacionCompleta_OrganizacionValida() {
        String nombre = "Organización Ejemplo";
        String telefono = "2281234567";
        String correo = "contacto@org.com";
        String direccion = "Av. Principal 123";
        String ciudad = "Xalapa";
        String estado = "Veracruz";
        String sector = "PUBLICO";

        assertTrue(OrganizacionVinculadaDM.validarLongitudNombre(nombre));
        assertTrue(OrganizacionVinculadaDM.validarLongitudTelefono(telefono));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoTelefono(telefono));
        assertTrue(OrganizacionVinculadaDM.validarLongitudCorreo(correo));
        assertTrue(OrganizacionVinculadaDM.verificarFormatoCorreo(correo));
        assertTrue(OrganizacionVinculadaDM.validarLongitudDireccion(direccion));
        assertTrue(OrganizacionVinculadaDM.validarLongitudCiudad(ciudad));
        assertTrue(OrganizacionVinculadaDM.validarLongitudEstado(estado));
        assertTrue(OrganizacionVinculadaDM.verificarSector(sector));
    }

    @Test
    @DisplayName("Validación completa de organización con datos inválidos")
    public void testValidacionCompleta_OrganizacionInvalida() {
        String nombreLargo = "A".repeat(101); // Muy largo
        String telefonoCorto = "123456789";   // 9 dígitos
        String correoSinArroba = "correo.sin.arroba.com";
        String direccionLarga = "A".repeat(101);
        String ciudadLarga = "A".repeat(51);
        String estadoLargo = "A".repeat(51);
        String sectorInvalido = "GUBERNAMENTAL";

        assertFalse(OrganizacionVinculadaDM.validarLongitudNombre(nombreLargo));
        assertFalse(OrganizacionVinculadaDM.validarLongitudTelefono(telefonoCorto));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoTelefono(telefonoCorto));
        assertFalse(OrganizacionVinculadaDM.verificarFormatoCorreo(correoSinArroba));
        assertFalse(OrganizacionVinculadaDM.validarLongitudDireccion(direccionLarga));
        assertFalse(OrganizacionVinculadaDM.validarLongitudCiudad(ciudadLarga));
        assertFalse(OrganizacionVinculadaDM.validarLongitudEstado(estadoLargo));
        assertFalse(OrganizacionVinculadaDM.verificarSector(sectorInvalido));
    }
}