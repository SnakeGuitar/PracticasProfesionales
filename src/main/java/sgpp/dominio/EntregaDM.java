/*
 * Autor original: Abel Hernandez Yong
 * Último autor: Abel Hernandez Yong
 * Fecha de creación: 16-06-2025
 * Fecha de la última versión aprobada:S/F
 * Fecha de la última modificación: 16-06-2025
 * Descripción: Clase de dominio para la entidad Documento Inicial
 */

/*
 * Estado: Creado
 * Modificaciones:
 */

package sgpp.dominio;

import sgpp.modelo.beans.expediente.EntregaDocumento;

public class EntregaDM {

    public static ResultadoValidacion esUnRangoCorrecto(EntregaDocumento entrega) {
        ResultadoValidacion resultado = new ResultadoValidacion();
        if (entrega != null) {
            if (entrega.getFechaLimite().isAfter(entrega.getFechaApertura())) {
                resultado.setValido(true);
            } else {
                resultado.setValido(false);
                resultado.setMensaje("La fecha de apertura no puede ser posterior a la fecha limite");
            }
        } else {
            resultado.setValido(false);
            resultado.setMensaje("No se recibio una entrega");
        }
        return resultado;
    }

    public static ResultadoValidacion validarRespectoAEntregaPrevia(EntregaDocumento entregaPrevia, EntregaDocumento entrega) {
        ResultadoValidacion resultado = new ResultadoValidacion();
        if (entregaPrevia != null && entrega != null) {
            if (entrega.getFechaApertura().isAfter(entregaPrevia.getFechaLimite())) {
                resultado.setValido(true);
            } else {
                resultado.setValido(false);
                resultado.setMensaje(
                        "La fecha de apertura de esta entrega no puede ser posterior a la fecha limite de la entrega previa"
                );
            }
        } else {
            resultado.setValido(false);
            resultado.setMensaje("No se recibieron entregas");
        }
        return resultado;
    }
}