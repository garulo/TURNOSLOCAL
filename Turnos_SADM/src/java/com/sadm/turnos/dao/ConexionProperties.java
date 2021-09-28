package com.sadm.turnos.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConexionProperties {

    RutaProperties rp = new RutaProperties();
    String urlProperties = rp.getRuta();
    Properties oProperties = new Properties();
    public static String conlocal = "";
    public static String concentral = "";
    public static String wsuri = "";

    

    public ConexionProperties() throws FileNotFoundException, IOException {
         InputStream isArchivo = new FileInputStream(urlProperties);
         oProperties.load (isArchivo);
         conlocal =  oProperties.getProperty("CONLOCHOST");
         concentral =  oProperties.getProperty("CONNECTIONCENTRALURL");
         wsuri = oProperties.getProperty("WSURI");
        
    }

    public static String getConcentral() {
        return concentral;
    }

    public static void setConcentral(String concentral) {
        ConexionProperties.concentral = concentral;
    }
    
    public String getConlocal() {
        return conlocal;
    }

    public void setConlocal(String conlocal) {
        this.conlocal = conlocal;
    }

    public static String getWsuri() {
        return wsuri;
    }

    public static void setWsuri(String wsuri) {
        ConexionProperties.wsuri = wsuri;
    }
    
    
    
    
    
    
    
   

    
}
