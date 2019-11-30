<%@include file="header.jsp"%>
<script src="js/ann-tuil-ventas.js"></script>
<form class="formUserInterface" name="frmVenta" id="frmVenta">
    
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
                    <option value="1"> Juan Perez </option>
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
                <button>Borrar</button>
                <button>Pegar</button>
                <button>Cancelar</button>
            </div>
        </div>
  </div>
        
    
    
    
    
    
   
<%@include file="footer.jsp"%>