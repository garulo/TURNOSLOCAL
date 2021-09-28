/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sadm.turnos.dao;

/**
 *
 * @author marco
 */
public class Ventanilla {

    private String id;
    private String nombre;
    private String desc;
    private String usuario;
    private String usuLstUpdt;
    private String dtLstUpdt;
    private String servicios;

    public String getServicios() {
        return servicios;
    }

    public void setServicios(String servicios) {
        this.servicios = servicios;
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

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getUsuLstUpdt() {
        return usuLstUpdt;
    }

    public void setUsuLstUpdt(String usuLstUpdt) {
        this.usuLstUpdt = usuLstUpdt;
    }

    public String getDtLstUpdt() {
        return dtLstUpdt;
    }

    public void setDtLstUpdt(String dtLstUpdt) {
        this.dtLstUpdt = dtLstUpdt;
    }
    
}
