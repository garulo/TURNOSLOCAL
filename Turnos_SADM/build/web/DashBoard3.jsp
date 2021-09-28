
<%@page import="com.sadm.turnos.dao.ConexionProperties"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.sadm.turnos.dao.RutaProperties"%>
<%@page import="com.sadm.turnos.dao.UltTurnos"%>
<%@page import="com.sadm.turnos.controlador.ConsultasCentral"%>
<%@page import="com.sadm.turnos.dao.Oficina"%>
<%@page import="com.sadm.turnos.dao.ProxTurnos"%>
<%@page import="com.sadm.turnos.dao.Servicio"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sadm.turnos.dao.Turno"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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

    ConexionProperties cp = new ConexionProperties();
    String wsUri = cp.getWsuri();
    System.out.println("wsUri :: " + wsUri);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ventanilla</title>
        <link href="archivos/uploaded_files/Icono_SADM.png" rel="shortcut icon" type="image/x-icon" />
        <link href="archivos/uploaded_files/logo_sadm_color.png" rel="apple-touch-icon" />
        <script src="archivos/js/jquery.min.js"></script>
        <link rel="stylesheet" href="archivos/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="archivos/js/bootstrap4.min.js"  crossorigin="anonymous"></script>
        <script src="archivos/js/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>

        <script type="text/javascript" src="archivos/js/jquery.min.js">
        </script>
        <script>

            var wsUri = "<%=wsUri%>";
            var websocket = new WebSocket(wsUri); //creamos el socket
            websocket.onopen = function (evt) { //manejamos los eventos...

            };
            websocket.onmessage = function (evt) { // cuando se recibe un mensaje

            };
            websocket.onerror = function (evt) {

            };</script>

        <link href="archivos/css/roboto.css" rel="stylesheet">
        <script src="archivos/js/jquery-3.2.1.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                setTimeout(function () {
                    $(".content2").fadeIn(1500);
                }, 10000);
            });</script>
        <script src="archivos/js/sweetalert.min.js"></script>
        <!--        <script type="text/javascript">
                            function is_chrome() {
                            var txt = "";
                                    txt = navigator.userAgent;
                                    // alert(txt);
                                    var e = txt.includes("Edg");
                                    var f = txt.includes("Firefox");
                                    var o = txt.includes("OPR");
                                    if (e){swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) = > {window.parent.location.href = 'Login.jsp'}); 
                                    if (f){swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) = > {window.parent.location.href = 'Login.jsp'}); 
                                    if (o){swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) = > {window.parent.location.href = 'Login.jsp'}); 
                            }
                </script>-->
    </head>

    <body onload="document.getElementById('btnCrono').click()" >

        <%
            ProxTurnos proxturn = new ProxTurnos();
            String turno = new String();
            String turnoServ = new String();
            String turnoUid = new String();
            String num_aten = new String();
            String usuario1 = new String();
            

            Consultas vent = new Consultas();
            String numVent = vent.consulVentanilla(usuario);
            List<String> lstServ = new ArrayList<String>();
            System.out.println("::: atender1 :::" + request.getParameter("atender"));
            if (null != request.getParameter("atender")) {
                if (request.getParameter("atender") != "") {

                    if (request.getParameter("atender").equals("atender")) {

                        Consultas conTurno = new Consultas();
                        lstServ = conTurno.consulServiciosVentanilla(numVent);
                        
                        Consultas conTpreferencial = new Consultas();
                        boolean preferencial = conTpreferencial.existeturnopref(lstServ, numVent, nombreUser,usuario);

                        Consultas conT = new Consultas();
                        Turno turnoObj = conT.consulSigTurnoVent(lstServ, numVent, nombreUser,usuario,preferencial);

                        if (null != turnoObj.getIntTurno()) {

                            turno = turnoObj.getIntTurno();
                            System.out.println("::: atender turno :::" + turno);
                            turnoServ = turnoObj.getIntServicio();
                            turnoUid = turnoObj.getIdTurno();
                            num_aten = turnoObj.getNum_atenciones();
                            usuario1 = turnoObj.getUsuario1();
                            
                            if (null == turnoObj.getIntTurno()) {

                                turno = "Sin Asignar";
                                turnoServ = "Sin Asignar";

                            }
                        } else {

                            response.sendRedirect("/Turnos_SADM/DashBoard3.jsp");
                        }

                    } else if (request.getParameter("atender").equals("terminar")) {
                        
                        
                        Consultas coT = new Consultas();
                        String statusatencionSelect = request.getParameter("statusatencionSelect");
                        String tiposervicioSelect = request.getParameter("tiposervicioSelect");
                        Boolean terminarTurno = coT.terminarTurno(numVent,statusatencionSelect,tiposervicioSelect);
                        System.out.println(":::  terminarTurno :::" + terminarTurno);
                        ConsultasCentral saveTurnoCentral = new ConsultasCentral();
                        Consultas tt = new Consultas();
                        List<Turno> lstTurn = new ArrayList();
                        lstTurn = tt.allTurnosCentralL();
                        saveTurnoCentral.enviarTurnosEnLinea(lstTurn);

                        turno = "Turno Terminado";
                        turnoServ = "Sin Servicio en Atención";
                    } else if (request.getParameter("atender").equals("reasignar")) {
                        String statusatencionSelect = "Reasignado";
                        Consultas cot = new Consultas();
                        String tiposervicioSelect = "";
                        Boolean terminarTurno = cot.terminarTurno(numVent,statusatencionSelect,tiposervicioSelect);
                        System.out.println(":::  terminarTurno :::" + terminarTurno);
                        Consultas coR = new Consultas();
                        Consultas coTt = new Consultas();
                        Turno t = coTt.obtenerTurnoxId(numVent);
                        System.out.println(":::  t :::" + t.getIdTurno());
                        String servicioReasignado = request.getParameter("statusSelect");
                        Boolean reasignarTurno = coR.reasignarTurno(t, request.getParameter("statusSelect"));

                        turno = "Turno Reasignado";
                        turnoServ = "Sin Servicio en Atención";

                    }

                } else {
                    System.out.println("::: else :::" + request.getParameter("atender"));
                }
            } else {
                System.out.println("::: Sin turnos asignados Asignar else atender null :::");

                turno = "Sin Asignar";
                turnoServ = "Sin Asignar";

            }

            Consultas proxtur = new Consultas();
            proxturn = proxtur.obtenerProxTurnos();
            if (null == proxturn.getTur1()) {
                proxturn.setTur1(" ");
            }
            if (null == proxturn.getTur2()) {
                proxturn.setTur2(" ");
            }
            if (null == proxturn.getTur3()) {
                proxturn.setTur3(" ");
            }
            if (null == proxturn.getTur4()) {
                proxturn.setTur4(" ");
            }

            Consultas ultturn = new Consultas();
            List<UltTurnos> lstTurno = new ArrayList<UltTurnos>();
            lstTurno = ultturn.obtenerUltimosTurnos();

        %>
        <script>

            function ws() {
                websocket.send(JSON.stringify('<%=numVent%>,<%=turno%>, <%=proxturn.getTur1()%>,<%=proxturn.getTur2()%>,<%=proxturn.getTur3()%>,<%=proxturn.getTur4()%>,<%=lstTurno.get(0).getV1()%>,<%=lstTurno.get(0).getTur1()%>,<%=lstTurno.get(1).getV1()%>,<%=lstTurno.get(1).getTur1()%>,<%=lstTurno.get(2).getV1()%>,<%=lstTurno.get(2).getTur1()%>,<%=lstTurno.get(3).getV1()%>,<%=lstTurno.get(3).getTur1()%>,<%=lstTurno.get(4).getV1()%>,<%=lstTurno.get(4).getTur1()%>'));
                    }
        </script>
        <style>
            .dropdown {
                position: relative;
                display: inline-block;
                float: right;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: none;
                min-width: 20px;
                box-shadow: 0px 0px 0px 00px rgba(0,0,0,0.2);

                z-index: 1;
            }

            .dropdown:hover .dropdown-content {
                display: block;
                margin-right:2px;
            }
            .desc {

                text-align: right;
                margin-right: 10px;

            }
        </style>
        <div style="width: 100%;">  
            <br>
            <div style="width: 75%;float: left;">
                <%
                    Consultas ofi = new Consultas();
                    Oficina oficina = ofi.consulNombreOficina();
                %>
                <label style="color: #003979;font-family: sans-serif;font-size: 20px;margin-left: 100px;"><strong><%=oficina.getNombre().toUpperCase()%></strong></label>
            </div>
            <div style="width: 25%;float: right;margin-top: 3px;">
                <img src="archivos/uploaded_files/perfil_colaborador_01.PNG" alt="Perfil"   style="margin-top:3px;width: 60%;margin-left: 50px;">
                <div class="dropdown">

                    <img src="archivos/uploaded_files/perfil_colaborador_02.PNG" alt="Perfil"   style="margin-top:9px;width: 20%;margin-right: 50px;">

                    <div class="dropdown-content">
                        <div class="desc">
                            <form action="cerrarsesion"   method="post" id="formsalir" >
                                <button type="submit" type="button" style="background-color: #668FB7;border-radius: 7px;font-size: 12px;color: white;font-family: 'Roboto', sans-serif;color: white;" data-toggle="modal"  ><strong>CERRAR SESIÓN</strong></button>
                            </form>
                        </div>


                    </div>
                </div>

            </div>
            <br>
        </div>
        <form id="VentanillaForm" >
            <div class="table-responsive">
                <br><br>
                <table  class="table" style="alignment-adjust: central;" width="100%" height="100%">

                    <tbody  style="alignment-baseline: central;">
                        <tr>
                            <%

                                Date fechaActual = new Date();

                                String n_fecha_format = new String();
                                n_fecha_format = new SimpleDateFormat("EEEEEEEEE dd 'de' MMMMM 'de' yyyy").format(fechaActual);
                                n_fecha_format = n_fecha_format.substring(0, 1).toUpperCase() + n_fecha_format.substring(1);
                                DateFormat time = new SimpleDateFormat("HH:mm");
                                String n_time_format = new String();
                                n_time_format = time.format(fechaActual);

                                String numturnos = new String();
                                Consultas col = new Consultas();
                                numturnos = col.turnosfaltantesventanilla(numVent);

                            %>

                            <td colspan="2" style="alignment-adjust: auto;text-align: initial;background-color: #668FB7; "><label style="margin-left: 15px;font-weight: bold;font-size: 15;font-family: 'Roboto', sans-serif;color: white;"><%=nombreUser.toUpperCase()%></label></td>
                            <td colspan="2" style="alignment-adjust: auto;text-align: end;background-color: #668FB7; "><h2 style="margin-right: 15px;font-family: 'Roboto', sans-serif;color: white;font-size: 15px;"><%=n_fecha_format.toUpperCase()%>.</h2></td>
                            <td colspan="2" style="alignment-adjust: auto;text-align: end;background-color: #668FB7; "><h2 style="margin-right: 15px;font-family: 'Roboto', sans-serif;color: #FFC20A;;font-size: 15px;"> <%=numturnos%> Turnos por atender.</h2></td>

                        </tr>
                        <tr>

                            <td  style="alignment-adjust: auto;text-align: center;background-color: #006EB2;"><h4 style="font-weight: bold;font-family: 'Roboto', sans-serif;font-size: 16px;color: #FFC20A;">MI VENTANILLA</h4><h2 style="font-family: sans-serif;font-size: 25px;color: #FFC20A;font-weight: bold;"><%=numVent%></h2></td>
                            <td style="alignment-adjust: auto;text-align: center;background-color: #006EB2;"><h4 style="font-weight: bold;font-family: 'Roboto', sans-serif;font-size: 16px;color: white;">ATENDIENDO TURNO</h4><h2 id="turnoAtendido"  style="font-size: 25px;font-family: 'Roboto', sans-serif;color: white;"><%=turno.toUpperCase()%></h2></td>
                            <td colspan="2" style="alignment-adjust: auto;text-align: center;background-color: #003979;"><h4 style="font-weight: bold;font-family: 'Roboto', sans-serif;font-size: 16px;color: white;">SERVICIOS EN ATENCIÓN</h4><h2 style="font-size: 25px;font-family: 'Roboto', sans-serif;color: white;"><%=turnoServ.toUpperCase()%></h2></td>
                            <td  style="alignment-adjust: auto;text-align: center;background-color: #1AAAE3;"><h4 style="font-weight: bold;font-family: 'Roboto', sans-serif;color: white;font-size: 16px;">TIEMPO DE ATENCIÓN</h4>
                                <div class="crono_wrapper">
                                    <h2 style="font-family: 'Roboto', sans-serif;color: white;font-size: 25px;" id='crono'>00:00:00</h2>
                                    <input id="btnCrono" type="button" value="Empezar" onclick="empezarDetener(this)" hidden>
                                </div></td>

                        </tr>
                        <tr style="height: 10px"></tr>
                        <%
                            if (null != request.getParameter("atender")) {
                                if (request.getParameter("atender") != "") {
                                    if (request.getParameter("atender").equals("atender")) {
                        %>

                        <tr >
                            <td colspan="5" style="text-align:center;" >
                                <div class="sidebar-box" >
                                    <label>SELECCIONA UN SERVICIO PARA REASIGNAR EL TURNO:
                                    <select style="font-family: 'Roboto', sans-serif;font-size: 14px;" id="statusSelect" name="statusSelect" class="styled-select" name="status" onchange="vaidarReasignar()" onChange="mostrar(this.value);">
                                        <option value="">SIN SERVICIO REASIGNADO</option>                                            
                                        <% //TODO FOR DE SERVICIOS ACTIVOS
                                            Consultas co = new Consultas();
                                            List<Servicio> lstS = co.serviciosActivos();
                                            for (Servicio s : lstS) {
                                        %>
                                        <option value="<%=s.getDescripcionServicio()%>"><%=s.getDescripcionServicio().toUpperCase()%></option>                                            
                                        <%
                                            }
                                        %> 
                                    </select></label>

                                </div>
                                <style>
                                    .styled-select { width: 350px; height: 50px; overflow: hidden; background: url(new_arrow.png) no-repeat right #ddd; border: 1px solid #ccc; }
                                    .sidebar-box select{
                                        display:block;
                                        padding: 5px 10px;
                                        height:42px;
                                        margin:10px auto;
                                        min-width: 225px;
                                        -webkit-appearance: none;
                                        height: 40px;
                                        /* background-color: #ffffff; */
                                        background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
                                            linear-gradient(to bottom, #ffffff 0%,#f7f7f7 100%);
                                        background-repeat: no-repeat, repeat;
                                        background-position: right .7em top 50%, 0 0;
                                        background-size: .65em auto, 100%;}

                                </style>
                                <script>
                                    function vaidarReasignar() {
                                        if ("" !== document.getElementById("statusSelect").value) {
                                            document.getElementById("reasignar").hidden = false;
                                            document.getElementById("terminar").hidden = true;
                                        } else {
                                            document.getElementById("reasignar").hidden = true;
//                                            document.getElementById("terminar").hidden = false;
                                        }
                                    }
                                </script>

                            </td>


                        </tr>
                        
                         <tr >
                            <td colspan="5" style="text-align:center;" >
                                <div class="sidebar-box" >
                                    <%
                                    ConsultasCentral cc = new ConsultasCentral();
                                    List<String> tipos = cc.selectTipoServ(turnoServ);
                                    
                                    %>
                                    <label>SELECCIONA UN TIPO DE SERVICIO PARA EL TURNO:
                                    <select style="font-family: 'Roboto', sans-serif;font-size: 14px;" id="tiposervicioSelect" name="tiposervicioSelect" class="styled-select"  onchange="vaidarTipo()" onChange="mostrar(this.value);">
                                        <option value="">SIN TIPO DE SERVICIO</option>                                            
                                        <%for(String t : tipos){
                                        
                                        %>
                                        <option value="<%=t%>"><%=t%> </option>       
                                        <%
                                        } %>
                                    </select></label>

                                </div>
                                <style>
                                    .styled-select { width: 350px; height: 50px; overflow: hidden; background: url(new_arrow.png) no-repeat right #ddd; border: 1px solid #ccc; }
                                    .sidebar-box select{
                                        display:block;
                                        padding: 5px 10px;
                                        height:42px;
                                        margin:10px auto;
                                        min-width: 225px;
                                        -webkit-appearance: none;
                                        height: 40px;
                                        /* background-color: #ffffff; */
                                        background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
                                            linear-gradient(to bottom, #ffffff 0%,#f7f7f7 100%);
                                        background-repeat: no-repeat, repeat;
                                        background-position: right .7em top 50%, 0 0;
                                        background-size: .65em auto, 100%;}

                                </style>
                                <script>
                                    function vaidarTipo() {
                                        if ("" !== document.getElementById("tiposervicioSelect").value) {
                                            document.getElementById("estatus").hidden = false;
                                                document.getElementById("terminar").hidden = true;
                                        } else {
                                            document.getElementById("estatus").hidden = true;
                                            document.getElementById("terminar").hidden = true;
                                        }
                                    }
                                </script>

                            </td>


                        </tr>
                        
                        
                        <tr hidden id="estatus" >
                            <td colspan="5" style="text-align:center;" >
                                <div class="sidebar-box" >
                                    <label>SELECCIONA UN ESTATUS DE ATENCIÓN PARA EL TURNO:
                                    <select style="font-family: 'Roboto', sans-serif;font-size: 14px;" id="statusatencionSelect" name="statusatencionSelect" class="styled-select" name="status" onchange="vaidarEstatusAtencion()" onChange="mostrar(this.value);">
                                        <option value="">SIN ESTATUS DE ATENCION</option>                                            
                                        
                                        <option value="Procedente">Procedente </option>             
                                        <option value="Improcedente">Improcedente </option> 
                                        
                                    </select></label>

                                </div>
                                <style>
                                    .styled-select { width: 350px; height: 50px; overflow: hidden; background: url(new_arrow.png) no-repeat right #ddd; border: 1px solid #ccc; }
                                    .sidebar-box select{
                                        display:block;
                                        padding: 5px 10px;
                                        height:42px;
                                        margin:10px auto;
                                        min-width: 225px;
                                        -webkit-appearance: none;
                                        height: 40px;
                                        /* background-color: #ffffff; */
                                        background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
                                            linear-gradient(to bottom, #ffffff 0%,#f7f7f7 100%);
                                        background-repeat: no-repeat, repeat;
                                        background-position: right .7em top 50%, 0 0;
                                        background-size: .65em auto, 100%;}

                                </style>
                                <script>
                                    function vaidarEstatusAtencion() {
                                        if ("" !== document.getElementById("statusatencionSelect").value) {
                                            document.getElementById("terminar").hidden = false;
                                        } else {
                                            document.getElementById("terminar").hidden = true;
                                        }
                                    }
                                </script>

                            </td>


                        </tr>

                        <tr>

                            <td colspan="5" style="text-align:center;" > 
                                <script>
                                    function atenderTurno() {

                                        document.getElementById("siguiente").hidden = true;
                                        document.getElementById("atender").value = "atender";
                                        document.getElementById("VentanillaForm").submit();
                                    }
                                </script>   


                                <button hidden id="reasignar"   onclick="reasignarTurno()"   onclick="" style="margin: 10px;text-align: center;font-size: 18px;width: 235px;height: 103px;color: white;background: #1AAAE3 0% 0% no-repeat padding-box;border-radius: 10px;"  >REASIGNAR <BR> TURNO</button>

                                <script>
                                    function reasignarTurno() {
                                        document.getElementById("reasignar").hidden = true;
                                        document.getElementById("atender").value = "reasignar";
                                        document.getElementById("VentanillaForm").submit();
                                        //window.open("/Turnos_SADM/index.htm");

                                    }
                                </script>
                                <div class="content2" style="display:none;">
                                    <button id="cancelar" onclick="cancelarTurno()"type="button"   data-toggle="modal" data-target=".bd-cancelar-modal-lg" style="margin: 10px;text-align: center;font-size: 18px;width: 235px;height: 50px;color: white;background: #003979 0% 0% no-repeat padding-box;border-radius: 10px;" >CLIENTE AUSENTE</button>
                                    <script>
                                        function cancelarTurno() {
                                            document.getElementById("cancelar").hidden = true;
                                            document.getElementById("idCancelTurn").value = "<%=turnoUid%>";
                                        }
                                    </script>
                                </div>
                                        
                                <button hidden id="terminar"   onclick="terminarTurno();"  style="margin: 10px;text-align: center;font-size: 18px;width: 235px;height: 103px;color: white;background: #F6610E 0% 0% no-repeat padding-box;border-radius: 10px;" >TERMINAR <BR> TURNO</button>

                            </td>
                    <script>
                        function terminarTurno() {
                            document.getElementById("terminar").hidden = true;
                            document.getElementById("atender").value = "terminar";
                            document.getElementById("VentanillaForm").submit();
                        }
                    </script>

                    </tr> 

                    <%
                    } else if (request.getParameter("atender").equals("terminar")) {
                    %> 
                    
                    <tr>

                        <td  colspan="5" style="text-align:center;" >  <button id="siguiente"   onclick="atenderTurno();" style="margin: 10px;text-align: center;font-size: 18px;width: 235px;height: 103px;color: white;background: #90AFCE 0% 0% no-repeat padding-box;border-radius: 10px;" >ATENDER <BR> TURNO</button>
                            <script>
                                function atenderTurno() {
                                    document.getElementById("siguiente").hidden = true;
                                    document.getElementById("atender").value = "atender";
                                    document.getElementById("VentanillaForm").submit();
                                }
                            </script>   



                            <script>
                                function reasignarTurno() {
                                    document.getElementById("reasignar").hidden = true;
                                    document.getElementById("atender").value = "reasignar";
                                    document.getElementById("VentanillaForm").submit();
                                    //window.open("/Turnos_SADM/index.htm");

                                }
                            </script>
                        </td>
                    <script>
                        function terminarTurno() {
                            document.getElementById("terminar").hidden = true;
                            document.getElementById("atender").value = "terminar";
                            document.getElementById("VentanillaForm").submit();
                        }
                    </script>
                    </tr> 
                    <%
                    } else if (request.getParameter("atender").equals("reasignar")) {


                    %> 
                    <tr>

                        <td colspan="5" style="text-align:center;" >  <button id="siguiente"   onclick="atenderTurno();" style="margin: 10px;text-align: center;font-size: 18px;width: 235px;height: 103px;color: white;background: #90AFCE 0% 0% no-repeat padding-box;border-radius: 10px;" >ATENDER <BR> TURNO</button>
                            <script>
                                function atenderTurno() {

                                    document.getElementById("siguiente").hidden = true;
                                    document.getElementById("atender").value = "atender";
                                    document.getElementById("VentanillaForm").submit();
                                }
                            </script>   



                            <script>
                                function reasignarTurno() {
                                    document.getElementById("reasignar").hidden = true;
                                    document.getElementById("atender").value = "reasignar";
                                    document.getElementById("VentanillaForm").submit();
                                    //window.open("/Turnos_SADM/index.htm");

                                }
                            </script>
                        </td>
                    <script>
                        function terminarTurno() {
                            document.getElementById("terminar").hidden = true;
                            document.getElementById("atender").value = "terminar";
                            document.getElementById("VentanillaForm").submit();
                        }
                    </script>
                    </tr> 
                    <%                   }

                    } else {
                    %> 
                    <tr>
                        <td colspan="5" style="text-align:center;" > 
                            <button id="siguiente"   onclick="atenderTurno();" style="margin: 10px;text-align: center;font-size: 18px;width: 235px;height: 103px;color: white;background: #90AFCE 0% 0% no-repeat padding-box;border-radius: 10px;" >ATENDER <BR> TURNO</button>
                            <script>
                                function atenderTurno() {
                                    document.getElementById("siguiente").hidden = true;
                                    document.getElementById("atender").value = "atender";
                                    document.getElementById("VentanillaForm").submit();
                                }
                            </script>   
                    </tr> 
                    <%
                        }
                    } else {
                    %> 

                    <tr>

                        <td colspan="5" style="text-align:center;" > <button id="siguiente"   onclick="atenderTurno();" style="margin: 10px;text-align: center;font-size: 18px;width: 235px;height: 103px;color: white;background: #90AFCE 0% 0% no-repeat padding-box;border-radius: 10px;" >ATENDER <BR> TURNO</button>
                            <script>
                                function atenderTurno() {
                                    document.getElementById("siguiente").hidden = true;
                                    document.getElementById("atender").value = "atender";
                                    document.getElementById("VentanillaForm").submit();
                                }
                            </script>   
                    </tr> 
                    <%
                        }
                    %>

                    </tbody>
                </table>
                <input type="text" id="atender" name="atender" hidden> 

            </div>





        </form>

        <style>
            .crono_wrapper {text-align:center;}
        </style>
        <script>var inicio = 0;
            var timeout = 0;
            function empezarDetener(elemento)
            {
                if (timeout === 0)
                {
                    // empezar el cronometro

                    elemento.value = "Detener";
                    // Obtenemos el valor actual
                    inicio = vuelta = new Date().getTime();
                    // iniciamos el proceso
                    funcionando();
                } else {
                    // detemer el cronometro

                    elemento.value = "Empezar";
                    clearTimeout(timeout);
                    timeout = 0;
                }
            }

            function funcionando()
            {
                // obteneos la fecha actual
                var actual = new Date().getTime();
                // obtenemos la diferencia entre la fecha actual y la de inicio
                var diff = new Date(actual - inicio);
                // mostramos la diferencia entre la fecha actual y la inicial
                var result = LeadingZero(diff.getUTCHours()) + ":" + LeadingZero(diff.getUTCMinutes()) + ":" + LeadingZero(diff.getUTCSeconds());
                document.getElementById('crono').innerHTML = result;
                // Indicamos que se ejecute esta función nuevamente dentro de 1 segundo
                timeout = setTimeout("funcionando()", 1000);
                var aten = getParamByName('atender');
                if (null !== aten) {

                    if (aten === "atender") {
                        ws();
                    }
                }
            }

            /* Funcion que pone un 0 delante de un valor si es necesario */
            function LeadingZero(Time) {
                return (Time < 10) ? "0" + Time : +Time;
            }

            /**
             * @param String name
             * @return String
             */
            function getParamByName(name) {
                name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
                var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                        results = regex.exec(location.search);
                return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
            }

        </script>
        <style>
            /* The container must be positioned relative: */
            .custom-select {
                position: relative;
                font-family: Arial;
            }

            .custom-select select {
                display: none; /*hide original SELECT element: */
            }

            .select-selected {
                background-color: DodgerBlue;
            }

            /* Style the arrow inside the select element: */
            .select-selected:after {
                position: absolute;
                content: "";
                top: 14px;
                right: 10px;
                width: 0;
                height: 0;
                border: 6px solid transparent;
                border-color: #fff transparent transparent transparent;
            }

            /* Point the arrow upwards when the select box is open (active): */
            .select-selected.select-arrow-active:after {
                border-color: transparent transparent #fff transparent;
                top: 7px;
            }

            /* style the items (options), including the selected item: */
            .select-items div,.select-selected {
                color: #ffffff;
                padding: 8px 16px;
                border: 1px solid transparent;
                border-color: transparent transparent rgba(0, 0, 0, 0.1) transparent;
                cursor: pointer;
            }

            /* Style items (options): */
            .select-items {
                position: absolute;
                background-color: DodgerBlue;
                top: 100%;
                left: 0;
                right: 0;
                z-index: 99;
            }

            /* Hide the items when the select box is closed: */
            .select-hide {
                display: none;
            }

            .select-items div:hover, .same-as-selected {
                background-color: rgba(0, 0, 0, 0.1);
            }

        </style>


        <!-- CANCELAR TURNO-->
        <div class="modal fade bd-cancelar-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <form action="cancelarturno"  method="post" id="formCancelarTurno" >
                    <input hidden id="idCancelTurn" name="idCancelTurn">

                    <div class="modal-content" >

                        <div style="width: 100%;text-align: center;">
                            <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>CANCELAR TURNO</strong></h1>
                        </div>
                        <div class="card">
                            <div class="card-body" style="">
                                <div >
                                    <h1 style="font-size: 18px;font-family: 'Roboto', sans-serif;color: gray;"> EL TURNO SE CANCELARÁ DESPUÉS DE ATENDERSE EN 3 OCASIONES</h1>
                                </div>

                            </div>   
                        </div>

                        <div class="modal-footer">

                            <button id="btnCancelarTurno" onclick="submit()" type="button" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>ENVIAR TURNO A ESPERA</strong></button>
                            <button  type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CANCELAR</strong></button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </body>
</html>
