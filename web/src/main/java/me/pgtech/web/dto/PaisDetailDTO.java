package me.pgtech.web.dto;

public class PaisDetailDTO {

    private Long id;
    private String nombre;
    private String nombrePublico;
    private Long dsIdGuild;
    private Long dsIdGlobalChat;
    private Long dsIdCountryChat;
    private Long dsIdLog;
    private Long dsIdRequest;
    private String webId;
    private String webToken;

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

    public String getNombrePublico() {
        return nombrePublico;
    }

    public void setNombrePublico(String nombrePublico) {
        this.nombrePublico = nombrePublico;
    }

    public Long getDsIdGuild() {
        return dsIdGuild;
    }

    public void setDsIdGuild(Long dsIdGuild) {
        this.dsIdGuild = dsIdGuild;
    }

    public Long getDsIdGlobalChat() {
        return dsIdGlobalChat;
    }

    public void setDsIdGlobalChat(Long dsIdGlobalChat) {
        this.dsIdGlobalChat = dsIdGlobalChat;
    }

    public Long getDsIdCountryChat() {
        return dsIdCountryChat;
    }

    public void setDsIdCountryChat(Long dsIdCountryChat) {
        this.dsIdCountryChat = dsIdCountryChat;
    }

    public Long getDsIdLog() {
        return dsIdLog;
    }

    public void setDsIdLog(Long dsIdLog) {
        this.dsIdLog = dsIdLog;
    }

    public Long getDsIdRequest() {
        return dsIdRequest;
    }

    public void setDsIdRequest(Long dsIdRequest) {
        this.dsIdRequest = dsIdRequest;
    }

    public String getWebId() {
        return webId;
    }

    public void setWebId(String webId) {
        this.webId = webId;
    }

    public String getWebToken() {
        return webToken;
    }

    public void setWebToken(String webToken) {
        this.webToken = webToken;
    }

}
