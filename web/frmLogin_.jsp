<%-- 
    Document   : frmLogin_.jsp
    Created on : 4/10/2019, 02:06:04 PM
    Author     : luiss
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="anntuil.OracleConnect"%>
<%@page import="javax.servlet.ServletContext"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.*"%>

<%
    String strUsuario = request.getParameter("usuario");
    String strPassword = request.getParameter("contrasena");
    ServletContext context = getServletContext();
    Connection orclConn = OracleConnect.getConnection(context);
    String command ="{CALL P_VALIDATEUSER(?,?,?)} ";
    CallableStatement cstmt = orclConn.prepareCall(command);
    cstmt.setString(1, strUsuario);
    cstmt.setString(2, strPassword);
    Integer isValidate =1;
    //Se inserta un cursor para resivir una respuesta el sp, que viene siendo de la salida
    cstmt.registerOutParameter(3,java.sql.Types.INTEGER);
    cstmt.execute();
    int intResult =  cstmt.getInt(3);
    HttpSession s = request.getSession();
    s.setAttribute("value",String.valueOf(intResult));
    s.setAttribute("usuario", strUsuario);
    if(s.getAttribute("value") != null){
        if(s.getAttribute("value") =="0"){
            response.sendRedirect("login.jsp");
        }
        
        if(s.getAttribute("value").equals("1")){
            response.sendRedirect("index.jsp");
        }
    }
    
    %>
