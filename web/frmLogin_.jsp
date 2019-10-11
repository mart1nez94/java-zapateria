<%-- 
    Document   : frmLogin_.jsp
    Created on : 4/10/2019, 02:06:04 PM
    Author     : luiss
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="anntuil.OracleConnect"%>
<%@page import="javax.servlet.ServletContext"%>
<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.*"%>

<%
    String strUsuario = request.getParameter("usuario");
    String strPassword = request.getParameter("contrasena");
    ServletContext context = getServletContext();
    Connection orclConn = OracleConnect.getConnection(context);
    String command ="{CALL P_GETMENUS(?,?,?)} ";
    CallableStatement cstmt = orclConn.prepareCall(command);
    cstmt.setString(1, strUsuario);
    cstmt.setString(2, strPassword);
    //Se inserta un cursor para resivir una respuesta el sp, que viene siendo de la salida
    cstmt.registerOutParameter(3, OracleTypes.CURSOR);
    cstmt.execute();
    ResultSet rest =((OracleCallableStatement) cstmt).getCursor(3);
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <ul>
        <% 
            while(rest.next()){
                int intOrden = rest.getInt(1);
                String strMenu = rest.getString(2);
        %>
        <li><%= intOrden %></li>
        <li><%= strMenu %></li>
        </ul>
        <%}%>
    </body>
</html>
