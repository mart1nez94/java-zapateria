<%@include file="header.jsp"%>
<%@page import="anntuil.OracleConnect"%>
<%@page import="javax.servlet.ServletContext"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.*"%>
<script src="js/ann-tuil-ventas.js"></script>
<form class="formUserInterface" name="frmVenta" id="frmVenta">
    <input type="hidden" name="txtCajero" value="<%=strUsuario%>"
    <div class="divTblForm">
        
     <div class="divRow">
            
         <div class="divTitleCell">
                
                <h3> Ventas </h3>
         </div>
            
    </div>

    <div class="divRow">
 
        <div class="divDataCell" style="width:100px"> Vendedor:</div> 
            <div class="divDataCell">
                <select name="txtVendedorName" style="width:300px">
                    <option value="0"> --Seleccione un vendedor-- </option>
                    <% 
                      ServletContext context2  = getServletContext();
                      Connection orclCoon2 = OracleConnect.getConnection(context2);
                      HttpSession s2 = request.getSession();
                      String command2 = "{CALL P_GET_VENDEDORES(?)}";
                      CallableStatement cstmt2 = orclCoon2.prepareCall(command2);
                      cstmt2.registerOutParameter(1,OracleTypes.CURSOR);
                      cstmt2.execute();
                      ResultSet rset2 =((OracleCallableStatement) cstmt2).getCursor(1);
                      
                      while(rset2.next()){
                          int intId = Integer.parseInt(rset2.getString(1));
                          String strVendedor = rset2.getString(2);
             %>
                        <option value="<%=intId%>"><%= strVendedor%></option>
             <%

                      }
             %>
                      
                    
                 
                </select>
            </div> 
      </div>
      
        <div class="divRow">
            <div class="divDataCell">Art&iacute;culos</div>
        </div>
        <div class="divRow">
            <div class="divDataCell">
                <select multiple="true" size="15" length="80" style="width: 400px" name="productos">
                </select>
            </div>
        </div>
        <div class="divRow">
            <div class="divDataCell" style="width: 100px">&nbsp;</div>
            <div class="divDataCell" style="text-align:right; width: 300px;">Total:
                <input type="text" name="txtTotal" style="width: 100px;">
            </div>
        </div>
        
        <div class="divRow">
            <div class="divDataCell" style="width: 100px;">Art&iacute;culo</div>
            <div class="divDataCell">
                <input type="text" name="txtCodigoProducto" style="width: 300px">
            </div>
        </div>
        
        <div class="divRow">
            <div class="divDataCell">
                <button onClick="addItem(); return false;">Agregar</button>
                <button onClick="removeItem()">Borrar</button>
                <button onClick="saveVenta()">Pegar</button>
                <button>Cancelar</button>
            </div>
        </div>
  </div>
</from>
            
    
    
    
    
    
   
<%@include file="footer.jsp"%>