package sgpp.modelo.beans.expediente.documentoinicial;

import javafx.beans.property.*;
import java.time.LocalDate;

public class TablaAsignacion {

    private final IntegerProperty idEstudiante;
    private final StringProperty nombreEstudiante;
    private final StringProperty matricula;
    private final IntegerProperty idOrganizacion;
    private final StringProperty nombreOrganizacion;
    private final IntegerProperty idProyecto;
    private final StringProperty nombreProyecto;
    private final IntegerProperty idResponsable;
    private final StringProperty nombreResponsable;
    private final StringProperty direccionOrganizacion;
    private final ObjectProperty<LocalDate> fechaInicio;
    private final StringProperty puestoResponsable;
    private final StringProperty departamentoResponsable;
    private final IntegerProperty idPeriodo;
    private final BooleanProperty seleccionado = new SimpleBooleanProperty(false);

    public TablaAsignacion(int idEstudiante, String nombreEstudiante, String matricula,
                           int idOrganizacion, String nombreOrganizacion, String direccionOrganizacion,
                           int idProyecto, String nombreProyecto, LocalDate fechaInicio,
                           int idResponsable, String nombreResponsable,
                           String puestoResponsable, String departamentoResponsable,
                           int idPeriodo) {

        this.idEstudiante = new SimpleIntegerProperty(idEstudiante);
        this.nombreEstudiante = new SimpleStringProperty(nombreEstudiante);
        this.matricula = new SimpleStringProperty(matricula);
        this.idOrganizacion = new SimpleIntegerProperty(idOrganizacion);
        this.nombreOrganizacion = new SimpleStringProperty(nombreOrganizacion);
        this.direccionOrganizacion = new SimpleStringProperty(
                direccionOrganizacion != null ? direccionOrganizacion : ""
        );
        this.idProyecto = new SimpleIntegerProperty(idProyecto);
        this.nombreProyecto = new SimpleStringProperty(nombreProyecto);
        this.fechaInicio = new SimpleObjectProperty<>(
                fechaInicio != null ? fechaInicio : LocalDate.now()
        );
        this.idResponsable = new SimpleIntegerProperty(idResponsable);
        this.nombreResponsable = new SimpleStringProperty(nombreResponsable);
        this.puestoResponsable = new SimpleStringProperty(
                puestoResponsable != null ? puestoResponsable : ""
        );
        this.departamentoResponsable = new SimpleStringProperty(
                departamentoResponsable != null ? departamentoResponsable : ""
        );
        this.idPeriodo = new SimpleIntegerProperty(idPeriodo);
    }

    public int getIdEstudiante()                  { return idEstudiante.get(); }
    public String getNombreEstudiante()           { return nombreEstudiante.get(); }
    public String getMatricula()                  { return matricula.get(); }
    public int getIdOrganizacion()                { return idOrganizacion.get(); }
    public String getNombreOrganizacion()         { return nombreOrganizacion.get(); }
    public String getDireccionOrganizacion()      { return direccionOrganizacion.get(); }
    public int getIdProyecto()                    { return idProyecto.get(); }
    public String getNombreProyecto()             { return nombreProyecto.get(); }
    public LocalDate getFechaInicio()             { return fechaInicio.get(); }
    public int getIdResponsable()                 { return idResponsable.get(); }
    public String getNombreResponsable()          { return nombreResponsable.get(); }
    public String getPuestoResponsable()          { return puestoResponsable.get(); }
    public String getDepartamentoResponsable()    { return departamentoResponsable.get(); }
    public int getIdPeriodo()                     { return idPeriodo.get(); }
    public boolean isSeleccionado()               { return seleccionado.get(); }

    public void setSeleccionado(boolean v)        { seleccionado.set(v); }

    public IntegerProperty idEstudianteProperty()             { return idEstudiante; }
    public StringProperty nombreEstudianteProperty()          { return nombreEstudiante; }
    public StringProperty matriculaProperty()                 { return matricula; }
    public IntegerProperty idOrganizacionProperty()           { return idOrganizacion; }
    public StringProperty nombreOrganizacionProperty()        { return nombreOrganizacion; }
    public StringProperty direccionOrganizacionProperty()     { return direccionOrganizacion; }
    public IntegerProperty idProyectoProperty()               { return idProyecto; }
    public StringProperty nombreProyectoProperty()            { return nombreProyecto; }
    public ObjectProperty<LocalDate> fechaInicioProperty()    { return fechaInicio; }
    public IntegerProperty idResponsableProperty()            { return idResponsable; }
    public StringProperty nombreResponsableProperty()         { return nombreResponsable; }
    public StringProperty puestoResponsableProperty()         { return puestoResponsable; }
    public StringProperty departamentoResponsableProperty()   { return departamentoResponsable; }
    public IntegerProperty idPeriodoProperty()                { return idPeriodo; }
    public BooleanProperty seleccionadoProperty()             { return seleccionado; }
}
