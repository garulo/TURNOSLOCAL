<%@page import="com.sadm.turnos.dao.ConexionProperties"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.sadm.turnos.dao.RutaProperties"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.sadm.turnos.dao.Oficina"%>
<%@page import="com.sadm.turnos.controlador.Consultas"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Turnos SADM</title>
        <link href="archivos/uploaded_files/Icono_SADM.png" rel="shortcut icon" type="image/x-icon" />
        <link href="archivos/uploaded_files/logo_sadm_color.png" rel="apple-touch-icon" />
        <script src="archivos/js/jquery.min.js"></script>
        <style>
            body{
                margin: 0;display: flex;
            }
            video {
                position: fixed;
                min-width: 100%;
                min-height: 100%;
                left: 50%;
                top: 50%;
                transform: translateX(-50%) translateY(-50%);
                z-index: -1;
                /*-webkit-filter:sepia(100%);*/
            }
        </style>
        <link href="archivos/css/roboto.css" rel="stylesheet">
        <script src="archivos/js/sweetalert.min.js"></script>
        <!--<script type="text/javascript">
                    function is_chrome() {
                    var txt = "";
                            txt = navigator.userAgent;
                            // alert(txt);
                            var e = txt.includes("Edg");
                            var f = txt.includes("Firefox");
                            var o = txt.includes("OPR");
                            if (e){swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) = > {window.parent.location.href = 'https://web.sadm.gob.mx/'}); };
                            if (f){swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) = > {window.parent.location.href = 'https://web.sadm.gob.mx/'}); };
                            if (o){swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) = > {window.parent.location.href = 'https://web.sadm.gob.mx/'}); };
                    }
        </script>-->
    </head>
    <%
    ConexionProperties cpT = new ConexionProperties();
    String wsUri = cpT.getWsuri();
    System.out.println("wsUri :: " + wsUri);
    
    %>
    <script type="text/javascript">
        var wsUri = "<%=wsUri%>";
        var websocket = new WebSocket(wsUri); //creamos el socket
        websocket.onopen = function (evt) { //manejamos los eventos...
            //log("Conectado..."); //... y aparecerá en la pantalla
            //log(evt.data);
        };
        websocket.onmessage = function (evt) { // cuando se recibe un mensaje
            //log("Mensaje recibido:" + evt.data);
            log(evt.data);
        };
        websocket.onerror = function (evt) {
            //log("oho!.. error:" + evt.data);
            log(evt.data);
        };
        function log(mensaje) { //aqui mostrará el LOG de lo que está haciendo el WebSocket
            //var logDiv = document.getElementById("log");
            //logDiv.innerHTML = (mensaje + '<br/>');

            var cadena = mensaje;
            nuevaCadena = cadena.replace('"', '');
            nuevaCadena = nuevaCadena.replace('"', '');
            var arrayDeCadenas = nuevaCadena.split(",");
            for (var i = 0; i < arrayDeCadenas.length; i++) {
                if (arrayDeCadenas[1]) {
                    document.getElementById('vf').innerHTML = arrayDeCadenas[0];
                    play();
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tf').innerHTML = arrayDeCadenas[1];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tf1').innerHTML = arrayDeCadenas[2];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tf2').innerHTML = arrayDeCadenas[3];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tf3').innerHTML = arrayDeCadenas[4];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tf4').innerHTML = arrayDeCadenas[5];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tv1').innerHTML = arrayDeCadenas[6];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tt1').innerHTML = arrayDeCadenas[7];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tv2').innerHTML = arrayDeCadenas[8];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tt2').innerHTML = arrayDeCadenas[9];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tv3').innerHTML = arrayDeCadenas[10];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tt3').innerHTML = arrayDeCadenas[11];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tv4').innerHTML = arrayDeCadenas[12];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tt4').innerHTML = arrayDeCadenas[13];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tv5').innerHTML = arrayDeCadenas[14];
                }
                if (arrayDeCadenas[1]) {
                    document.getElementById('tt5').innerHTML = arrayDeCadenas[15];
                }

            }

        }
        ;
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
        });</script>
    <script>
        function play() {
            var audio = document.getElementById("audio");
            audio.play();
            fechaenpantalla();
        }
        function  fechaenpantalla() {
           var meses = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");
        var diasSemana = new Array("Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado");
        var f = new Date();
        document.getElementById('lblfecha').innerHTML =diasSemana[f.getDay()] + ", " + f.getDate() + " de " + meses[f.getMonth()] + " de " + f.getFullYear();
   }
    </script>
   
    <body onchange="play();" onclick="play();" >
        <div id="logDiv" name="logDiv"></div>
        <%
            Consultas ofi = new Consultas();
            Oficina oficina = ofi.consulNombreOficina();
            // System.out.println("*** "+oficina.getVideo()+"***");
        %>
        <video controls="true" autoplay loop  poster="<%=oficina.getPoster()%>" >
            <!-- <source src="archivos/uploaded_files/Agua_vid.mp4" > -->
            <source src="<%=oficina.getVideo()%>" > 
        </video>

        <div style="float: left;width: 100%;" >  
            <audio style="display: none;" id="audio" controls>
                <source type="audio/wav" src="archivos/uploaded_files/BELL1.mp3">
            </audio>
            <div >
                <table id="Table" class="table" style="alignment-adjust: central;" width="100%">

                    <tbody  style="alignment-baseline: central;width: 100%"  >

                        <tr >
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
                            <td rowspan="2"><img style="margin-left: 20px;"  width="25%" src="archivos/uploaded_files/logo_sadm_2_2.png" ></td>

                            <td style="margin: 5px;alignment-adjust: auto;text-align: center;background-color: #003979;width:225px; "><label  id="lblfecha" style="font-family: 'Roboto', sans-serif;color: white;font-size:  calc(1em + 1vw);color: white;"></label></td>
                            <td width="200"  style="alignment-adjust: auto;text-align: center;background-color: #003979;width: 150px;">
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
                            font-size:  calc(1em + 1vw);
                        }

                    </style>
                    <td  width="250" style="margin: 5px;alignment-adjust: auto;text-align: center;background-color: #003979;">
                        <div class="contenedorreloj">
                            <div class="widgetreloj">
                                <div class="reloj">
                                    <strong><label id="horas" class="horas"></label> <label >:</label>
                                        <label id="minutos" class="minutos"></label><label >:</label>
                                        <label id="segundos" class="segundos"></label>
                                        <label id="ampm" class="ampm"></label></strong>


                                </div>
                            </div>
                        </div>
                    </td>
                    </tr>
                    <tr style="height: 50px;">
                    </tr>

                    </tbody>


                </table>
            </div>
            <div style="float: right;width: 35%;" onclick="listadoTurnos();" >
                <table border="1"  style="background-color:rgba(0, 0, 0, 0.2);width: 90%" >

                    <thead >
                    <th style="font-size: calc(2em + 2vw);font-family: 'Roboto', sans-serif;color: #003979;" colspan="2">ATENDIDOS</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="background-color: #003979;margin-left: 70px;alignment-adjust: auto;text-align: center;" ><label style="font-size: calc(1.5em + 1.5vw);font-family: 'Roboto', sans-serif;color: white;"><strong>Ventanilla</strong></label></td>
                            <td style="background-color: #003979;margin-left: 70px;alignment-adjust: auto;text-align: center;" ><label style="font-size: calc(1.5em + 1.5vw);font-family: 'Roboto', sans-serif;color: yellow;"><strong>Turno</strong></label></td>
                        </tr>

                        <tr >
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tv1" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: calc(1.5em + 1.5vw);"></label></td>
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tt1" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: yellow;font-size: calc(1.5em + 1.5vw);"></label></td>
                        </tr>
                        <tr >
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tv2" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: calc(1.5em + 1.5vw);"></label></td>
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tt2" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: yellow;font-size: calc(1.5em + 1.5vw);"></label></td>
                        </tr>
                        <tr >
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tv3" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: calc(1.5em + 1.5vw);"></label></td>
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tt3" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: yellow;font-size: calc(1.5em + 1.5vw);"></label></td>
                        </tr>
                        <tr >
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tv4" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: calc(1.5em + 1.5vw);"></label></td>
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tt4" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: yellow;font-size: calc(1.5em + 1.5vw);"></label></td>
                        </tr>
                        <tr >
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tv5" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: calc(1.5em + 1.5vw);"></label></td>
                            <td style="margin-left: 5px;alignment-adjust: auto;text-align: center;"><label id="tt5" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: yellow;font-size: calc(1.5em + 1.5vw);"></label></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div style="position: fixed;bottom: 0;float: left;width: 100%;margin-bottom: 10px;" onclick="play();"  >
                <table class="table" style="alignment-adjust: central;" width="100%" >
                    <tbody style="alignment-baseline: central;width: 100%" >
                        <tr>
                            <td colspan="6" style="alignment-adjust: auto;text-align: center;background-color: white;height: 70px;">

                                <label style="font-size: 30px;color: #003979;font-family: sans-serif"><center><strong><%=oficina.getNombre().toUpperCase()%></strong></center></label>

                            </td>
                        </tr>
                        <tr >
                            <td  rowspan="3" style="alignment-adjust: auto;text-align: center;background-color:  #006EB2;"><label style="font-family: 'Roboto', sans-serif;color: white;font-size: 30px;"><strong>ATENDIENDO TURNO</strong></label><br><label id="tf" style="font-weight: bold;font-size: 80px;font-family: 'Roboto', sans-serif;color: white;"></label></td>
                            <td rowspan="3" style="alignment-adjust: auto;text-align: center;background-color:  #006EB2;"><label style="font-family: 'Roboto', sans-serif;color: #FFC20A;font-size: 30px;"><strong>VENTANILLA</strong></label><br><label id="vf" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: #FFC20A;font-size: 80px;"></label></td>
                        </tr>
                        <tr>    
                            <td  colspan="4" style="alignment-adjust: auto;text-align: center;background-color: #1AAAE3;" ><label style="font-family: 'Roboto', sans-serif;color: white;font-size: 16px;"><strong>PRÓXIMOS TURNOS</strong></label></td>
                        </tr>
                        <tr>    
                            <td style="alignment-adjust: auto;text-align: center;background-color: #003979;" ><label style="font-family: 'Roboto', sans-serif;color: white;"><strong>Turno</strong></label><br><label id="tf1" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: 40px;"></label></td>
                            <td  style="alignment-adjust: auto;text-align: center;background-color: #003979;" ><label style="font-family: 'Roboto', sans-serif;color: white;"><strong>Turno</strong></label><br><label id="tf2" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: 40px;"></label></td>
                            <td  style="alignment-adjust: auto;text-align: center;background-color: #003979;" ><label style="font-family: 'Roboto', sans-serif;color: white;"><strong>Turno</strong></label><br><label id="tf3" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: 40px;"></label></td>
                            <td  style="alignment-adjust: auto;text-align: center;background-color: #003979;" ><label style="font-family: 'Roboto', sans-serif;color: white;"><strong>Turno</strong></label><br><label id="tf4" style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: 40px;"></label></td>

                        </tr>
                    </tbody>
                </table> 
            </div>
        </div>
    </body>
</html>
