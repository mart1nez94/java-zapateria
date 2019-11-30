<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="anntuil.OracleConnect"%>
<%@page import="javax.servlet.ServletContext"%>
<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.*"%>

<% 
    ServletContext context = getServletContext();
    Connection orclConn = OracleConnect.getConnection(context);
    
    HttpSession s = request.getSession();
    
    String command = "{call P_GETMENUS(?,?)}";
    CallableStatement cstmt = orclConn.prepareCall(command);
    
    String strUsuario = s.getAttribute("usuario").toString();
    
    cstmt.setString(1, strUsuario);
    
    cstmt.registerOutParameter(2, OracleTypes.CURSOR);
    
    cstmt.execute();
    
    ResultSet rset = ((OracleCallableStatement) cstmt).getCursor(2);
%>

<!DOCTYPE html>
<html>
    <head>
            <title>Ann Tuil</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/ann-tuil.css">
        <link rel="stylesheet" href="css/menu.css">
    </head>
    <body>
        <div class="navigation">
            <ul>
            <%
                int intCurrLevel = 0;
                int intLevel = 0;
                
                while (rset.next())
                {
                    String strMenu = rset.getString(3);
                    String strLiga = rset.getString(4);
                    intLevel = Integer.parseInt(rset.getString(5));
                    
                    if (intCurrLevel == 0)
                    {
                        intCurrLevel = intLevel;
                    }
                    else if (intCurrLevel == intLevel)
                    {
                        out.println("</li>");
                    }
                    else if (intCurrLevel < intLevel)
                    {
                        out.println("<ul>");
                        intCurrLevel = intLevel;
                    }
                    else if (intCurrLevel > intLevel)
                    {
                        for(int i = 0; i < (intCurrLevel - intLevel); i++)
                        {
                            out.println("</li></ul>");
                        } 
                        out.println("</li>");
                        
                        intCurrLevel = intLevel;
                    }
            %>
                <li class="has-sub">
                    <a href="<%=strLiga%>"><%=strMenu%></a>
                
            <%
                }
                if (intCurrLevel == 1)
                {
                    out.println("</li>");
                }
                else if (intCurrLevel > 1)
                {
                    for(int i = 0; i < (intLevel - 1); i++)
                        {
                            out.println("</ul></li>");
                        }
                }
            %>
            </ul>
            <!--<a class="active" href="#ventas">Ventas</a>
            <a href="#caja">Caja</a>
            <a href="#almacen">Almac&eacute;n</a>
            <a href="#supervisor">Supervisor</a>
            <a href="#atnctes">At'n a Clientes</a> -->
        </div>

        <div class="topnav">
            <div class="dropdown">
                <button class="dropbtn"><%=strUsuario%><i class="fa fa-caret-down"></i></button>
                <div class="dropdown-content">
                    <a href="#">Link 1</a>
                    <a href="#">Link 2</a>
                    <a href="#">Link 3</a>
                </div>
            </div>
        </div>
        <!-- Page content -->
        <div class="content">