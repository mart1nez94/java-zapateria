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
           newOpt.text = xmlDoc.getElementsByTagName("descripcion")[0].childNodes[0].nodeValue;
           frmVenta.productos.add(newOpt);
           
        }
    };
    
    
    xhttp.open("GET", "http://localhost:8080/Zapateria/GetItem?txtCodigoProducto="+txtCodigoProducto, true);
    xhttp.send();
    
}


