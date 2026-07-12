package me.pgtech.web.dto;

public class ProyectoMapaDTO {

    private String id;
    private String nombre;
    private Estado estado;
    private String poligono;
    private String liderNombre;

    public ProyectoMapaDTO() {
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

    public String getLiderNombre() {
        return liderNombre;
    }

    public void setLiderNombre(String liderNombre) {
        this.liderNombre = liderNombre;
    }

}