/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sadm.turnos.servlet;

import com.sadm.turnos.controlador.Consultas;
import com.sadm.turnos.dao.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author marco
 * @Invocar como: "login"
 */
public class InicioSesion extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String usuario = request.getParameter("Usuario");
        String password = request.getParameter("password");
        
        Consultas co = new Consultas();
        Usuario user = new Usuario();
        user = co.autenticacion(usuario, password);
        if(null != user.getUsuario()){
            
            HttpSession objSession = request.getSession(true);
            
            objSession.setAttribute("usuario", usuario);
            objSession.setAttribute("nombre", user.getNombre());
            System.out.println("usuario logeado:: "+usuario);
            
             switch(user.getIdRol())
        {
            case "1":
                System.out.println("Usuario Administrador Global");
                response.sendRedirect("/Turnos_SADM/DashBoard1.jsp");
                break;
            case "2":
                System.out.println("Usuario Administrador Local");
                response.sendRedirect("/Turnos_SADM/DashBoard2.jsp");
                break;
            case "3":
                System.out.println("Usuario Colaborador");
                response.sendRedirect("/Turnos_SADM/DashBoard3.jsp");
                break;
            default:
                System.out.println("Usuario Público");
        }
            
        }else{
            
        response.sendRedirect("/Turnos_SADM/Restringido.jsp");
        
        }
        
       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
