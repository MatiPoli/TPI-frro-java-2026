package me.pgtech.web.dto;

public class DivisionDetailDTO {

    private long id;
    private String nombre;
    private String nam;
    private String gna;
    private String fna;
    private String contexto;
    private PaisSummaryDTO pais;

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

    public String getNam() {
        return nam;
    }

    public void setNam(String nam) {
        this.nam = nam;
    }

    public String getGna() {
        return gna;
    }

    public void setGna(String gna) {
        this.gna = gna;
    }

    public String getFna() {
        return fna;
    }

    public void setFna(String fna) {
        this.fna = fna;
    }

    public String getContexto() {
        return contexto;
    }

    public void setContexto(String contexto) {
        this.contexto = contexto;
    }

    public PaisSummaryDTO getPais() {
        return pais;
    }

    public void setPais(PaisSummaryDTO pais) {
        this.pais = pais;
    }

}
