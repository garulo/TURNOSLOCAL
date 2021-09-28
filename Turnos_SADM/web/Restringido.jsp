<%-- 
    Document   : Error500
    Created on : Jan 8, 2020, 1:11:28 PM
    Author     : marco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Área de Acceso Restringido</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i&display=swap" rel="stylesheet">
    </head>
    <body>
        <table  border="0" style="text-align: center;alignment-adjust: central;">
             
            <tbody style="text-align: center;">
                <tr style="text-align: center;">
                    <td colspan="3"><h1 style="font-family: 'Roboto', sans-serif;"><strong>Área con Acceso Restringido </strong></h1></td>
                            </tr>
                             <tr >
                                <td colspan="3"><img style="width: 400px;" src="archivos/uploaded_files/Area_Restringida.png"></td>
                            </tr>
                            <tr >
                                <td colspan="3"><h3 style="font-family: 'Roboto', sans-serif;"><strong>Área controlada por SADM</strong></h3></td>
                            </tr>
                             <tr >
                                <td colspan="3"><h3 style="font-family: 'Roboto', sans-serif;"><strong>Inicie sesión con credenciales válidas para poder continuar.</strong></h3></td>
                            </tr>
                             <tr>
                                <td ><td colspan="1"><input type="button" class="btn btn-warning" value="Continuar" onclick="location = '/Turnos_SADM/Login.jsp'"></td></td>
                            </tr> 
    </tbody></table>
        
    </body>
</html>
