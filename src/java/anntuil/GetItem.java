/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anntuil;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Wicho Segura
 */
@WebServlet(name = "GetItem", urlPatterns = {"/GetItem"})
public class GetItem extends HttpServlet {

   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        
        try
        {
          String strItemCode = request.getParameter("txtCodigoProducto");
          
          ServletContext context = getServletContext();
          Connection orclConn = OracleConnect.getConnection(context);
          
          String command = "{call P_GET_PRODUCTO(?,?)}";
          CallableStatement csmt = orclConn.prepareCall(command);
          csmt.setString(1, strItemCode);
          csmt.registerOutParameter(2, OracleTypes.CURSOR);
          csmt.execute();
          
          ResultSet rset = ((OracleCallableStatement) csmt).getCursor(2);
          int intId = 0;
          String strDescripcion = "";
          double dblPrecio = 0.0;
          int intResultRows = rset.getFetchSize();
          
          response.setContentType("text/xml;charset=UTF-8");
          
          try(PrintWriter out = response.getWriter())
          {
              out.println("<?xml version=\"1.0\" ?>");
              out.println("<productos>");
              
              while(rset.next())
              {
                  intId = rset.getInt(1);
                  strDescripcion = rset.getString(2);
                  dblPrecio = rset.getDouble(3);
                  
                  out.println("producto");
                  out.println("<id>"+String.valueOf(intId)+"</id>");
                  out.println("<descripcion>"+strDescripcion+"</descripcion>");
                  out.println("<precio>"+String.valueOf(dblPrecio)+"</precio>");
                  out.println("/producto");
              }
          
              
              rset.close();
              out.println("</productos>");
          }
        }catch(Exception e){}
        

        } 
   
  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException{
                        processRequest(request, response);
   }
   }

