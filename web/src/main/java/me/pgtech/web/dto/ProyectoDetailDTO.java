package me.pgtech.web.dto;

import java.util.Date;

public class ProyectoDetailDTO {

    private String id;
    private String nombre;
    private String descripcion;
    private Estado estado;
    private String poligono;
    private double tamaño;
    private Long fechaCreado;
    private Long fechaTerminado;
    private TipoProyectoDTO tipoProyecto;
    private PlayerSummaryDTO lider;
    private DivisionDetailDTO division;

    public ProyectoDetailDTO() {
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

    public String getPoligono() {
        return poligono;
    }

    public void setPoligono(String poligono) {
        this.poligono = poligono;
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

    public DivisionDetailDTO getDivision() {
        return division;
    }

    public void setDivision(DivisionDetailDTO division) {
        this.division = division;
    }

}
