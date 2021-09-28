
package com.sadm.turnos.servlet;

import com.sadm.turnos.controlador.Consultas;
import com.sadm.turnos.dao.RepTiempoTicket;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReporteTiempoTicket extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String dtInicio = request.getParameter("dtTInicio") + " 01:00:00";
        String dtFin = request.getParameter("dtTFin") + " 23:00:00";
        dtInicio = dtInicio.replace("-", "/");
        dtFin = dtFin.replace("-", "/");
        Consultas co = new Consultas();
        ArrayList<RepTiempoTicket> lstTTicket = co.generarreportetticket(dtInicio, dtFin);
        ArrayList<RepTiempoTicket> lstTT = new ArrayList<>();
        Integer treasignados =0;
        Integer tcancelados =0;
        Integer totalt = lstTTicket.size();
        
        for(RepTiempoTicket r:lstTTicket){
            RepTiempoTicket re=new RepTiempoTicket();
            if(r.getReasignado().equalsIgnoreCase("Reasignado")){treasignados=treasignados+1;}
            if(r.getCancelado().equalsIgnoreCase("Cancelado")){tcancelados=tcancelados+1;}
            re.setTurno(r.getTurno());
            String espera = r.getFespera().substring(r.getFespera().length() - 8, r.getFespera().length());
            espera = espera.replaceAll(":", "");
            int esp = Integer.parseInt(espera);
            
            String atencion = r.getFatencion().substring(r.getFatencion().length() - 8, r.getFatencion().length());
            atencion = atencion.replaceAll(":", "");
            int ate = Integer.parseInt(atencion);
            
            Integer tiempo_espera = ate - esp;
            tiempo_espera = tiempo_espera / 100;
            
            espera = tiempo_espera.toString();
            re.setFespera(espera);
            
            String termino = r.getFtermino().substring(r.getFtermino().length() - 8, r.getFtermino().length());
            termino = termino.replaceAll(":", "");
            int ter = Integer.parseInt(termino);
            Integer tiempo_atencion = ter - ate;
            tiempo_atencion = tiempo_atencion / 100;
           
            atencion = tiempo_atencion.toString();
            re.setFatencion(atencion);

            Integer tiempo_total = ter - esp;
            tiempo_total = tiempo_total / 100;
           
            atencion = tiempo_total.toString();
            re.setFtermino(atencion);
            
            re.setVentanilla(r.getVentanilla());
            re.setReasignado(r.getReasignado());
            re.setCancelado(r.getCancelado());
            re.setAtiende(r.getAtiende());
            re.setIdatiende(r.getIdatiende());
            re.setIdOficina(r.getIdOficina());
            re.setEstatus(r.getEstatus());
            re.setPreferencial(r.getPreferencial());
            lstTT.add(re);
        }
        
        
        try (PrintWriter out = response.getWriter()) {
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
            out.println("<h1>Reporte de tiempo en atención por tickets</h1><br>");
            out.println("<h2>Total de tickets: "+totalt+"</h2><br>");
            out.println("<h2>Cancelados: "+tcancelados+"</h2><br>");
            out.println("<h2>Reasignados: "+treasignados+"</h2><br>");
            out.println("<table id=\"tblData\" class=\"table\">");
            out.println("<thead class=\"thead-dark\">");
            out.println("<tr> <th scope=\"col\">Oficina</th><th scope=\"col\">Id Empleado</th><th scope=\"col\">Atiende</th><th scope=\"col\">Turno</th> <th scope=\"col\">Espera(min)</th><th scope=\"col\">Atención(min)</th><th scope=\"col\">Total(min)</th><th scope=\"col\">Ventanilla</th><th scope=\"col\">Tipo de Turno</th><th scope=\"col\">Estatus de Turno</th><th scope=\"col\">Estatus de Atención</th><th scope=\"col\">Preferencial</th></tr>");
            out.println(" </thead>");
            out.println("<tbody>");
            
            for(RepTiempoTicket a:lstTT){
                String prefe = "";
                if(a.getPreferencial().equalsIgnoreCase("true")){prefe="Preferencial";}
            out.println("<tr><td>"+a.getIdOficina()+"</td><td>"+a.getIdatiende()+"</td><td>"+a.getAtiende()+"</td><td>"+a.getTurno()+"</td><td>"+a.getFespera()+"</td><td>"+a.getFatencion()+"</td><td>"+a.getFtermino()+"</td> <td>"+a.getVentanilla()+"</td><td>"+a.getReasignado()+"</td><td>"+a.getCancelado()+"</td><td>"+a.getEstatus()+"</td><td>"+prefe+"</td></tr>");
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
