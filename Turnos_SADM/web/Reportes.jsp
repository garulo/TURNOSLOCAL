<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.sadm.turnos.dao.Oficina"%>
<%@page import="com.sadm.turnos.controlador.Consultas"%>
<%
    HttpSession objSession = request.getSession(false);
    String usuario = (String) objSession.getAttribute("usuario");
    String nombreUser = (String) objSession.getAttribute("nombre");
    if (null == usuario) {
        response.sendRedirect("Restringido.jsp");
    } else if (usuario.equals("")) {
        response.sendRedirect("Login.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes de Turnos SADM</title>
        <link href="archivos/uploaded_files/Icono_SADM.png" rel="shortcut icon" type="image/x-icon" />
        <link href="archivos/uploaded_files/logo_sadm_color.png" rel="apple-touch-icon" />
        <script src="archivos/js/jquery.min.js"></script>
        <link rel="stylesheet" href="archivos/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="archivos/js/bootstrap4.min.js"  crossorigin="anonymous"></script>
        <script src="archivos/js/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="archivos/js/jquery.min.js">
        </script>
    </head>
    <body>
        <style>
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: none;
                min-width: 20px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);

                z-index: 1;
                margin-right: 10px;
            }

            .dropdown:hover .dropdown-content {
                display: block;
                margin-right: 10px;
            }
            .desc {

                text-align: center;
                margin-right: 10px;

            }
        </style>
        <table class="table" style="alignment-adjust: central;" width="100%" height="100%" >
            <tbody style="alignment-baseline: central;" >
                <%
                    Consultas ofi = new Consultas();
                    Oficina oficina = ofi.consulNombreOficina();
                    Date fechaActual = new Date();
                    String n_fecha_format = new String();
                    n_fecha_format = new SimpleDateFormat("EEEEEEEEE dd 'de' MMMMM 'de' yyyy").format(fechaActual);
                    n_fecha_format = n_fecha_format.toUpperCase();
                    DateFormat time = new SimpleDateFormat("HH:mm");
                    String n_time_format = new String();
                    n_time_format = time.format(fechaActual);
                %>
                <tr>
                    <td colspan="3" style="alignment-adjust: auto;text-align: center;background-color: #668FB7;"><label style="font-weight: bold;font-size: 32px;font-family: 'Roboto', sans-serif;color: white;"><%=oficina.getNombre().toUpperCase()%></label></td>
                    <td colspan="2" style="alignment-adjust: auto;text-align: center;background-color: #668FB7; "><label style="font-size: 18px;font-family: 'Roboto', sans-serif;color: white;margin-top: 15px;"><%=n_fecha_format%></label></td>
                    <td colspan="1" style="alignment-adjust: auto;text-align: start;background-color: #668FB7; ">
                        <div class="dropdown">
                            <img src="archivos/uploaded_files/icono_perfil.PNG" alt="Perfil" width="52" height="32" style="margin-top: 10px;margin-right: 30px;">

                            <div class="dropdown-content">
                                <div class="desc" >
                                    <button type="button" style="margin-top: 5px;background-color: #668FB7;border-radius: 7px;font-size: 12px;color: white;font-family: 'Roboto', sans-serif;color: white;" onclick="location.href = 'DashBoard2.jsp'"><strong>REGRESAR</strong></button>
                                </div>

                            </div>
                        </div>


                </tr>
                <tr>
                    <td colspan="5" style="alignment-adjust: auto;text-align: end;background-color: white;"><label style="font-weight: bold;font-size: 22px;font-family: 'Roboto', sans-serif;color: #58585A;"><strong>Bienvenido:</strong>  <%=nombreUser%></label></td>
                    <td width="80" ></td>
                </tr></tbody></table>




        <div id="accordion">
            <div class="card">
                <div class="card-header" id="headingOne">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                            Generar reporte de turnos atendidos por ventanilla.
                        </button>
                    </h5>
                </div>

                <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
                    <div class="card-body">
                        <form action="reporteatendidos"  method="post" id="formReporteAtendidos" name="formReporteAtendidos" >

                            <div class="form-group row">
                                <label for="example-datetime-local-input" class="col-2 col-form-label">Selecciona una fecha de inicio</label>
                                <div class="col-10">
                                    <input required name="dtInicio" id="dtInicio" class="form-control" type="date"  id="example-datetime-local-input">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="example-datetime-local-input" class="col-2 col-form-label">Selecciona una fecha de fin</label>
                                <div class="col-10">
                                    <input required name="dtFin"  id="dtFin" class="form-control" type="date"  id="example-datetime-local-input">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="example-datetime-local-input" class="col-2 col-form-label">Presiona para generar el reporte</label>
                                <div class="col-10">
                            <button  id="btnReporteAtendidos" onclick="submit()" type="button" class="btn btn-primary"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>Generar Reporte</strong></button>
                                </div></div>                  
                        </form>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header" id="headingTwo">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                            Generar reporte de tiempos en atención por servicio.
                        </button>
                    </h5>
                </div>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                    <div class="card-body">
                        <form action="reportetiemposervicio"  method="post" id="formReporteTiempoServicio" name="formReporteTiemposservicio">
                            <div class="form-group row">
                                <label for="example-datetime-local-input" class="col-2 col-form-label">Selecciona una fecha de inicio</label>
                                <div class="col-10">
                                    <input required name="dtTSInicio" id="dtTSInicio" class="form-control" type="date"  id="example-datetime-local-input">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="example-datetime-local-input" class="col-2 col-form-label">Selecciona una fecha de fin</label>
                                <div class="col-10">
                                    <input required name="dtTSFin"  id="dtTSFin" class="form-control" type="date"  id="example-datetime-local-input">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="example-datetime-local-input" class="col-2 col-form-label">Presiona para generar el reporte</label>
                                <div class="col-10">
                            <button  id="btnReporteTiempoServicios" onclick="submit()" type="button" class="btn btn-primary"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>Generar Reporte</strong></button>
                                </div></div> 
                        </form>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header" id="headingThree">
                    <h5 class="mb-0">
                        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                            Generar reporte de tiempos en atención por turnos.
                        </button>
                    </h5>
                </div>
                <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                    <div class="card-body">
                         <form action="reportetiempoticket"  method="post" id="formReporteTicket" name="formReporteTiempoTicket">
                            <div class="form-group row">
                                <label for="example-datetime-local-input" class="col-2 col-form-label">Selecciona una fecha de inicio</label>
                                <div class="col-10">
                                    <input required name="dtTInicio" id="dtTInicio" class="form-control" type="date"  id="example-datetime-local-input">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="example-datetime-local-input" class="col-2 col-form-label">Selecciona una fecha de fin</label>
                                <div class="col-10">
                                    <input required name="dtTFin"  id="dtTFin" class="form-control" type="date"  id="example-datetime-local-input">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="example-datetime-local-input" class="col-2 col-form-label">Presiona para generar el reporte</label>
                                <div class="col-10">
                            <button  id="btnReporteTiempoTicket" onclick="submit()" type="button" class="btn btn-primary"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>Generar Reporte</strong></button>
                                </div></div> 
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
