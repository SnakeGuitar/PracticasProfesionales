/*
 * Autor original: ChatGPT
 * Último autor: ChatGPT
 * Fecha de creación: 16-06-2025
 * Fecha de la última versión aprobada:
 * Fecha de la última modificación: 16-06-2025
 * Descripción: POJO para representar la entidad 'entrega_reporte'.
 */

/*
 * Estado: En funcionamiento
 * Modificaciones:
 */

package sgpp.modelo.beans.expediente.reporte;

import sgpp.modelo.beans.expediente.EntregaDocumento;

import java.time.LocalDateTime;

public class EntregaReporteMensual extends EntregaDocumento {
    private int idEntregaReporte;
    private int numReporte;
    private LocalDateTime fechaEntrega;

    public int getIdEntregaReporte() {
        return idEntregaReporte;
    }

    public void setIdEntregaReporte(int idEntregaReporte) {
        this.idEntregaReporte = idEntregaReporte;
    }

    public int getNumReporte() {
        return numReporte;
    }

    public void setNumReporte(int numReporte) {
        this.numReporte = numReporte;
    }

    public LocalDateTime getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(LocalDateTime fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }
}
