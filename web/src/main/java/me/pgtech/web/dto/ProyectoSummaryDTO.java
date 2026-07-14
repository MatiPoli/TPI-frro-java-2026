package me.pgtech.web.dto;

public class ProyectoSummaryDTO {

    private String id;
    private String nombre;
    private String descripcion;
    private Estado estado;
    private double tamaño;
    private Long fechaCreado;
    private Long fechaTerminado;
    private TipoProyectoDTO tipoProyecto;
    private PlayerSummaryDTO lider;
    private DivisionSummaryDTO division;

    public ProyectoSummaryDTO() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Estado getEstado() {
        return estado;
    }
    
    public void setEstado(Estado estado) {
        this.estado = estado;
    }

    public double getTamaño() {
        return tamaño;
    }

    public void setTamaño(double tamaño) {
        this.tamaño = tamaño;
    }

    public Long getFechaCreado() {
        return fechaCreado;
    }

    public void setFechaCreado(Long fechaCreado) {
        this.fechaCreado = fechaCreado;
    }

    public Long getFechaTerminado() {
        return fechaTerminado;
    }

    public void setFechaTerminado(Long fechaTerminado) {
        this.fechaTerminado = fechaTerminado;
    }

    public TipoProyectoDTO getTipoProyecto() {
        return tipoProyecto;
    }

    public void setTipoProyecto(TipoProyectoDTO tipoProyecto) {
        this.tipoProyecto = tipoProyecto;
    }

    public PlayerSummaryDTO getLider() {
        return lider;
    }

    public void setLider(PlayerSummaryDTO lider) {
        this.lider = lider;
    }

    public DivisionSummaryDTO getDivision() {
        return division;
    }

    public void setDivision(DivisionSummaryDTO division) {
        this.division = division;
    }

}
