/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sadm.turnos.controlador;


import com.sadm.turnos.dao.ConexionProperties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDBCentral {

// /*  LOCAL */
////private String USERNAME ="root";
////private String PASSWORD = "admin";
////private String HOST = "localhost";
//
///*  TIBS
//private String USERNAME ="root";
//private String PASSWORD = "Tibs2019!";
//private String HOST = "127.0.0.2";
//*/
//
///*  SADM Central */
//private String USERNAME ="root";
//private String PASSWORD = "";
//private String HOST = "127.0.0.2";
//
//
//private String PORT = "3306";
//private String DATABASE = "turnos_central";
//private String CLASSNAMEDRIVER = "com.mysql.jdbc.Driver";
//private String URL="jdbc:mysql://"+HOST+":"+PORT+"/"+DATABASE;
//private Connection con;
//
//public ConexionDBCentral(){
//
//    try{
//    Class.forName(CLASSNAMEDRIVER);
//    con = (Connection) DriverManager.getConnection(URL,USERNAME,PASSWORD);
//    
//    }catch (ClassNotFoundException e ){
//        System.err.println("ERROR: "+e);
//    }catch (SQLException e ){
//        System.out.println("ERROR: "+e);
//    }
//
//}
//
//public Connection getConexion(){
//return con;
//}
//
//    public static void main(String[] args) {
//        ConexionDB conn = new ConexionDB();
//        System.out.println("**** Conexión a DB Exitosa *****");
//    }
    private Connection con;

    public ConexionDBCentral() {
        System.out.println("::: ConexionDBCentral :::");
        try {

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String connectionURL = ConexionProperties.concentral;
            con = (Connection) DriverManager.getConnection(connectionURL);
            System.out.println("Conexión Central Exitosa");

        } catch (ClassNotFoundException e) {
            System.err.println("ERROR ClassNotFoundException: " + e);
        } catch (SQLException e) {
            System.out.println("ERROR SQLException: " + e);
        }
    }

    public Connection getConexion() {
        
        return con;
    }
    public static void main(String[] args) {
        ConexionDBCentral conn = new ConexionDBCentral();
        System.out.println("**** Conexión a DB Central Exitosa *****");
    }
}
