/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anntuil;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Array;
import java.sql.CallableStatement;
import java.sql.Connection;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

/**
 *
 * @author Wicho Segura
 */
@WebServlet(name = "SaveVenta", urlPatterns = {"/SaveVenta"})
public class SaveVenta extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
          try{
              int nVendedor =  Integer.parseInt(request.getParameter("nVendedor"));
              int nCaja = 1;
              int nCliente = 1;
              String sCajero = request.getParameter("nCajero");
              String[] sProductos = request.getParameterValues("id_producto");
              String[] sPrecios = request.getParameterValues("precios");
              ServletContext context = getServletContext();
              Connection orclConn = OracleConnect.getConnection(context);
              String command = "{CALL P_SAVE_VENTA(?,?,?,?,?,?,?)}";
              CallableStatement cstmt = orclConn.prepareCall(command);
              cstmt.setString(1,sCajero);
              cstmt.setInt(2,nCaja);
              cstmt.setInt(3,nVendedor);
              cstmt.setInt(4,nCliente);
              ArrayDescriptor arrDesc = ArrayDescriptor.createDescriptor("T_VARCHAR2_ARRAY", orclConn);
              Array aProductos = new ARRAY(arrDesc, orclConn, sProductos);
              Array aPrecios = new ARRAY(arrDesc, orclConn, sPrecios);
              cstmt.setArray(5,aProductos);
              cstmt.setArray(6,aPrecios);
              cstmt.registerOutParameter(7,OracleTypes.INTEGER);
              cstmt.execute();
          }catch(Exception e){
              e.printStackTrace();
          }
        }
    }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
