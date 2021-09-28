<%@page import="com.sadm.turnos.dao.Oficina"%>
<%@page import="com.sadm.turnos.dao.Usuario"%>
<%@page import="com.sadm.turnos.dao.Servicio"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sadm.turnos.dao.Ventanilla"%>
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
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrador Local de Turnos SADM</title>
        <link href="archivos/uploaded_files/Icono_SADM.png" rel="shortcut icon" type="image/x-icon" />
        <link href="archivos/uploaded_files/logo_sadm_color.png" rel="apple-touch-icon" />
        <script src="archivos/js/jquery.min.js"></script>
        <link rel="stylesheet" href="archivos/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="archivos/js/bootstrap4.min.js"  crossorigin="anonymous"></script>
        <script src="archivos/js/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>

        <script type="text/javascript" src="archivos/js/jquery.min.js">
        </script>
        <style>
            .demo input[type="checkbox"] {
                display: none;
            }
            .demo input[type="checkbox"] + label span {
                display: inline-block;
                width: 15px;
                height: 15px;
                margin: -1px 4px 0 0;
                vertical-align: middle;
                background: url(archivos\\uploaded_files\\checkbox_uncheck.png);
                background-size: cover;
                cursor: pointer;
            }
            .demo input[type="checkbox"]:checked + label span {
                background: url(archivos\\uploaded_files\\checkbox_check.png);
                background-size: cover;
            }
        </style>
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
        <link href="archivos/css/roboto.css" rel="stylesheet">
        <script src="archivos/js/bootstrap3.min.js"></script>
        <script>
                    $(document).ready(function () {
            $("#myInput").on("keyup", function () {
            var value = $(this).val().toLowerCase();
                    $("#myTable tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > - 1)
            });
            });
                    $("#myInput2").on("keyup", function () {
            var value = $(this).val().toLowerCase();
                    $("#myTable2 tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > - 1)
            });
            });
            });</script>
        <script src="archivos/js/sweetalert.min.js"></script>
        <script type="text/javascript">
                    function is_chrome() {
                    var txt = "";
                            txt = navigator.userAgent;
                            // alert(txt);
                            var e = txt.includes("Edg");
                            var f = txt.includes("Firefox");
                            var o = txt.includes("OPR");
                            if (e){swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) = > {window.parent.location.href = 'Login.jsp'}); };
                            if (f){swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) = > {window.parent.location.href = 'Login.jsp'}); };
                            if (o){swal("Navegador incompatible.!", "El navegador debe ser Chrome.", "error").then((value) = > {window.parent.location.href = 'Login.jsp'}); };
                    }
        </script>
    </head>
    <body onload="is_chrome();">
        <div class="modal fade bd-perfil-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">


                <div class="modal-content" style="background-color: #668FB7;">

                    <div class="modal-header" >
                        <div style="width: 100%;text-align: center;">
                            <h1 style="background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong> Perfil Local</strong></h1><br>
                        </div>
                    </div>
                    <div class="modal-body">

                        <div class="card">
                            <div class="card-body">

                                <!--
                                <div class="form-group">
                                    <form action="enviarturnos"  method="post" id="formEnviarTurnos" >
                                        <div style="width: 30%">
                                            <label style="font-family: 'Roboto', sans-serif;"><strong>Última Fecha de Envío</strong></label></div>
                                <%
                                    Consultas c = new Consultas();
                                    String fech = c.obtenerFchLastEnvioCentral();
                                %>
                            <div style="width: 30%">
                                <input type="datetime" value="<%=fech%>" readonly></div>

                        </form>

                    </div>


                    <div class="form-group">
                        <form action="enviarturnos"  method="post" id="formEnviarTurnos" >
                            <label style="font-family: 'Roboto', sans-serif;"><strong>Enviar la operación de Turnos a la Oficina Central</strong></label>
                            <div style="width: 100%">
                                <button  onclick="submit()" type="button" class="btn btn-primary" style="background-color: #006EB2;color: white;;font-family: 'Roboto', sans-serif;margin: 5px;">ENVIAR TURNOS A CENTRAL</button>
                            </div>
                        </form>

                    </div>
                                -->




                                <ul  class="nav nav-tabs"  role="tablist">
                                    <li style="width: 50%;"  class="nav-item">


                                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#vid" role="tab" aria-controls="home">Video</a>

                                    </li>
                                    <li style="width: 50%;"  class="nav-item">
                                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#img" role="tab" aria-controls="profile" >Poster</a>
                                    </li>

                                </ul>
                                <div class="tab-content"style="text-align:center;">

                                    <div class="tab-pane active" id="vid" role="tabpanel" aria-labelledby="home-tab" >
                                        <div class="form-group"><br>
                                            <div style="width: 100%;">
                                                <form action="actualizarperfil"  method="post" id="formActualizarPerfil"  enctype="multipart/form-data" >
                                                    <div style="float: left;">
                                                        <label style="margin: 5px;font-family: 'Roboto', sans-serif;" for="exampleFormControlFile1"><strong>Selecciona un video de fondo</strong></label>
                                                        <div style="width: 100%; text-align: center;">
                                                            <input onchange="selecVideo()" name="archivossubidos[]"type="file" class="form-control-file" id="archivossubidos[]" >

                                                            <input type="text" id="TxtViNameSelected" name="TxtViNameSelected" hidden>
                                                        </div></div>
                                                    <div style="float: right;">
                                                        <button id="btnPerfil" onclick="submit()" type="button" class="btn btn-primary" style="background-color: #006EB2;color: white;;font-family: 'Roboto', sans-serif;margin: 5px;">GUARDAR CAMBIOS</button>
                                                    </div>
                                                </form>
                                            </div></div></div>

                                    <div class="tab-pane" id="img" role="tabpanel" aria-labelledby="home-tab" >
                                        <div class="form-group"><br>
                                            <div style="width: 100%;">
                                                <form action="actualizarperfilimg"  method="post" id="formActualizarPerfilImg"  enctype="multipart/form-data" >
                                                    <div style="float: left;">
                                                        <label style="margin: 5px;font-family: 'Roboto', sans-serif;" for="exampleFormControlFile1"><strong>Selecciona una imagen de poster</strong></label>
                                                        <div style="width: 100%; text-align: center;">
                                                            <input onchange="selecImg()" name="archivosubido"type="file" class="form-control-file" id="archivosubido" >

                                                            <input type="text" id="TxtImgNameSelected" name="TxtImgNameSelected" hidden>
                                                        </div></div>
                                                    <div style="float: right;">
                                                        <button id="btnPerfilimg" onclick="submit()" type="button" class="btn btn-primary" style="background-color: #006EB2;color: white;;font-family: 'Roboto', sans-serif;margin: 5px;">GUARDAR CAMBIOS</button>
                                                    </div></form>
                                            </div></div></div>

                                </div>
                            </div></div>
                    </div>  <button type="button" class="btn btn-secondary" data-dismiss="modal" style="font-family: 'Roboto', sans-serif;margin: 5px;">CERRAR</button>

                </div>

            </div>
        </div>
       
        <script>
            function selecVideo() {

            document.getElementById("TxtViNameSelected").value = "archivos/uploaded_files/" + document.getElementById('archivossubidos[]').files[0].name;
            }
            function selecImg() {

            document.getElementById("TxtViNameSelected").value = "archivos/uploaded_files/" + document.getElementById('archivossubidos[]').files[0].name;
            }
        </script>

    </div>

</div>
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
                            <button type="button" style="margin-top: 5px;background-color: #668FB7;border-radius: 7px;font-size: 12px;color: white;font-family: 'Roboto', sans-serif;color: white;" data-toggle="modal" data-target=".bd-perfil-modal-lg" ><strong>DASHBOARD</strong></button>
                            <button type="button" style="margin-top: 5px;background-color: #668FB7;border-radius: 7px;font-size: 12px;color: white;font-family: 'Roboto', sans-serif;color: white;" onclick="location.href='Reportes.jsp'"><strong>REPORTES</strong></button>
                            <form action="cerrarsesion"   method="post" id="formSalir" >

                                <button type="submit" style="margin-top: 5px;background-color: #668FB7;border-radius: 7px;font-size: 12px;color: white;font-family: 'Roboto', sans-serif;color: white;" data-toggle="modal"  style="margin: 5px;"><strong>CERRAR SESIÓN</strong></button>

                            </form>
                            
                        </div>

                    </div>
                </div>


        </tr>
        <tr>
            <td colspan="5" style="alignment-adjust: auto;text-align: end;background-color: white;"><label style="font-weight: bold;font-size: 22px;font-family: 'Roboto', sans-serif;color: #58585A;"><strong>Bienvenido:</strong>  <%=nombreUser%></label></td>
            <td width="80" ></td>
        </tr>

        <tr >

            <td colspan="6" style="alignment-adjust: auto;text-align: center;">
                <div style="text-align:center;">
                    <!--  <ul class="nav nav-tabs"  role="tablist"> -->

                    <ul  class="nav nav-tabs"  role="tablist">
                        <li style="width: 50%;"  class="nav-item">


                            <a class="nav-link active" id="home-tab" data-toggle="tab" href="#asignar" role="tab" aria-controls="home"><img style="width: 100%;" src="archivos\uploaded_files\asignarventanillaservicios.PNG" title="ASIGNAR VENTANILLA Y SERVICIO"/></a>

                        </li>
                        <li style="width: 50%;"  class="nav-item">
                            <a class="nav-link" id="profile-tab" data-toggle="tab" href="#alta" role="tab" aria-controls="profile" ><img style="width: 100%;" src="archivos\uploaded_files\altaadminusuarios.PNG" title="ALTA Y ADMINISTRACIOÓN DE USUARIOS"/></a>
                        </li>

                    </ul>

                    <div class="tab-content"style="text-align:center;">

                        <div class="tab-pane active" id="asignar" role="tabpanel" aria-labelledby="home-tab" style="text-align:center;">


                            <div class="form-group" style="text-align:center;" >

                                <div style="overflow: scroll;max-height:300px" >
                                    <table class="table table-striped">
                                        <%

                                            Consultas ventanillas = new Consultas();
                                            List<Ventanilla> lstVent = new ArrayList();
                                            lstVent = ventanillas.allVentanillas();
                                        %>
                                        <thead>
                                            <tr> 
                                        <label style="margin-right: 40px;margin-bottom: 20px;margin-top: 10px;margin-left: 50px;float: left;color: #516179;font-weight: bold;font-size: 22px;font-family: 'Roboto', sans-serif;"><span>Filtros</span>
                                            <input id="myInput" style="border-top: none;border-left: none;border-right: none;border-bottom-color: #90AFCE;width: 500px;color:#A0A0A0;font-size: 14px;font-family: 'Roboto', sans-serif;"   type="search" placeholder="Búsqueda por ventanilla, nombre, personal asignado a ventanilla">

                                            <img style="margin-left: 10px;width: 5%;" src="archivos\uploaded_files\lupa.PNG" title="Buscar"/>
                                        </label>
                                        </tr>
                                        <tr>
                                            <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Ventanilla</th>
                                            <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Nombre</th>
                                            <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Personal asignado a ventanilla</th>
                                            <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;"scope="col">Acciones</th>
                                        </tr>
                                        </thead>
                                        <tbody id="myTable">
                                            <%
                                                for (Ventanilla v : lstVent) {

                                            %>
                                            <tr>

                                                <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=v.getNombre()%></td>
                                                <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=v.getDesc()%></td>
                                                <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=v.getUsuario()%></td>
                                                <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;width: 20%;">
                                                    <button type="button"  onclick="editarVentanilla('<%=v.getId()%>', '<%=v.getNombre()%>', '<%=v.getDesc()%>', '<%=v.getServicios()%>')"  data-toggle="modal" data-target=".bd-editar-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\editar.PNG" title="Editar"/></button>
                                                    <button type="button" onclick="eliminarVentanilla('<%=v.getId()%>')"  data-toggle="modal" data-target=".bd-eliminar-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\borrar.PNG" title="Eliminar"/></button>
                                                </td>
                                            </tr>
                                            <%

                                                }
                                            %>
                                            <tr>


                                            </tr>
                                        </tbody>
                                        <script>
                                                    function eliminarVentanilla(p1) {
                                                    document.getElementById("idVentElim").value = p1;
                                                    }
                                            function editarVentanilla(p1, p2, p3, p4) {
                                            document.getElementById("txtIdEditV").value = p1;
                                                    document.getElementById("txtNombreEditV").value = p2;
                                                    document.getElementById("txtDescEditV").value = p3;
                                                    var espacio = " ";
                                                    dividirCadena(p4, espacio);
                                            }
                                            function dividirCadena(cadenaADividir, separador) {
                                            var arrayDeCadenas = cadenaADividir.split(separador);
                                                    for (var i = 0; i < arrayDeCadenas.length; i++) {
                                            if (null !== document.getElementById("Check" + arrayDeCadenas[i])) {
                                            document.getElementById("Check" + arrayDeCadenas[i]).checked = 1;
                                                    document.getElementById("serSelec").value = document.getElementById("serSelec").value + arrayDeCadenas[i] + " ";
                                            }
                                            }
                                            }
                                        </script>
                                    </table>

                                </div>
                                <div>
                                    <button type="button"  data-toggle="modal" data-target=".bd-agregar-modal-lg" style="width: 8%;height: 8%;margin-right: 50px;margin-top: 10px;border: none;background-color: white;float: right;"><img style="width: 50%;" src="archivos\uploaded_files\btnagregar.png" title="Agregar nueva ventanilla"/></button>
                                </div>
                            </div>
                            <!-- ELIMINAR VENTANILLA-->
                            <div class="modal fade bd-eliminar-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <form action="eliminarventana"  method="post" id="formEliminarVentana" >
                                        <input type="text" autofocus="true"  name="idVentElim" data-name="IdVentElim" id="idVentElim" hidden/>

                                        <div class="modal-content" >

                                            <div style="width: 100%;text-align: center;">
                                                <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>ELIMINAR VENTANILLA</strong></h1>
                                            </div>


                                            <div class="card">
                                                <div class="card-body" style="">
                                                    <div >
                                                        <h1 style="font-size: 18px;font-family: 'Roboto', sans-serif;color: gray;"> ¿Estás seguro de eliminar la ventanilla seleccionada?</h1>
                                                    </div>

                                                </div>   
                                            </div>

                                            <div class="modal-footer">
                                                <button id="btnElimVent" onclick="submit()" type="button" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>CONFIRMAR ELIMINAR</strong></button>
                                                <button  type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CANCELAR</strong></button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                            </div>
                            <!-- AGREGAR VENTANILLA-->
                            <div class="modal fade bd-agregar-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <form action="agregarventana"  method="post" id="formAgregarVentana" name="formAgregarVentana" >
                                        <div class="modal-content">


                                            <div style="width: 100%;text-align: center;">
                                                <h1 style="font-size: 20px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>AGREAR NUEVA VENTANILLA</strong></h1>
                                            </div>


                                            <div class="card">
                                                <div class="card-body">
                                                    <div style="float: left;width: 50%;">
                                                        <div class="input-group-prepend">
                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ventanilla</strong></label>
                                                        </div>
                                                        <div style="width: 90%">
                                                            <input placeholder="Teclea el número de ventanilla" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" onblur="valventnum()"  id="agreVentNombre" name="agreVentNombre" type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                            <script>
                                                                        function valventnum() {
                                                                        if (document.getElementById('agreVentNombre').value === '') {
                                                                        alert('Ventanilla es requerido ');
                                                                        }
                                                                        var val = document.getElementById('agreVentNombre').value;
                                                                                if (val.length < 2) {
                                                                        alert('El número de Ventanilla debe ser de 2 dígitos: 00 ');
                                                                                document.getElementById('agreVentNombre').value = ''
                                                                        }
                                                                        var val = document.getElementById('agreVentNombre').value;
                                                                                if (val.length > 2) {
                                                                        alert('El número de Ventanilla debe ser de 2 dígitos: 00 ');
                                                                                document.getElementById('agreVentNombre').value = ''
                                                                        }

                                                                        }
                                                            </script>
                                                        </div><br>


                                                        <div class="input-group-prepend">
                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre</strong></label>
                                                        </div>
                                                        <div style="width: 90%">
                                                            <input placeholder="Teclea el nombre" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" onblur="valventnombre()" id="agreVentDesc" name="agreVentDesc" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                            <script>
                                                                        function valventnombre() {
                                                                        if (document.getElementById('agreVentDesc').value === '') {
                                                                        alert('Nombre es requerido');
                                                                                document.getElementById('btnAgreVent').hidden = true;
                                                                        } else {
                                                                        document.getElementById('btnAgreVent').hidden = false;
                                                                        }
                                                                        }
                                                            </script>
                                                        </div>  </div>
                                                    <div class="card">
                                                        <div class="card-body">

                                                            <h3 style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Servicios asignados a ventanilla</strong> </h3>
                                                            <div>

                                                                <%
                                                                    Consultas servicios = new Consultas();
                                                                    List<Servicio> lstSer = new ArrayList();
                                                                    lstSer = servicios.serviciosActivos();
                                                                    for (Servicio s : lstSer) {


                                                                %>




                                                                <div name="tratamiento" class="demo" style="float: left;" >
                                                                    <input onclick="tomarValorChk('<%=s.getDescripcionServicio()%>')"  style="border-color: black;margin-left: 80px;margin-right:80px;" type="checkbox"id="Chk<%=s.getDescripcionServicio()%>">
                                                                    <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;margin-left: 80px;margin-right:80px"  for="Chk<%=s.getDescripcionServicio()%>"><span></span><%=s.getDescripcionServicio()%></label>



                                                                </div>
                                                                <%
                                                                    }
                                                                %>

                                                                <input type="text"  id="servSelec" name="agreVentServ" hidden>
                                                                <input type="text" value="<%=usuario%>"  id="user" name="user" hidden>
                                                            </div>       
                                                            <script>
                                                                        function tomarValorChk(p1) {

                                                                        if (document.getElementById("Chk" + p1).checked) {
                                                                        document.getElementById("servSelec").value = document.getElementById("servSelec").value + p1 + " ";
                                                                        } else {
                                                                        var chkfalse = document.getElementById("servSelec").value;
                                                                                chkfalse = chkfalse.replace(p1 + " ", "");
                                                                                document.getElementById("servSelec").value = chkfalse;
                                                                        }

                                                                        }
                                                            </script>
                                                        </div> </div></div></div>
                                            <div class="modal-footer">
                                                <button hidden id="btnAgreVent" onclick="submit()" type="button" class="btn btn-primary"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong> CREAR VENTANILLA</strong></button>
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CERRAR</strong></button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- EDITAR VENTANILLA-->
                            <div class="modal fade bd-editar-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <form action="editarventana"  method="post" id="formEditarVentanilla" name="formEditarVentanilla"  >
                                        <input id="txtventedituser" name="txtventedituser" value="<%=usuario%>" hidden>
                                        <div class="modal-content">



                                            <div style="width: 100%;text-align: center;">
                                                <h1 style="font-size: 20px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>EDITAR VENTANILLA</strong></h1>

                                                <input id="txtIdEditV" name="txtIdEditV" hidden ></div>

                                            <div class="card">
                                                <div class="card-body">
                                                    <div style="float: left;width: 50%;">
                                                        <div class="input-group-prepend">
                                                            <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ventanilla</strong></label>
                                                        </div>
                                                        <div style="width: 90%">
                                                            <input readonly="" type="text" id="txtNombreEditV" name="txtNombreEditV" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                        </div><br>
                                                        <div class="input-group-prepend">
                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre</strong></label>
                                                        </div>
                                                        <div style="width: 90%">
                                                            <input placeholder="Teclea el nombre" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="txtDescEditV" name="txtDescEditV"  type="text"  class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                            <script>
                                                                        function venteditnomb() {
                                                                        if (document.getElementById("txtDescEditV").value === '') {
                                                                        alert("El Nombre es requerido");
                                                                                document.getElementById("btnGuardarEditVent").hidden = true;
                                                                        } else {
                                                                        document.getElementById("btnGuardarEditVent").hidden = false;
                                                                        }
                                                                        }
                                                            </script>
                                                        </div></div>
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <h3 style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Servicios asignados a ventanilla.</strong></h3><br>
                                                            <input type="text"  id="serSelec" name="editVentServ" hidden>
                                                            <div>
                                                                <%
                                                                    Consultas servici = new Consultas();
                                                                    List<Servicio> lstSe = new ArrayList();
                                                                    lstSe = servici.serviciosActivos(); //ServActVent

                                                                    for (Servicio se : lstSe) {

                                                                %>
                                                                <div  class="demo" style="float: left;">
                                                                    <input onclick="tomValorChk('<%=se.getDescripcionServicio()%>')"  style="border-color: #58585A;margin-left: 80px;margin-right:80px;" type="checkbox"  id="Check<%=se.getDescripcionServicio()%>">
                                                                    <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;margin-left: 80px;margin-right:80px"  for="Check<%=se.getDescripcionServicio()%>"><span></span><%=se.getDescripcionServicio()%></label>
                                                                </div>
                                                                <%
                                                                    }
                                                                %>
                                                            </div>
                                                            <script>
                                                                        function tomValorChk(p1) {

                                                                        if (document.getElementById("Check" + p1).checked) {
                                                                        document.getElementById("serSelec").value = document.getElementById("serSelec").value + p1 + " ";
                                                                        } else {
                                                                        var chkfalse = document.getElementById("serSelec").value;
                                                                                chkfalse = chkfalse.replace(p1 + " ", "");
                                                                                document.getElementById("serSelec").value = chkfalse;
                                                                        }





                                                                        }
                                                            </script>
                                                        </div> </div>  </div>
                                                <br>
                                                <div class="modal-footer" onclick="venteditnomb()">
                                                    <button hidden type="button" id="btnGuardarEditVent" onclick="submit()"  class="btn btn-primary"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong> GUARDAR CAMBIOS</strong></button>
                                                    <button type="button" onclick="deseleccionar_chk()"  class="btn btn-secondary" data-dismiss="modal"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong> CERRAR</strong></button>
                                                    <script>
                                                                function deseleccionar_chk() {

                                                                for (i = 0; i < document.formEditarVentanilla.elements.length; i++) {
                                                                if (document.formEditarVentanilla.elements[i].type === "checkbox") {
                                                                document.formEditarVentanilla.elements[i].checked = 0;
                                                                }
                                                                document.getElementById("serSelec").value = "";
                                                                }
                                                                }
                                                    </script>
                                                </div>
                                            </div></div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- USUARIOS -->               

                        <div class="tab-pane" name="alta" id="alta" role="tabpanel" aria-labelledby="profile-tab">

                            <div class="form-group" style="text-align:center;" >

                                <div style="overflow: scroll;max-height:300px" >
                                    <table class="table table-striped">
                                        <%
                                            Consultas usuarios = new Consultas();
                                            List<Usuario> lstUsuario = new ArrayList();
                                            lstUsuario = usuarios.allUsuarios();
                                        %>
                                        <thead>
                                            <tr> 
                                        <label style="margin-right: 40px;margin-bottom: 20px;margin-top: 10px;margin-left: 50px;float: left;color: #516179;font-weight: bold;font-size: 22px;font-family: 'Roboto', sans-serif;"><span>Filtros</span>
                                            <input id="myInput2" style="border-top: none;border-left: none;border-right: none;border-bottom-color: #90AFCE;width: 500px;color:#A0A0A0;font-size: 14px;font-family: 'Roboto', sans-serif;"   type="search" placeholder="Búsqueda por usuario, nombre, estatus">

                                            <img style="margin-left: 10px;width: 5%;" src="archivos\uploaded_files\lupa.PNG" title="Buscar"/>
                                        </label>
                                        </tr>
                                        <tr>
                                            <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Usuario</th>
                                            <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Nombre</th>
                                            <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Estatus</th>
                                            <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Acciones</th>
                                        </tr>
                                        </thead>
                                        <tbody id="myTable2">
                                            <%
                                                for (Usuario u : lstUsuario) {
                                            %>
                                            <tr>

                                                <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=u.getUsuario()%></td>
                                                <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=u.getNombre()%></td>
                                                <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=u.getEstatus()%></td>
                                                <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;width: 20%;">
                                                    <button type="button" onclick="editarUsu('<%=u.getId()%>', '<%=u.getNombre()%>', '<%=u.getPassword()%>', '<%=u.getVentanilla()%>', '<%=u.getEstatus()%>', '<%=u.getUsuario()%>', '<%=u.getEmail()%>');" data-toggle="modal" data-target=".bd-editaruser-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\editar.PNG" title="Editar"/></button>
                                                    <button type="button" onclick="eliminarUsu('<%=u.getId()%>')"   data-toggle="modal" data-target=".bd-eliminaruser-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\borrar.PNG" title="Eliminar"/></button>
                                                </td>

                                            </tr>
                                            <%}%>
                                        </tbody>
                                        <script>
                                                    function eliminarUsu(p1) {
                                                    document.getElementById("idUsElim").value = p1;
                                                    }


                                            function editarUsu(p1, p2, p3, p4, p5, p6, p7) {

                                            document.getElementById("txtEditarUId").value = p1;
                                                    document.getElementById("txtEditarUNombre").value = p2;
                                                    document.getElementById("txtEditarUPass").value = p3;
                                                    document.getElementById("txtEditarUEstatus").value = p5;
                                                    if (p5 === '1') {
                                            document.getElementById('CheckValE').checked = 1;
                                            } else {
                                            document.getElementById('CheckValE').checked = 0;
                                            }

                                            document.getElementById("txtEditarUUsu").value = p6;
                                                    document.getElementById("txtEditarUEmail").value = p7;
                                                    document.getElementById("txtVU").value = '';
                                                    if (p4 !== '') {
                                            document.getElementById("txtdivVU").hidden = false;
                                                    document.getElementById("btnDesVen").hidden = false;
                                                    document.getElementById("txtVU").value = p4;
                                                    document.getElementById("slcVentedit").hidden = true;
                                            } else {
                                            document.getElementById("btnDesVen").hidden = true;
                                                    document.getElementById("slcVentedit").hidden = false;
                                                    document.getElementById("txtdivVU").hidden = true;
                                            }

                                            }
                                        </script>

                                    </table>
                                </div>
                                <div>
                                    <button type="button"  data-toggle="modal" data-target=".bd-agregaruser-modal-lg"  style="width: 8%;height: 8%;margin-right: 50px;margin-top: 10px;border: none;background-color: white;float: right;"><img style="width: 50%;" src="archivos\uploaded_files\btnagregar.png" title="Agregar nueva ventanilla"/></button>

                                </div>
                            </div>
                            <!-- ELIMINAR USUARIOS -->
                            <div class="modal fade bd-eliminaruser-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <form action="eliminarusuario"  method="post" id="formEliminarUsuario" >
                                        <input type="text" autofocus="true"  name="idUsElim" data-name="idUsElim" id="idUsElim" hidden/>
                                        <div class="modal-content" >

                                            <div style="width: 100%;text-align: center;">
                                                <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>ELIMINAR USUARIO</strong></h1>
                                            </div>


                                            <div class="card">
                                                <div class="card-body" style="">
                                                    <div >
                                                        <h1 style="font-size: 18px;font-family: 'Roboto', sans-serif;color: gray;"> ¿Estás seguro de eliminar el usuario seleccionado?</h1>
                                                    </div>

                                                </div>   
                                            </div>

                                            <div class="modal-footer">
                                                <button id="btnElimUsu" onclick="submit()" type="button" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>CONFIRMAR ELIMINAR</strong></button>
                                                <button  type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CANCELAR</strong></button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                            </div>


                            <!-- AGREGAR USUARIOS -->
                            <div class="modal fade bd-agregaruser-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <form action="agregarusuario"  method="post" id="formAgregarUsuario"  >
                                        <div class="modal-content">

                                            <div style="width: 100%;text-align: center;">
                                                <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>AGREGAR NUEVO USUARIO</strong></h1>

                                            </div>



                                            <div class="card">
                                                <div class="card-body">
                                                    <div style="float: left;width: 50%;">

                                                        <div class="input-group-prepend">
                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong># Empleado</strong></label>
                                                        </div>
                                                        <div style="width: 90%">
                                                            <input onblur="valuseragre()" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el # Empleado" id="txtAgregarUUsuario" name="txtAgregarUUsuario" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                            <script>
                                                                        function valuseragre() {
                                                                        if (document.getElementById("txtAgregarUUsuario").value === '') {
                                                                        document.getElementById("txtConfirmarUPass").value = '';
                                                                                alert("EL USUARIO ES REQUERIDO");
                                                                                document.getElementById("btnAgreU").hidden = true;
                                                                        }
                                                                        }
                                                            </script>
                                                        </div><br>

                                                        <div class="input-group-prepend">
                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre de Empleado</strong></label>
                                                        </div>
                                                        <div style="width: 90%">
                                                            <input onblur="valunombagre()" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el nombre" id="txtAgregarUNombre" name="txtAgregarUNombre" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                            <script>
                                                                        function valunombagre() {
                                                                        if (document.getElementById("txtAgregarUNombre").value === '') {
                                                                        document.getElementById("txtConfirmarUPass").value = '';
                                                                                alert("EL NOMBRE ES REQUERIDO");
                                                                                document.getElementById("btnAgreU").hidden = true;
                                                                        }
                                                                        }
                                                            </script>
                                                        </div><br>

                                                        <div class="input-group-prepend">
                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Password</strong></label>
                                                        </div>
                                                        <div style="width: 90%">
                                                            <input onblur="valpassagre()" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el password" id="txtAgregarUPass" name="txtAgregarUPass" type="password" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                            <script>
                                                                        function valpassagre() {
                                                                        if (document.getElementById("txtAgregarUPass").value === '') {
                                                                        document.getElementById("txtConfirmarUPass").value = '';
                                                                                alert("EL PASSWORD ES REQUERIDO");
                                                                                document.getElementById("btnAgreU").hidden = true;
                                                                        }
                                                                        }
                                                            </script>
                                                        </div><br>

                                                    </div>
                                                    <div style="float: right;width: 50%;">
                                                        <div class="input-group-prepend">
                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Correo electrónico</strong></label>
                                                        </div>
                                                        <div style="width: 100%">
                                                            <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el email" id="txtAgregarUEmail" name="txtAgregarUEmail" type="email"  class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                        </div><br>

                                                        <div class="input-group-prepend">
                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ventanilla asignada</strong></label>
                                                        </div>
                                                        <div>

                                                            <select onchange="Mostrar desc ventanilla" id="txtAgregarUVent" name="txtAgregarUVent" class="custom-select">
                                                                <option value="" selected>Ninguna una ventanilla</option>
                                                                <%
                                                                    Consultas ventAsig = new Consultas();
                                                                    List<Ventanilla> lstventAsig = new ArrayList();
                                                                    lstventAsig = ventAsig.allVentanillasDisponibles();
                                                                    for (Ventanilla vnt : lstventAsig) {

                                                                %>

                                                                <option value="<%=vnt.getNombre()%>"><%=vnt.getNombre()%> - <%=vnt.getDesc()%></option>


                                                                <%
                                                                    }
                                                                %>
                                                            </select>
                                                        </div><br>
                                                        <div class="input-group-prepend">
                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Confirmar Password</strong></label>
                                                        </div>
                                                        <div style="width: 100%">
                                                            <input onblur="valconfpassuser()"  style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el password" id="txtConfirmarUPass" type="password"  class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                            <script>
                                                                        function valconfpassuser() {
                                                                        if (document.getElementById("txtAgregarUPass").value === document.getElementById("txtConfirmarUPass").value) {
                                                                        if (document.getElementById("txtAgregarUNombre").value === '') {
                                                                        alert("EL NOMBRE ES REQUERIDO");
                                                                                document.getElementById("txtConfirmarUPass").value = '';
                                                                                document.getElementById("btnAgreU").hidden = true;
                                                                        } else if (document.getElementById("txtAgregarUNombre").value === '') {
                                                                        alert("EL NOMBRE ES REQUERIDO");
                                                                                document.getElementById("txtConfirmarUPass").value = '';
                                                                                document.getElementById("btnAgreU").hidden = true;
                                                                        } else if (document.getElementById("txtAgregarUPass").value === '') {
                                                                        alert("EL PASSWORD ES REQUERIDO");
                                                                                document.getElementById("txtConfirmarUPass").value = '';
                                                                                document.getElementById("btnAgreU").hidden = true;
                                                                        } else {
                                                                        document.getElementById("btnAgreU").hidden = false;
                                                                        }


                                                                        } else {
                                                                        alert("LOS PASSWORD NO COINCIDEN");
                                                                                document.getElementById("txtAgregarUPass").value = '';
                                                                                document.getElementById("txtConfirmarUPass").value = '';
                                                                        }

                                                                        }
                                                            </script>

                                                        </div>

                                                        <div>
                                                            <select hidden  id="txtAgregarUEstatus" name="txtAgregarUEstatus" >

                                                                <option selected value="1">Activo</option>
                                                                <option value="0">Inactivo</option>
                                                            </select>
                                                        </div><br>

                                                        <div class="input-group-prepend">
                                                            <div  class="demo" style="float: left;">
                                                                <input checked onclick="valChk();"  style="border-color: #58585A;" type="checkbox" id="CheckVal" >
                                                                <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;"  for="CheckVal"><span></span><strong>Activo</strong></label>
                                                            </div>
                                                            <script>
                                                                        function valChk() {
                                                                        if (document.getElementById('CheckVal').checked) {
                                                                        document.getElementById('txtAgregarUEstatus').value = "1";
                                                                        } else {
                                                                        document.getElementById("txtAgregarUEstatus").value = "0";
                                                                        }

                                                                        }
                                                            </script>
                                                        </div>
                                                    </div>


                                                </div>


                                                <br>

                                            </div><div class="modal-footer">
                                                <input type="text" value="<%=usuario%>"  id="user" name="useragr" hidden>
                                                <button hidden id="btnAgreU"  onclick="submit()" type="button" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>CREAR USUARIO</strong></button>
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CERRAR</strong></button>
                                            </div></div></div></form>
                            </div></div>
                    </div>
                    <!-- EDITAR USUARIOS -->
                    <div class="modal fade bd-editaruser-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <form action="editarusuario" method="post" id="formEditarUsuario" name="formEditarUsuario" >
                                    <input id="txtusredit" name="txtusredit" value="<%=usuario%>" hidden>
                                    <input id="txtEditarUId" name="txtEditarUId" hidden>
                                    <div class="modal-content">

                                        <div style="width: 100%;text-align: center;">
                                            <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>EDITAR USUARIO</strong></h1>
                                        </div>



                                        <div class="card">
                                            <div class="card-body">
                                                <div style="float: left;width: 50%;">

                                                    <div class="input-group-prepend">
                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong># Empleado</strong></label>
                                                    </div>
                                                    <div style="width: 90%">
                                                        <input  placeholder="Teclea el # Empleado" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="txtEditarUUsu" name="txtEditarUUsu" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">

                                                    </div><br>

                                                    <div class="input-group-prepend">
                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre de Empleado</strong></label>
                                                    </div>
                                                    <div style="width: 90%">
                                                        <input placeholder="Teclea el nombre" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="txtEditarUNombre" name="txtEditarUNombre"  type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                    </div><br>

                                                    <div class="input-group-prepend">
                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Password</strong></label>
                                                    </div>
                                                    <div style="width: 90%">
                                                        <input placeholder="Teclea el password" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="txtEditarUPass" name="txtEditarUPass" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                    </div><br>

                                                    <div class="input-group-prepend">
                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Confirmar Password</strong></label>
                                                    </div>
                                                    <div style="width: 90%">
                                                        <input onblur="valconfpassuseredit()" placeholder="Teclea el password" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el password" id="txtConfirmarUPassE" type="password"  class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">

                                                        <script>
                                                                    function valconfpassuseredit() {
                                                                    if (document.getElementById("txtEditarUNombre").value !== '') {


                                                                    if (document.getElementById("txtEditarUPass").value === document.getElementById("txtConfirmarUPassE").value) {
                                                                    document.getElementById("btnEditUsr").hidden = false;
                                                                    } else {
                                                                    alert("LOS PASSWORD NO COINCIDEN");
                                                                            document.getElementById("txtEditarUPass").value = '';
                                                                            document.getElementById("txtConfirmarUPassE").value = '';
                                                                            document.getElementById("btnEditUsr").hidden = true;
                                                                    }
                                                                    if (document.getElementById("txtEditarUUsu").value === '') {
                                                                    alert("EL USUARIO ES REQUERIDO");
                                                                            document.getElementById("txtConfirmarUPassE").value = '';
                                                                            document.getElementById("btnEditUsr").hidden = true;
                                                                    }
                                                                    if (document.getElementById("txtEditarUNombre").value === '') {
                                                                    alert("EL NOMBRE ES REQUERIDO");
                                                                            document.getElementById("txtConfirmarUPassE").value = '';
                                                                            document.getElementById("btnEditUsr").hidden = true;
                                                                    }

                                                                    }

                                                                    }
                                                        </script>
                                                    </div>

                                                </div>
                                                <div style="float: right;width: 50%;">
                                                    <div class="input-group-prepend">
                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Correo electrónico</strong></label>
                                                    </div>
                                                    <div style="width: 100%">
                                                        <input placeholder="Teclea el correo electrónico" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="txtEditarUEmail" name="txtEditarUEmail" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                        <br></div>




                                                </div> 
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div id="txtdivVU" class="input-group input-group-lg" style="float: left;">
                                                            <div class="input-group-prepend">
                                                                <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ventanilla asignada</strong></label>
                                                            </div> <div style="width: 100%">
                                                                <input readonly id="txtVU" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                            </div></div>
                                                        <div style="width: 100%">

                                                            <button id="btnDesVen" type="button" onclick="cambVent()" data-toggle="modal" data-target=".bd-editarVuser-modal-lg" class="btn btn-primary" style="background-color: #006EB2; font-family: 'Roboto', sans-serif;color: white;font-size: 12px;margin: 10px;" >CAMBIAR VENTANILLA ASIGNADA</button>
                                                        </div>
                                                        <script>
                                                                    function cambVent() {
                                                                    document.getElementById("nomVent").value = document.getElementById("txtVU").value;
                                                                            document.getElementById("txtEditarUIdDet").value = document.getElementById("txtEditarUId").value;
                                                                    }
                                                        </script>  
                                                        <br>
                                                        <div id="slcVentedit">
                                                            <div style="width: 100%">
                                                                <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ventanilla asignada</strong></label>
                                                                <select  id="txtEditarUVent" name="txtEditarUVent" class="custom-select">
                                                                    <option value="" selected>Ninguna ventanilla asignada</option>
                                                                    <%
                                                                        Consultas ventAsige = new Consultas();
                                                                        List<Ventanilla> lstventAsige = new ArrayList();
                                                                        lstventAsige = ventAsige.allVentanillasDisponibles();
                                                                        for (Ventanilla vnte : lstventAsige) {

                                                                    %>

                                                                    <option value="<%=vnte.getNombre()%>"><%=vnte.getNombre()%></option>


                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div></div><br>


                                                <div>
                                                    <select hidden id="txtEditarUEstatus" name="txtEditarUEstatus" class="custom-select">

                                                        <option selected value="1">Activo</option>
                                                        <option value="0">Inactivo</option>
                                                    </select>
                                                </div><br>

                                                <div class="input-group-prepend">
                                                    <div  class="demo" custom-checkbox" style="float: left;">
                                                          <input onclick="valChkd();"  style="border-color: #58585A;" type="checkbox"  id="CheckValE" >
                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;" for="CheckValE"><span></span><strong>Activo</strong></label>
                                                    </div>
                                                    <script>
                                                                function valChkd() {
                                                                if (document.getElementById('CheckValE').checked) {
                                                                document.getElementById('txtEditarUEstatus').value = "1";
                                                                } else {
                                                                document.getElementById("txtEditarUEstatus").value = "0";
                                                                }

                                                                }
                                                    </script>
                                                </div>
                                            </div>
                                        </div>

                                        <br>

                                    </div><div class="modal-footer">
                                        <input type="text" value="<%=usuario%>"  id="user" name="useragr" hidden>
                                        <button hidden id="btnEditUsr"  onclick="submit()" type="button" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>GUARDAR CAMBIOS</strong></button>
                                        <button type="button"  class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CERRAR</strong></button>
                                    </div>
                                </form>
                            </div>
                        </div></div>
                    <!-- CAMBIAR VENTANILLA-->
                    <div class="modal fade bd-editarVuser-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="width: 400px;float: start;margin-left: 400px;">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <form action="editarusuarioventdet" method="post" id="formEditarUsuarioVentDet" name="formEditarUsuarioVentDet" >

                                    <div style="width: 100%;text-align: center;">
                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>CAMBIAR VENTANILLA</strong></h1>
                                    </div>


                                    <input id="nomVent" name="nomVent" hidden>
                                    <input id="txtEditarUIdDet" name="txtEditarUIdDet" hidden>
                                    <div class="card">
                                        <div class="card-body">
                                            <br>
                                            <div id="slcDetVentedit">
                                                <div class="input-group-prepend" style="width: 90%;">
                                                    <div class="input-group-prepend" style="width: 50%;float: left;">
                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ventanilla asignada</strong></label>
                                                    </div>
                                                    <div class="input-group-prepend" style="width: 50%;float: left;">
                                                        <select style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="txtEditarUVentDetalle" name="txtEditarUVentDetalle" >
                                                            <option value="" selected>Ninguna ventanilla asignada</option>
                                                            <%
                                                                Consultas ventAsigeDet = new Consultas();
                                                                List<Ventanilla> lstventAsigeDet = new ArrayList();
                                                                lstventAsigeDet = ventAsigeDet.allVentanillasDisponibles();
                                                                for (Ventanilla vnte : lstventAsigeDet) {

                                                            %>

                                                            <option value="<%=vnte.getNombre()%>"><%=vnte.getNombre()%></option>


                                                            <%
                                                                }
                                                            %>
                                                        </select> </div></div>
                                            </div> </div>

                                    </div>
                                    <br>
                                    <div class="modal-footer">
                                        <button type="button" id="btnEditUsr" onclick="submit()"  class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>GUARDAR CAMBIOS</strong></button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CERRAR</strong></button>

                                    </div>
                                </form>
                            </div>
                        </div></div>
                    <!-- -->


                </div>

                </div>

                </div>
            </td>
        </tr>
    </tbody>
</table>




</body>
</html>
