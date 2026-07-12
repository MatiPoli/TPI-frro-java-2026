package me.pgtech.web.dto;

public class RegionDivisionMapaDTO {

    private long id;
    private String nombre;
    private String polygon;
    private String divisionNombre;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPolygon() {
        return polygon;
    }

    public void setPolygon(String polygon) {
        this.polygon = polygon;
    }

    public String getDivisionNombre() {
        return divisionNombre;
    }

    public void setDivisionNombre(String divisionNombre) {
        this.divisionNombre = divisionNombre;
    }

}