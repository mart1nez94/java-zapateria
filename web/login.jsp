<%-- 
    Document   : login
    Created on : 3/10/2019, 02:20:29 PM
    Author     : luiss
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/ann-tuil.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body class="bodyLogin">
        <div class="divTbl">
            <div class="divCell">
                <form name="frmLogin" action="frmLogin_.jsp" method="POST">
                    <table border="0" class="tblLogin">
                        <tr>
                            <td>Usuario: </td>
                            <td><input type="text" name="usuario" value="" size="15px" class="tbLogin"/></td>
                        <tr>
                            <td>Contraseña:</td>
                            <td><input type="password" name="contrasena" value="" size="15px" class="tbLogin"/></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center;">
                                <input type="submit" value="Iniciar" name="btnIniSesion" class="btLogin"/>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </body>
</html>
