package me.pgtech.web.dto;

import java.util.Objects;

public class RangoUsuarioDTO {

    private Long id;
    private String nombre;

    public RangoUsuarioDTO() {
    }

    public RangoUsuarioDTO(String nombre) {
        this.nombre = nombre;
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

}
