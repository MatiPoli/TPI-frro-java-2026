package me.pgtech.web.dto;

import java.util.UUID;

public class PlayerSummaryDTO {

    private UUID id;
    private String nombre;
    private String nombrePublico;
    private RangoUsuarioDTO rangoUsuario;
    private TipoUsuarioDTO tipoUsuario;
    private PaisSummaryDTO paisPrefix;

    public PlayerSummaryDTO() {
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
