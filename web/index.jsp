
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="anntuil.OracleConnect"%>
<%@page import="javax.servlet.ServletContext"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.*"%>
<%
   
    ServletContext context = getServletContext();
    Connection orclConn = OracleConnect.getConnection(context);
    String command ="{CALL P_GETMENUS(?,?)}";
    CallableStatement cstmt = orclConn.prepareCall(command);
    HttpSession s = request.getSession();
    String usuario  = s.getAttribute("usuario").toString();
    cstmt.setString(1, usuario);
    cstmt.registerOutParameter(2,OracleTypes.CURSOR);
    cstmt.execute();
    ResultSet res = cstmt.getResultSet();
 %>

<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/zapateria.css">
    </head>
    <body>
        <div class="sidebar">
            <% 
                while(res.next()){
                    String nombre = res.getString("NOMBREMENU");
                    System.out.println("<a class='active' href='"+nombre+"'>"+nombre +"</a>");
                }
            %>
            <a class="active" href="#ventas">Ventas</a>
            <a href="#caja">Caja</a>
            <a href="#almacen">Almac&eacute;n</a>
            <a href="#supervisor">Supervisor</a>
            <a href="#atnctes">At'n a Clientes</a>
        </div>

        <div class="topnav">
            <div class="dropdown">
                <button class="dropbtn"><%= s.getAttribute("usuario")%><i class="fa fa-caret-down"></i></button>
                <div class="dropdown-content">
                    <a href="#">Link 1</a>
                    <a href="#">Link 2</a>
                    <a href="#">Link 3</a>
                </div>
            </div>
        </div>
        <!-- Page content -->
        <div class="content">
            <form action="Ejemplo" method="post">
		<table style="with: 50%">
                    <tr>
			<td>First Name</td>
			<td><input type="text" name="first_name" /></td>
                    </tr>
                    <tr>
			<td>Last Name</td>
			<td><input type="text" name="last_name" /></td>
                    </tr>
                    <tr>
			<td>UserName</td>
			<td><input type="text" name="username" /></td>
                    </tr>
                    <tr>
			<td>Password</td>
			<td><input type="password" name="password" /></td>
                    </tr>
                    <tr>
			<td>Address</td>
			<td><input type="text" name="address" /></td>
                    </tr>
                    <tr>
			<td>Contact No</td>
			<td><input type="text" name="contact" /></td>
                    </tr>
                   
                </table>
		<input type="submit" value="Registrar" />
            </form>
        </div>
    </body>
</html>