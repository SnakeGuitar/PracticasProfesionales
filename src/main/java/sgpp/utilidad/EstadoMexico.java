/*
 * Autor: Luis Donaldo
 * Fecha de creación: 25-06-2025
 * Descripción: Enum que define los estados de México y sus ciudades principales.
 */

package sgpp.utilidad;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Enum que representa los estados de México con sus ciudades principales.
 * Proporciona type safety y métodos utilitarios para manejo de datos geográficos.
 */
public enum EstadoMexico {
    AGUASCALIENTES("Aguascalientes", "AGS",
            List.of("Aguascalientes", "Calvillo", "Rincón de Romos", "Jesús María")),

    BAJA_CALIFORNIA("Baja California", "BC",
            List.of("Tijuana", "Mexicali", "Ensenada", "Tecate", "Playas de Rosarito")),

    BAJA_CALIFORNIA_SUR("Baja California Sur", "BCS",
            List.of("La Paz", "Los Cabos", "Comondú", "Mulegé")),

    CAMPECHE("Campeche", "CAM",
            List.of("Campeche", "Ciudad del Carmen", "Champotón", "Escárcega")),

    CHIAPAS("Chiapas", "CHIS",
            List.of("Tuxtla Gutiérrez", "Tapachula", "San Cristóbal de las Casas", "Comitán")),

    CHIHUAHUA("Chihuahua", "CHIH",
            List.of("Ciudad Juárez", "Chihuahua", "Delicias", "Hidalgo del Parral", "Cuauhtémoc")),

    CIUDAD_DE_MEXICO("Ciudad de México", "CDMX",
            List.of("Álvaro Obregón", "Coyoacán", "Cuauhtémoc", "Benito Juárez",
                    "Miguel Hidalgo", "Venustiano Carranza", "Gustavo A. Madero",
                    "Iztapalapa", "Tlalpan", "Xochimilco")),

    COAHUILA("Coahuila", "COAH",
            List.of("Saltillo", "Torreón", "Monclova", "Piedras Negras", "Acuña")),

    COLIMA("Colima", "COL",
            List.of("Colima", "Manzanillo", "Tecomán", "Villa de Álvarez")),

    DURANGO("Durango", "DGO",
            List.of("Durango", "Gómez Palacio", "Lerdo", "Santiago Papasquiaro")),

    ESTADO_DE_MEXICO("Estado de México", "MEX",
            List.of("Ecatepec de Morelos", "Nezahualcóyotl", "Naucalpan de Juárez",
                    "Tlalnepantla de Baz", "Chimalhuacán", "Cuautitlán Izcalli",
                    "Toluca", "Atizapán de Zaragoza", "Nicolás Romero")),

    GUANAJUATO("Guanajuato", "GTO",
            List.of("León", "Irapuato", "Celaya", "Salamanca", "Guanajuato",
                    "San Miguel de Allende", "Dolores Hidalgo", "Silao")),

    GUERRERO("Guerrero", "GRO",
            List.of("Acapulco", "Chilpancingo", "Iguala", "Taxco", "Zihuatanejo")),

    HIDALGO("Hidalgo", "HGO",
            List.of("Pachuca", "Tulancingo", "Tizayuca", "Huejutla")),

    JALISCO("Jalisco", "JAL",
            List.of("Guadalajara", "Zapopan", "Tlaquepaque", "Tonalá", "Puerto Vallarta",
                    "Tlajomulco de Zúñiga", "El Salto", "Tepatitlán")),

    MICHOACAN("Michoacán", "MICH",
            List.of("Morelia", "Uruapan", "Zamora", "Lázaro Cárdenas", "Apatzingán")),

    MORELOS("Morelos", "MOR",
            List.of("Cuernavaca", "Jiutepec", "Temixco", "Cuautla")),

    NAYARIT("Nayarit", "NAY",
            List.of("Tepic", "Bahía de Banderas", "Santiago Ixcuintla", "Compostela")),

    NUEVO_LEON("Nuevo León", "NL",
            List.of("Monterrey", "San Pedro Garza García", "Guadalupe",
                    "San Nicolás de los Garza", "Escobedo", "Santa Catarina",
                    "Apodaca", "García")),

    OAXACA("Oaxaca", "OAX",
            List.of("Oaxaca de Juárez", "Salina Cruz", "Tuxtepec", "Juchitán")),

    PUEBLA("Puebla", "PUE",
            List.of("Puebla", "Tehuacán", "San Martín Texmelucan", "Atlixco",
                    "San Pedro Cholula", "Teziutlán")),

    QUERETARO("Querétaro", "QRO",
            List.of("Santiago de Querétaro", "San Juan del Río", "Corregidora", "El Marqués")),

    QUINTANA_ROO("Quintana Roo", "QROO",
            List.of("Cancún", "Chetumal", "Playa del Carmen", "Cozumel")),

    SAN_LUIS_POTOSI("San Luis Potosí", "SLP",
            List.of("San Luis Potosí", "Soledad de Graciano Sánchez", "Ciudad Valles", "Matehuala")),

    SINALOA("Sinaloa", "SIN",
            List.of("Culiacán", "Mazatlán", "Los Mochis", "Guasave")),

    SONORA("Sonora", "SON",
            List.of("Hermosillo", "Ciudad Obregón", "Nogales", "San Luis Río Colorado", "Navojoa")),

    TABASCO("Tabasco", "TAB",
            List.of("Villahermosa", "Cárdenas", "Comalcalco", "Huimanguillo")),

    TAMAULIPAS("Tamaulipas", "TAMS",
            List.of("Reynosa", "Matamoros", "Nuevo Laredo", "Tampico", "Ciudad Victoria")),

    TLAXCALA("Tlaxcala", "TLAX",
            List.of("Tlaxcala", "Apizaco", "Huamantla", "Santa Ana Chiautempan")),

    VERACRUZ("Veracruz", "VER",
            List.of("Veracruz", "Xalapa", "Coatzacoalcos", "Córdoba", "Minatitlán",
                    "Poza Rica de Hidalgo", "Orizaba", "Tuxpan")),

    YUCATAN("Yucatán", "YUC",
            List.of("Mérida", "Kanasín", "Umán", "Progreso", "Valladolid")),

    ZACATECAS("Zacatecas", "ZAC",
            List.of("Zacatecas", "Fresnillo", "Guadalupe", "Jerez"));

    private final String nombre;
    private final String codigo;
    private final List<String> ciudades;

    EstadoMexico(String nombre, String codigo, List<String> ciudades) {
        this.nombre = nombre;
        this.codigo = codigo;
        this.ciudades = List.copyOf(ciudades);
    }

    public String getNombre() {
        return nombre;
    }

    public String getCodigo() {
        return codigo;
    }

    public List<String> getCiudades() {
        return ciudades;
    }

    /**
     * Obtiene todos los nombres de estados ordenados alfabéticamente.
     *
     * @return Lista de nombres de estados
     */
    public static List<String> obtenerTodosLosNombres() {
        return Arrays.stream(values())
                .map(EstadoMexico::getNombre)
                .sorted()
                .collect(Collectors.toList());
    }

    /**
     * Busca un estado por su nombre.
     *
     * @param nombre Nombre del estado
     * @return Optional con el estado encontrado
     */
    public static Optional<EstadoMexico> buscarPorNombre(String nombre) {
        return Arrays.stream(values())
                .filter(estado -> estado.getNombre().equalsIgnoreCase(nombre))
                .findFirst();
    }
}