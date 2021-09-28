/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sadm.turnos.servlet;

import com.sadm.turnos.controlador.Consultas;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author marco
 */
public class ActualizarPerfil extends HttpServlet {
 private static final long serialVersionUID = 1 ;
 public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
 doPost(request, response);
 }
 public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
 String file_name = null;
 String name = new String();
 
 response.setContentType("text/html");
 PrintWriter out = response.getWriter();
 boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
 if (!isMultipartContent) {
 return;
 }
 FileItemFactory factory = new DiskFileItemFactory();
 ServletFileUpload upload = new ServletFileUpload(factory);
 try {
 List < FileItem > fields = upload.parseRequest(request);
 Iterator < FileItem > it = fields.iterator();
 if (!it.hasNext()) {
 return;
 }
 while (it.hasNext()) {
 FileItem fileItem = it.next();
 boolean isFormField = fileItem.isFormField();
 if (isFormField) {
 if (file_name == null) {
 if (fileItem.getFieldName().equals("file_name")) {
 file_name = fileItem.getString();
 name = fileItem.getString();
 }
 }
 } else {
 if (fileItem.getSize() > 0) {
 
//     fileItem.write(new File("C:\\Users\\marco\\Documents\\GARULO\\ServiciosDeAguayDrenajeMty\\SADM_WEB_2019\\WorkSpaceSADM_2019_V1\\ProyectNB\\Turnos_SADM\\web\\archivos\\uploaded_files\\" + fileItem.getName()));

    fileItem.write(new File("C:\\Tomcat 9.0\\webapps\\Turnos_SADM\\archivos\\uploaded_files\\" + fileItem.getName()));
   //TIBS  fileItem.write(new File("C:\\Users\\apps\\Desktop\\Turnos\\servers\\Apache\\apache-tomcat-7.0.99-windows-x64\\apache-tomcat-7.0.99\\webapps\\Turnos_SADM\\archivos\\uploaded_files\\" + fileItem.getName()));
 name ="archivos/uploaded_files/"+fileItem.getName();
 }
 }
 }
 } catch (Exception e) {
 e.printStackTrace();
 } finally {
     
       Consultas co = new Consultas();
  if(co.editarVideo(name)){
        borrarArchivos();
        response.sendRedirect("/Turnos_SADM/DashBoard2.jsp");
        }else{
        response.sendRedirect("/Turnos_SADM/DashBoard2.jsp");
        
        }
 }

 
 
 }
 
 private static void borrarArchivos() {
        //String direccion = "C:\\Users\\apps\\Desktop\\Turnos\\servers\\Apache\\apache-tomcat-7.0.99-windows-x64\\apache-tomcat-7.0.99\\webapps\\Turnos_SADM\\archivos\\uploaded_files";
// String direccion = "C:\\Users\\marco\\Documents\\GARULO\\ServiciosDeAguayDrenajeMty\\SADM_WEB_2019\\WorkSpaceSADM_2019_V1\\ProyectNB\\Turnos_SADM\\web\\archivos\\uploaded_files";
String direccion = "C:\\Tomcat 9.0\\webapps\\Turnos_SADM\\archivos\\uploaded_files";
        File directorio = new File(direccion);
        File f;
        if (directorio.isDirectory()) {
            String[] files = directorio.list();
            if (files.length > 0) {
                System.out.println(" Directorio vacio: " + direccion);
                for (String archivo : files) {
                    System.out.println(archivo);
                    f = new File(direccion + File.separator + archivo);

                    System.out.println("Ultima modificación: " + new Date(f.lastModified()));
                    long Time;
                    Time = (System.currentTimeMillis() - f.lastModified());
                    long cantidadDia = (Time / 86400000);
                    System.out.println("Age of the file is: " + cantidadDia + " days");
                    
                    if (Time > (86400000 * 1) && archivo.contains(".mp4")) {
                        System.out.println("Borrado:" + archivo);
                        f.delete();
                        f.deleteOnExit();
                    }

                }
            }
        }

    }
 
}
