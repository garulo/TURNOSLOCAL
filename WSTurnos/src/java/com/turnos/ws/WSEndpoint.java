/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.turnos.ws;

import java.util.ArrayList;
import java.util.List;
import javax.ejb.Schedule;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.OnClose;
import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;

/**
 *
 * @author marco
 */
@ServerEndpoint("/endpoint")
public class WSEndpoint {

    /*JSONObject json = new JSONObject();
    TurnoDash td = new TurnoDash();*/
    static final List<Session> conexiones = new ArrayList<>();
    String msg = new String();
   
     @OnOpen
    public void iniciaSesion(Session session) {
        
        conexiones.add(session); //Simplemente, lo agregamos a la lista
         System.out.println("WebSocket add session:::\n");
    }
    
    
     @OnClose
    public void finConexion(Session session) {
        
        if (conexiones.contains(session)) { // se averigua si está en la colección
            try {
                
                session.close(); //se cierra la conexión
                conexiones.remove(session); // se retira de la lista
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
    
    @Schedule(second = "*/2", minute = "*", hour = "*", persistent = false)
    public void notificar() {
        
          // el mensaje a enviar
        for (Session sesion : conexiones) { //recorro toda la lista de conectados
            RemoteEndpoint.Basic remote = sesion.getBasicRemote(); //tomo la conexion remota con el cliente...
            try {
                remote.sendText(msg);//... y envío el mensajue
                //System.out.println(sesion.getId() + "::: mensaje notificar :::" + msg);
     sesion.close(); //se cierra la conexión
            } catch (Exception ex) {
               ex.printStackTrace();
            }
        }
 
    }
    
    
    @OnMessage
    public void onMessage(String mensaje, Session sesion) {
        msg = mensaje;
         try {

            sesion.getBasicRemote().sendText(msg);
            //System.out.println(sesion.getId() + "::: mensaje :::" + msg);
         }catch(Exception e){
             e.printStackTrace();}
          for (Session sesin : conexiones) { //recorro toda la lista de conectados
            RemoteEndpoint.Basic remote = sesin.getBasicRemote(); //tomo la conexion remota con el cliente...
            try {
                remote.sendText(msg);//... y envío el mensajue
                //System.out.println(sesin.getId() + "::: mensaje notificar :::" + msg);
                sesion.close(); //se cierra la conexión
    
            } catch (Exception ex) {
               ex.printStackTrace();
            }
        }
    }
}
