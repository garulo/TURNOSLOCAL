
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrador de Turnos SADM</title>
        <link href="archivos/uploaded_files/Icono_SADM.png" rel="shortcut icon" type="image/x-icon" />
        <link href="archivos/uploaded_files/logo_sadm_color.png" rel="apple-touch-icon" />
    
        </script>
       <link href="archivos/css/roboto.css" rel="stylesheet">
    </head>
    <body style="height: 100%;width: 100%;text-align: left;background:url('/Turnos_SADM/archivos/uploaded_files/fondo_agua_sadm_1_1.jpg');background-size:cover;" >
        <div style="margin: auto;display: table;height: 100%;alignment-adjust: central;background-color: white;margin-top: 10%;">           
            <div style="display: table-cell;vertical-align: middle;alignment-adjust: central;" >

                <div class="table-responsive">
                    <form action="login"   method="post" id="formlogin" >
                        <table class="table">
                            <thead>
                                <tr >
                            <div style="margin-left:80px;margin-top: 50px;">
                                <div>
                                    <h2 style="font-size: 22px;color: #58585A;font-family: 'Roboto', sans-serif;">ADMINISTRADOR DE TURNOS</h2>
                                </div>
                            </div>
                            </tr>
                            </thead>
                            <tbody >
                                <tr>
                                    <td style="color: #58585A;margin: 10px;alignment-adjust: auto;width: 400px;text-align: center;">
                                        <img src="archivos/uploaded_files/logo_sadm_2.png"  width='70%' height='100%' style="display: block;margin: 0 auto;max-width: 100%;"  >
                                    </td>
                                    <td style="color: #58585A;margin: 10px;alignment-adjust: auto;width: 400px;text-align: left;">
                                        <div><label for="Usuario" style="color: #58585A;font-family: 'Roboto', sans-serif;font-size: 16px;" ><strong>Usuario</strong></label></div>
                                        <div><input type="text" style="width: 300px;height: 30px;font-size: 14px;" autofocus="true" maxlength="256" name="Usuario" data-name="Usuario" placeholder="Teclea tu usuario" id="txtUsuario"/></div>
                                        <br>
                                        <div><label for="password" style="color: #58585A;font-family: 'Roboto', sans-serif;font-size: 16px;"><strong>Password</strong></label></div>
                                        <div><input type="password" style="width: 300px;height: 30px;font-size: 14px;"  maxlength="20" name="password" data-name="Password" placeholder="Teclea tu contraseña" id="txtPassword"/></div>
                                        <br><br><input id="btniniciar" style="font-family: 'Roboto', sans-serif;width: 300px;height: 40px;color: white;background-color:#0A4BA2;border-radius: 10px;"  type="submit" value="ENTRAR" data-wait="Espere ..."  />
                                        <br> </td>
                                </tr>

                            </tbody>
                        </table>
                        <br><br>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
