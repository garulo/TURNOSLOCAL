<%@page import="com.sadm.turnos.dao.ConexionProperties"%>
<%@page import="com.sadm.turnos.dao.Turno"%>
<%@page import="com.sadm.turnos.controlador.ConsultasCentral"%>
<%@page import="com.sadm.turnos.dao.Oficina"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sadm.turnos.dao.Servicio"%>
<%@page import="com.sadm.turnos.controlador.Consultas"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrador Público de Turnos SADM</title>
        <link href="archivos/uploaded_files/Icono_SADM.png" rel="shortcut icon" type="image/x-icon" />
        <link href="archivos/uploaded_files/logo_sadm_color.png" rel="apple-touch-icon" />

        <link href="archivos/css/roboto.css" rel="stylesheet">
        <script src="archivos/js/sweetalert.min.js"></script>
        <script type="text/javascript">
            function is_chrome() {
                var txt = "";
                txt = navigator.userAgent;
                // alert(txt);
                var e = txt.includes("Edg");
                var f = txt.includes("Firefox");
                var o = txt.includes("OPR");

                if (e) {
                    swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) => {
                        window.parent.location.href = 'https://web.sadm.gob.mx/'
                    });
                }
                ;
                if (f) {
                    swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) => {
                        window.parent.location.href = 'https://web.sadm.gob.mx/'
                    });
                }
                ;
                if (o) {
                    swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) => {
                        window.parent.location.href = 'https://web.sadm.gob.mx/'
                    });
                }
                ;
            }
            function  fechaenpantalla() {
                var meses = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");
                var diasSemana = new Array("Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado");
                var f = new Date();
                document.getElementById('lblfecha').innerHTML = diasSemana[f.getDay()] + ", " + f.getDate() + " de " + meses[f.getMonth()] + " de " + f.getFullYear();
                document.getElementById('lblFechaTurno').innerHTML = diasSemana[f.getDay()] + ", " + f.getDate() + " de " + meses[f.getMonth()] + " de " + f.getFullYear();
                document.getElementById('horas').innerHTML = f.getHours();
                document.getElementById('minutos').innerHTML = f.getMinutes();

            }
        </script>
    </head>
    <script>
        function inhabilitar() {
            // alert("Esta función está inhabilitada para este equipo.");
            return false;
        }
        document.oncontextmenu = inhabilitar

    </script>

    <!-- <script>
          var winFeature =
         'location=no,toolbar=no,menubar=no,scrollbars=yes,resizable=yes';
         window.open('index.htm','null',winFeature);  
         
     </script>-->
    <body onload="is_chrome(), imprimirTurno('turnoDiv')" style="margin-top: 5px;height: 2000px;width: 100%;text-align: left;background:url('/Turnos_SADM/archivos/uploaded_files/fondo_agua_sadm_imp_turnos_1.png');background-size:cover;" >

        <form id="TurnoForm"  >
            <div style="margin: auto;display: table;width: 100%;height: 100%;alignment-adjust: central;">           
                <div style="display: table-cell;vertical-align: middle;alignment-adjust: central;" >
                    <div class="table-responsive">
                        <table class="table" style="alignment-adjust: central;" width="100%" height="100%">

                            <tbody  style="alignment-baseline: central;">
                                <tr>
                                    <%

                                        System.out.println(":::Carga :::");
                                        Date fechaActual = new Date();
                                        String n_fecha_format = new String();
                                        n_fecha_format = new SimpleDateFormat("EEEEEEEEE dd 'de' MMMMM yyyy").format(fechaActual);
                                        n_fecha_format = n_fecha_format.substring(0, 1).toUpperCase() + n_fecha_format.substring(1);
                                        DateFormat time = new SimpleDateFormat("HH:mm");
                                        String n_time_format = new String();
                                        n_time_format = time.format(fechaActual);
                                        String turno = new String();
                                    %>
                                    <td width="200"></td>
                                    <td width="200" style="margin: 5px;alignment-adjust: auto;text-align: center;background-color: #003979;"><label id="lblfecha" style="font-family: 'Roboto', sans-serif;color: white;font-size: 30px;"></label></td>
                                    <td  style="alignment-adjust: auto;text-align: center;background-color: #003979;width: 150px;">
                                        <div id="TT_JyewbhtBtpnB4FDKjfqDzjzzjWaK1pQFbdEd1cCIKkj" ></div>
                                        <script type="text/javascript" src="https://www.tutiempo.net/s-widget/l_JyewbhtBtpnB4FDKjfqDzjzzjWaK1pQFbdEd1cCIKkj"></script>
                                    </td>
                            <style>
                                .contenedorreloj {
                                    max-width: 1000px;
                                    margin: auto;
                                }
                                .widgetreloj {
                                    top: 0;
                                    bottom: 0;
                                    left: 0;
                                    right: 0;
                                    margin: auto;
                                }

                                .reloj { 
                                    font-weight: bold;
                                    font-family: 'Roboto', sans-serif;
                                    color: white;
                                    font-size: 20px;
                                }

                                /* The switch - the box around the slider */
                                .switch {
                                    position: relative;
                                    display: inline-block;
                                    width: 60px;
                                    height: 34px;
                                }

                                /* Hide default HTML checkbox */
                                .switch input {
                                    opacity: 0;
                                    width: 0;
                                    height: 0;
                                }

                                /* The slider */
                                .slider {
                                    position: absolute;
                                    cursor: pointer;
                                    top: 0;
                                    left: 0;
                                    right: 0;
                                    bottom: 0;
                                    background-color: #ccc;
                                    -webkit-transition: .4s;
                                    transition: .4s;
                                }

                                .slider:before {
                                    position: absolute;
                                    content: "";
                                    height: 26px;
                                    width: 26px;
                                    left: 4px;
                                    bottom: 4px;
                                    background-color: white;
                                    -webkit-transition: .4s;
                                    transition: .4s;
                                }

                                input:checked + .slider {
                                    background-color: #2196F3;
                                }

                                input:focus + .slider {
                                    box-shadow: 0 0 1px #2196F3;
                                }

                                input:checked + .slider:before {
                                    -webkit-transform: translateX(26px);
                                    -ms-transform: translateX(26px);
                                    transform: translateX(26px);
                                }

                                /* Rounded sliders */
                                .slider.round {
                                    border-radius: 34px;
                                }

                                .slider.round:before {
                                    border-radius: 50%;
                                }
                            </style>
                            <td width="200" style="margin: 5px;alignment-adjust: auto;text-align: center;background-color: #003979;">
                                <div class="contenedorreloj">
                                    <div class="widgetreloj">
                                        <div class="reloj">
                                            <label id="horas" class="horas" style="font-size: 30px;"></label> <label > : </label>
                                            <label id="minutos" class="minutos" style="font-size: 30px;"></label><label >  </label>
                                            <label id="ampm" class="ampm" style="font-size: 30px;"> hrs.</label>
                                            <!--                                            <label id="segundos" class="segundos" style="font-size: 30px;"></label>
                                                                                        <label id="ampm" class="ampm" style="font-size: 30px;"></label>-->

                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td width="300"></td>
                            </tr>
                            <tr style="height: 80px;">

                            </tr>

                            </tbody></table>
                        <table class="table">
                            <thead> </thead>
                            <tbody>
                                <tr style="text-align: center;" >

                                    <td width="100"  ></td>
                                </tr>
                                <tr >
                                    <td colspan="6">
                                        <div >
                                            <div  >
                                                <label style="font-weight: bold;font-family: 'Roboto', sans-serif;font-size: 35px;color: #58585A;"><strong>Bienvenido a Agua y Drenaje de Monterrey</strong></label>
                                                <br><br>
                                                <%
                                                    Consultas ofi = new Consultas();
                                                    Oficina oficina = ofi.consulNombreOficina();
                                                %>
                                                <label style="font-weight: bold;font-family: 'Roboto', sans-serif;color: #58585A;font-size: 35px;"><%=oficina.getNombre()%></label>
                                                <br>
                                                <div style="align-content: center">
                                                    <h1 id="PreferencialActivado" style="color: gray" ><input onclick="valpref()" id="btnPreferente" type="button" style="margin: 20px;text-align: center;font-size: 35px;width: 400px;height: 200px;color: black;background: lightgrey 0% 0% no-repeat padding-box;border-radius: 10px;font-family: 'Roboto', sans-serif;font-weight: bold;" value="Atención Preferencial" >
                                                        </h1>
                                                    <h1 hidden id="PreferencialActivadot" style="color: black" ><input onclick="valpreft()" id="btnPreferentet" type="button" style="margin: 20px;text-align: center;font-size: 35px;width: 400px;height: 200px;color: white;background: lawngreen 0% 0% no-repeat padding-box;border-radius: 10px;font-family: 'Roboto', sans-serif;font-weight: bold;" value="Atención Preferencial" >
                                                        Seleccione un servicio para el turno preferencial.</h1>
                                                </div>
                                                <br>
                                                <label style="font-weight: bold;font-family: 'Roboto', sans-serif;color: #58585A;font-size: 35px;">Seleccione un servicio para ser atendido:</label>
                                                <br>

                                                <input type="text" id="valServicio" name="valServicio" hidden>
                                                <input type="text" id="valNomServicio" name="valNomServicio" hidden>
                                                <script>
                                                    function valpref() {
                                                        document.getElementById("valPreferencial").value = 'true';
                                                        document.getElementById("PreferencialActivado").hidden = true;
                                                        document.getElementById("PreferencialActivadot").hidden = false;

                                                    }
                                                    function valpreft() {
                                                        document.getElementById("valPreferencial").value = 'false';
                                                        document.getElementById("PreferencialActivado").hidden = false;
                                                        document.getElementById("PreferencialActivadot").hidden = true;
                                                    }
                                                </script>
                                                <input type="text" id="valPreferencial" name="valPreferencial" value="false" hidden >

                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr style="text-align: center;" >
                                    <td width="10%">
                                    </td>

                                    <td colspan="5" width="80%">

                                        <div><br><br><br>
                                            <% //TODO FOR DE SERVICIOS ACTIVOS
                                                Consultas co = new Consultas();
                                                List<Servicio> lstServ = co.serviciosActivos();
                                                for (Servicio s : lstServ) {
                                            %>
                                            <input type="button"   onclick="generarTurno('<%=s.getId()%>', '<%=s.getDescripcionServicio()%>')" style="margin: 20px;text-align: center;font-size: 35px;width: 400px;height: 200px;color: white;background: <%=s.getColor()%> 0% 0% no-repeat padding-box;border-radius: 10px;font-family: 'Roboto', sans-serif;font-weight: bold;" value="<%=s.getDescripcionServicio()%>" data-wait="Espere ..."/>
                                            <%
                                                }
                                            %> 
                                        </div>
                                        <script>
                                            function generarTurno(p1, p2) {

                                                document.getElementById("valServicio").value = p1;
                                                document.getElementById("valNomServicio").value = p2;
                                                document.getElementById("TurnoForm").submit();


                                            }



                                        </script>
                                        <%
                                            System.out.println("valTurno ::: " + request.getParameter("valNomServicio"));
                                            System.out.println("valServicio ::: " + request.getParameter("valServicio"));
                                            System.out.println("valPreferencial ::: " + request.getParameter("valPreferencial"));
                                            String preferencial="";
                                            
                                            
                                            if (null != request.getParameter("valServicio")) {
                                                Consultas coTurno = new Consultas();
                                                turno = coTurno.generarTurno(request.getParameter("valServicio"));
                                                if(request.getParameter("valPreferencial").equalsIgnoreCase("true")){
                                            preferencial="*";
                                            }
                                                System.out.println("turno ::: " + turno);
                                                Consultas saveTurno = new Consultas();

                                                saveTurno.guardarNuevoTurno(turno, request.getParameter("valNomServicio"), oficina.getNum(), request.getParameter("valPreferencial"));
                                        %>
                                        <script>
                                                    window.location.href = "/Turnos_SADM/index.htm?turno=<%=turno+preferencial%>";
                                        </script>
                                        <%
                                                //response.sendRedirect("/Turnos_SADM/index.htm?turno=" + turno);

                                            } else {
                                                System.out.println("valServicio ::: " + request.getParameter("valServicio"));
                                            }


                                        %>
                                    </td>
                                    <td width="10%">

                                    </td>
                                </tr>



                            </tbody>

                        </table>

                    </div>
                </div>

            </div>

        </form>

    <dialog id="ticketPrint" >
        <div id="turnoDiv" hidden style="text-align: center;" >
            <label style="font-weight: bold;"><center><strong>Servicios de Agua y Drenaje de Monterrey I.P.D.</strong></center></label>
            <hr  width="60%">
            <label><center><strong>Atentido en Sucursal:</strong></center></label>
            <label style="font-weight: bold;"><center><strong><%=oficina.getNombre()%></strong></center></label>
            <label id="lblFechaTurno"><center><strong></strong></center></label>
            <hr width="60%">
            <label><center><strong>Número de Turno asignado:</strong></center></label>
            <label style="font-weight: bold;font-family: 'Roboto', sans-serif;color: black;font-size: 60px;"><center><%=request.getParameter("turno")+preferencial%></center></label>
            <label><center><strong>Favor de esperar en el área de ventanillas</strong></center></label>
            <hr  width="60%">
            <label><center><strong>Con la app de Servicios de Agua y Drenaje de Monterrey</strong></center></label>
            <label><center><strong>también puedes realizar varios</strong></center></label>
            <label><center><strong>trámites administrativos desde</strong></center></label>
            <label><center><strong>tu dispositivo móvil</strong></center></label>
            <label><center><strong>Encuentranos como AYD en Google Play y App Store.</strong></center></label>
            <center><img src="archivos/uploaded_files/AyDqr.png" onclick="window.parent.location.href = 'https://www.sadm.gob.mx/SADM/qr.html';" style="width: 30%;margin: 10px;"/>
            </center><br><label><center>:::</center></label>


        </div>

    </dialog>
    <script>
        function imprimirTurno(turnoDiv) {
            fechaenpantalla();
            var ficha = document.getElementById(turnoDiv);
            var ventimp = window.open(' ', 'popimpr');
            ventimp.document.write(ficha.innerHTML);
            ventimp.document.close();
            ventimp.print();
            ventimp.close();
            ticketPrint.close();

        }

        $(function () {
            var actualizarHora = function () {
                var fecha = new Date(),
                        hora = fecha.getHours(),
                        minutos = fecha.getMinutes(),
                        segundos = fecha.getSeconds(),
                        diaSemana = fecha.getDay(),
                        dia = fecha.getDate(),
                        mes = fecha.getMonth(),
                        anio = fecha.getFullYear(),
                        ampm;

                var $pHoras = $("#horas"),
                        $pSegundos = $("#segundos"),
                        $pMinutos = $("#minutos"),
                        $pAMPM = $("#ampm"),
                        $pDiaSemana = $("#diaSemana"),
                        $pDia = $("#dia"),
                        $pMes = $("#mes"),
                        $pAnio = $("#anio");
                var semana = ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'];
                var meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];

                $pDiaSemana.text(semana[diaSemana]);
                $pDia.text(dia);
                $pMes.text(meses[mes]);
                $pAnio.text(anio);
                if (hora >= 12) {
                    hora = hora - 12;
                    ampm = "PM";
                } else {
                    ampm = "AM";
                }
                if (hora == 0) {
                    hora = 12;
                }
                if (hora < 10) {
                    $pHoras.text("0" + hora)
                } else {
                    $pHoras.text(hora)
                }
                ;
                if (minutos < 10) {
                    $pMinutos.text("0" + minutos)
                } else {
                    $pMinutos.text(minutos)
                }
                ;
                if (segundos < 10) {
                    $pSegundos.text("0" + segundos)
                } else {
                    $pSegundos.text(segundos)
                }
                ;
                $pAMPM.text(ampm);

            };


            actualizarHora();
            var intervalo = setInterval(actualizarHora, 1000);
        });
    </script>

</body>
</html>
