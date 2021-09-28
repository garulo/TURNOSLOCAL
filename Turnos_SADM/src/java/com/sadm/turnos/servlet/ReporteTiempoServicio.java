package com.sadm.turnos.servlet;

import com.sadm.turnos.controlador.Consultas;
import com.sadm.turnos.dao.RepTiempoServicio;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReporteTiempoServicio extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String dtInicio = request.getParameter("dtTSInicio") + " 01:00:00";
        String dtFin = request.getParameter("dtTSFin") + " 23:00:00";
        dtInicio = dtInicio.replace("-", "/");
        dtFin = dtFin.replace("-", "/");

        Consultas co = new Consultas();
        ArrayList<RepTiempoServicio> lstTServ = co.generarreportetservicios(dtInicio, dtFin);
        ArrayList<RepTiempoServicio> lstTS = new ArrayList<>();

        System.out.println("lstTServ : " + lstTServ.size());

        for (RepTiempoServicio r : lstTServ) {
            RepTiempoServicio rs = new RepTiempoServicio();
            
            rs.setAtiende(r.getAtiende());
            rs.setIdatiende(r.getIdatiende());
            rs.setIdOficina(r.getIdOficina());
            rs.setEstatus(r.getEstatus());
            rs.setFatencion(r.getFatencion());
            rs.setFespera(r.getFespera());
            rs.setPreferencial(r.getPreferencial());
            
            rs.setServicio(r.getServicio());
            String espera = r.getTespera().substring(r.getTespera().length() - 8, r.getTespera().length());
            espera = espera.replaceAll(":", "");
            int esp = Integer.parseInt(espera);

            String atencion = r.getTatencion().substring(r.getTatencion().length() - 8, r.getTatencion().length());
            atencion = atencion.replaceAll(":", "");
            int ate = Integer.parseInt(atencion);

            Integer tiempo_espera = ate - esp;
            tiempo_espera = tiempo_espera / 100;
            
            espera = tiempo_espera.toString();
            rs.setTespera(espera);

            String termino = r.getTtermino().substring(r.getTtermino().length() - 8, r.getTtermino().length());
            termino = termino.replaceAll(":", "");
            int ter = Integer.parseInt(termino);
            Integer tiempo_atencion = ter - ate;
            tiempo_atencion = tiempo_atencion / 100;
            
            atencion = tiempo_atencion.toString();
            rs.setTatencion(atencion);

            Integer tiempo_total = ter - esp;
            tiempo_total = tiempo_total / 100;
            
            atencion = tiempo_total.toString();
            rs.setTtermino(atencion);

            lstTS.add(rs);

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
            out.println("<h1>Reporte de tiempo en atención por servicios</h1><br>");
            out.println("<table id=\"tblData\" class=\"table\">");
            out.println("<thead class=\"thead-dark\">");
            out.println("<tr> <th scope=\"col\">Oficina</th><th scope=\"col\">Id Empleado</th><th scope=\"col\">Empleado</th><th scope=\"col\">Servicio</th> <th scope=\"col\">Espera</th><th scope=\"col\">Atención(min)</th><th scope=\"col\">Total(min)</th><th scope=\"col\">Estatus</th><th scope=\"col\">Fecha de Atención</th><th scope=\"col\">Preferencial</th></tr>");
            out.println(" </thead>");
            out.println("<tbody>");
            
            for(RepTiempoServicio a:lstTS){
                String prefe = "";
                if(a.getPreferencial().equalsIgnoreCase("true")){prefe="Preferencial";}
            out.println("<tr><td>"+a.getIdOficina()+"</td><td>"+a.getIdatiende()+"</td><td>"+a.getAtiende()+"</td><td>"+a.getServicio()+"</td><td>"+a.getTespera()+"</td><td>"+a.getTatencion()+"</td><td>"+a.getTtermino()+"</td><td>"+a.getEstatus()+"</td> <td>"+a.getFatencion()+"</td><td>"+prefe+"</td></tr>");
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
