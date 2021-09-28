
package com.sadm.turnos.websocket;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.OnClose;
import javax.websocket.Session;


@ServerEndpoint("/endpoint")
public class WSEndpoint {

    @OnOpen
    public void onOpen(Session session){
        System.out.println(session.getId()+"::: conexion websocket abierta :::");
        
        try {
            session.getBasicRemote().sendText("conexion establecida");
        } catch (Exception e) {
        e.printStackTrace();
        }
        
    }
    
    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("Mensaje "+session.getId()+": "+message);
        try {
            session.getBasicRemote().sendText(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @OnClose
    public void OnClose(Session session){
    
        System.out.println("Sesión "+session.getId()+" ha terminado");
    }
    
}
