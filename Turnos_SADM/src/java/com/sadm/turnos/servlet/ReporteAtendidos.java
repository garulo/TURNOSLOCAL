package com.sadm.turnos.servlet;

import com.sadm.turnos.controlador.Consultas;
import com.sadm.turnos.dao.RepAtendidos;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReporteAtendidos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String dtInicio = request.getParameter("dtInicio")+" 01:00:00";
        String dtFin = request.getParameter("dtFin")+" 23:00:00";
        
        dtInicio=dtInicio.replace("-", "/");
        dtFin=dtFin.replace("-", "/");
        
         Consultas co = new Consultas();
        ArrayList<RepAtendidos> lstAtendidos =co.generarreporteatendidos(dtInicio,dtFin);
        
        System.out.println("lstAtendidos : "+lstAtendidos.size());
        
        
         
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n" +
"        <title>Reportes de Turnos Atendidos</title>\n" +
"        <link href=\"archivos/uploaded_files/Icono_SADM.png\" rel=\"shortcut icon\" type=\"image/x-icon\" />\n" +
"        <link href=\"archivos/uploaded_files/logo_sadm_color.png\" rel=\"apple-touch-icon\" />\n" +
"        <script src=\"archivos/js/jquery.min.js\"></script>\n" +
"        <link rel=\"stylesheet\" href=\"archivos/css/bootstrap.min.css\" crossorigin=\"anonymous\">\n" +
"        <script src=\"archivos/js/bootstrap4.min.js\"  crossorigin=\"anonymous\"></script>\n" +
"        <script src=\"archivos/js/jquery-3.3.1.slim.min.js\" crossorigin=\"anonymous\"></script>\n" +
"        <script type=\"text/javascript\" src=\"archivos/js/jquery.min.js\">\n" +
"        </script>");  
            out.println(" <script>\n" +
"                                    function exportTableToExcel(tableID, filename = ''){\n" +
"                                    var downloadLink;\n" +
"                                            var dataType = 'application/vnd.ms-excel';\n" +
"                                            var tableSelect = document.getElementById(tableID);\n" +
"                                            var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');\n" +
"                                            // Specify file name\n" +
"                                            filename = filename?filename + '.xls':'excel_data.xls';\n" +
"                                            // Create download link element\n" +
"                                            downloadLink = document.createElement(\"a\");\n" +
"                                            document.body.appendChild(downloadLink);\n" +
"                                            if (navigator.msSaveOrOpenBlob){\n" +
"                                    var blob = new Blob(['ufeff', tableHTML], {\n" +
"                                    type: dataType\n" +
"                                    });\n" +
"                                            navigator.msSaveOrOpenBlob(blob, filename);\n" +
"                                    } else{\n" +
"                                    // Create a link to the file\n" +
"                                    downloadLink.href = 'data:' + dataType + ', ' + tableHTML;\n" +
"                                            // Setting the file name\n" +
"                                            downloadLink.download = filename;\n" +
"                                            //triggering the function\n" +
"                                            downloadLink.click();\n" +
"                                    }\n" +
"                                    }\n" +
"                        </script>");
            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Reporte de turnos atendidos por ventanilla</h1><br>");
            out.println("<table id=\"tblData\" class=\"table\">");
            out.println("<thead class=\"thead-dark\">");
            out.println("<tr><th scope=\"col\">Oficina</th> <th scope=\"col\">Ventanilla</th><th scope=\"col\">Id Atiende</th><th scope=\"col\">Atiende</th> <th scope=\"col\">Turno</th><th scope=\"col\">Servicio</th><th scope=\"col\">Espera</th><th scope=\"col\">Atendido</th><th scope=\"col\">Terminado</th><th scope=\"col\">Estatus</th><th scope=\"col\">Preferencial</th></tr>");
            out.println(" </thead>");
            out.println("<tbody>");
            
            for(RepAtendidos a:lstAtendidos){
                String prefe = "";
                if(a.getPreferencial().equalsIgnoreCase("true")){prefe="Preferencial";}
            out.println("<tr><td>"+a.getIdOficina()+"</td><td>"+a.getVentanilla()+"</td><td>"+a.getIdatiende()+"</td><td>"+a.getAtiende()+"</td><td>"+a.getTurno()+"</td><td>"+a.getServicio()+"</td><td>"+a.getFespera()+"</td><td>"+a.getFinicio()+"</td><td>"+a.getFfinal()+"</td>  <td>"+a.getEstatus()+"</td> <td>"+prefe+"</td> </tr>");
            }
            
            out.println("</tbody>");
            out.println("</table>");
             out.println("<button onclick=\"exportTableToExcel('tblData')\" style=\"margin: 15px;background-color: #668FB7;border-radius: 7px;font-size: 25px;color: white;font-family: 'Roboto', sans-serif;color: white;\" >Exportar a Excel</button><button type=\"button\" style=\"margin: 15px;background-color: #668FB7;border-radius: 7px;font-size: 25px;color: white;font-family: 'Roboto', sans-serif;color: white;\" onclick=\"location.href='Reportes.jsp'\"><strong>REGRESAR</strong></button>");
            out.println("</body>");
            out.println("</html>");
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
