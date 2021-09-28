
package com.sadm.turnos.controlador;

import com.mysql.jdbc.Connection;
import com.sadm.turnos.dao.ConexionProperties;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConexionDB {
 /*  LOCAL */
private String USERNAME ="root";
private String PASSWORD = "admin";
//private String HOST = "localhost";

/*  TIBS */
//private String USERNAME ="root";
//private String PASSWORD = "Tibs2019!";
//private String HOST = "127.0.0.2";

/*  SADM LOCAL OBISPADO KIOSKO */
//private String USERNAME ="sqladmin";
//private String PASSWORD = "sadm";
//private String HOST = "172.16.23.128";

//    

/*  SADM LOCAL LA FAMA KIOSKO */
//private String USERNAME ="sqladmin";
//private String PASSWORD = "sadm";
//private String HOST = "172.16.22.77";

/*  SADM LOCAL LINCOLN KIOSKO */
//private String USERNAME ="sqladmin";
//private String PASSWORD = "sadm";
//private String HOST = "192.168.60.93";

private String HOST =ConexionProperties.conlocal;
        


private String PORT = "3306";
private String DATABASE = "turnos";
private String CLASSNAMEDRIVER = "com.mysql.jdbc.Driver";

private String URL="jdbc:mysql://"+HOST+":"+PORT+"/"+DATABASE;
private Connection con;

public ConexionDB(){
    System.out.println("URL:: "+URL);
    
    try{
    Class.forName(CLASSNAMEDRIVER);
    con = (Connection) DriverManager.getConnection(URL,USERNAME,PASSWORD);
    
    }catch (ClassNotFoundException e ){
        System.err.println("ERROR: "+e);
    }catch (SQLException e ){
        System.out.println("ERROR: "+e);
    }

}

public Connection getConexion(){
return con;
}

    public static void main(String[] args) {
        ConexionDB conn = new ConexionDB();
        System.out.println("**** Conexión a DB Exitosa *****");
    }
}
