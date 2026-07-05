package me.pgtech.web.dto;

import java.util.Objects;

public class TipoUsuarioDTO {

    private Long id;
    private String nombre;
    private String descripcion;
    private Integer cantProyecSim; // "Cantidad de proyectos simultáneos"

    public TipoUsuarioDTO() {
    }

    public TipoUsuarioDTO(String nombre, String descripcion, Integer cantProyecSim) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.cantProyecSim = cantProyecSim;
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

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getCantProyecSim() {
        return cantProyecSim;
    }

    public void setCantProyecSim(Integer cantProyecSim) {
        this.cantProyecSim = cantProyecSim;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TipoUsuarioDTO that = (TipoUsuarioDTO) o;
        if (id == null || that.id == null) return false;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
