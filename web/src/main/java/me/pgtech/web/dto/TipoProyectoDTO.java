package me.pgtech.web.dto;

public class TipoProyectoDTO {

    private Long id;
    private String nombre;
    private Integer maxMiembros;
    private Integer tamanoMin;
    private Integer tamanoMax;

    public TipoProyectoDTO() {
    }

    public TipoProyectoDTO(String nombre, Integer maxMiembros, Integer tamanoMin, Integer tamanoMax) {
        this.nombre = nombre;
        this.maxMiembros = maxMiembros;
        this.tamanoMin = tamanoMin;
        this.tamanoMax = tamanoMax;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getMaxMiembros() {
        return maxMiembros;
    }   

    public void setMaxMiembros(Integer maxMiembros) {
        this.maxMiembros = maxMiembros;
    }

    public Integer getTamanoMin() {
        return tamanoMin;
    }

    public void setTamanoMin(Integer tamanoMin) {
        this.tamanoMin = tamanoMin;
    }   

    public Integer getTamanoMax() {
        return tamanoMax;
    }   

    public void setTamanoMax(Integer tamanoMax) {
        this.tamanoMax = tamanoMax;
    }

}
