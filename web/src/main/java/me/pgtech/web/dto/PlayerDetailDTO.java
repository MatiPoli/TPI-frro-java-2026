package me.pgtech.web.dto;

import java.util.Date;
import java.util.UUID;

public class PlayerDetailDTO {

    private UUID id;
    private String nombre;
    private String nombrePublico;
    private Long dsIdUsuario;
    private Long fechaIngreso;
    private Long fechaUltimaConexion;
    private RangoUsuarioDTO rangoUsuario;
    private TipoUsuarioDTO tipoUsuario;
    private PaisSummaryDTO paisPrefix;

    public PlayerDetailDTO() {
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombrePublico() {
        return nombrePublico;
    }

    public void setNombrePublico(String nombrePublico) {
        this.nombrePublico = nombrePublico;
    }

    public Long getDsIdUsuario() {
        return dsIdUsuario;
    }

    public void setDsIdUsuario(Long dsIdUsuario) {
        this.dsIdUsuario = dsIdUsuario;
    }

    public Long getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Long fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public Long getFechaUltimaConexion() {
        return fechaUltimaConexion;
    }

    public void setFechaUltimaConexion(Long fechaUltimaConexion) {
        this.fechaUltimaConexion = fechaUltimaConexion;
    }

    public RangoUsuarioDTO getRangoUsuario() {
        return rangoUsuario;
    }

    public void setRangoUsuario(RangoUsuarioDTO rangoUsuario) {
        this.rangoUsuario = rangoUsuario;
    }

    public TipoUsuarioDTO getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(TipoUsuarioDTO tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public PaisSummaryDTO getPaisPrefix() {
        return paisPrefix;
    }

    public void setPaisPrefix(PaisSummaryDTO paisPrefix) {
        this.paisPrefix = paisPrefix;
    }

}
