var aVenta=[];
var nTotVta =[];
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function addItem()
{
    var frmVenta = document.getElementById("frmVenta");
    var txtCodigoProducto = frmVenta.txtCodigoProducto.value;
    
    //Objeto XMLHTTP invocaciones web.
    var xhttp;
    
    if(window.XMLHttpRequest)
        
    {
        // code for moder browsers
        xhttp = new XMLHttpRequest();
    }else
    {
        //code for II5 E II6
        xhttp = new ActiveXObjeyc("Microsoft.XMLHTTP");
    }
    
    
    //Por cada cambio de estatus en la invocación
    xhttp.onreadystatechange = function()
    {
        //Estado de carga correcta
        if (this.readyState == 4 && this.status == 200)
        {
           var newOpt = document.createElement("OPTION");
           
           parser = new DOMParser();
           xmlDoc = parser.parseFromString(this.responseText, "text/xml");
           newOpt.value = xmlDoc.getElementsByTagName("id")[0].childNodes[0].nodeValue;
           var prodDesc = 
                    xmlDoc.getElementsByTagName("descripcion")[0].childNodes[0].nodeValue;
           newOpt.text = prodDesc.substring(0,30) +
                xmlDoc.getElementsByTagName("descripcion")[0].childNodes[0].nodeValue;
           frmVenta.productos.add(newOpt);
           
           aVenta[aVenta.length] = [newOpt.value,prodDesc,xmlDoc.getElementsByTagName("precio")[0].childNodes[0].nodeValue];
           nTotVta += 1*xmlDoc.getElementsByTagName("precio")[0].childNodes[0].nodeValue;
           
        }
    };
    
    
    xhttp.open("GET", "http://localhost:8080/Zapateria/GetItem?txtCodigoProducto="+txtCodigoProducto, true);
    xhttp.send();
    
}

function saveVenta(){
    var frmVenta = document.getElementById("frmVenta");
    var parameters = "nVendedor="+frmVenta.txtVendedorName.value+"&nCajero="+frmVenta.txtCajero.value;
    for(var i=0;i<aVenta.length;i++){
        parameters = parameters + "&id_producto="+aVenta[i][0]+"&precios="+aVenta[i][2];
    }
    //Objeto XMLHTTP invocaciones web.
    var xhttp;
    
    if(window.XMLHttpRequest)
        
    {
        // code for moder browsers
        xhttp = new XMLHttpRequest();
    }else
    {
        //code for II5 E II6
        xhttp = new ActiveXObjeyc("Microsoft.XMLHTTP");
    }

        xhttp.onreadystatechange = function(){
            //frmVenta.rest();
            aVenta = new Array();
            nTotVta = 0;
            alert("Venta realizada");
            for(var i=0; i<frmVenta.productos.length;i++){
                frmVenta.productos.remove(0);
            }
        };

        xhttp.open("POST","http://localhost:8080/Zapateria/SaveVenta?"+parameters,true);
        xhttp.send();
}

