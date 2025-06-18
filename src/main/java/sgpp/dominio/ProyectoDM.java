/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 15-06-2025
 * Fecha de la última versión aprobada:S/F
 * Fecha de la última modificación: 15-06-2025 15:54
 * Descripción: Clase de dominio para la entidad Proyecto
 */

/*
 * Estado: Creado
 * Modificaciones:
 */

package sgpp.dominio;

import java.time.LocalDate;

public class ProyectoDM {

    //Validar que el numero de participantes es positivo y que no inicia despues de terminar
    public static ResultadoValidacion validarParticipantes(int maxParticipantes) {
        ResultadoValidacion resultado = new ResultadoValidacion();
        if (maxParticipantes <= 0) {
            resultado.setValido(false);
            resultado.setMensaje("El numero de participantes debe ser mayor que 0");
        } else {
            resultado.setValido(true);
        }
        return resultado;
    }

    public static ResultadoValidacion validarFechaInicio(LocalDate fechaInicio, LocalDate fechaFin) {
        ResultadoValidacion resultado = new ResultadoValidacion();
        if (fechaInicio.isAfter(fechaFin)) {
            resultado.setValido(false);
            resultado.setMensaje("La fecha de inicio no puede ser posterior a la fecha de finalizacion");
        } else {
            resultado.setValido(true);
        }
        return resultado;
    }

    public static ResultadoValidacion validarFechaFin(LocalDate fechaInicio, LocalDate fechaFin) {
        ResultadoValidacion resultado = new ResultadoValidacion();
        if (fechaFin.isBefore(LocalDate.now()) || fechaFin.isEqual(LocalDate.now()) ) {
            resultado.setValido(false);
            resultado.setMensaje("La fecha de finalizacion no puede ser igual o anterior a hoy");
        } else  {
            resultado.setValido(true);
        }
        return resultado;
    }
}