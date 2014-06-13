// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){


	$('#clavelibro').on("change",function() {
		//pasar a cantidad
		$("#cantidadlibro").focus();
	});

  $('#cantidadlibro').on("keypress",function(event) {
    //buscar el libro por codigo y agregarlo
    if ( event.which == 13)
    {
      agregaLibro($('#clavelibro').val());
    }
  });

  $("#guardarVenta").on("click", function(){
    //enviar formulario
    $("#new_sale").submit();
  });
});

function agregaLibro(codigo){
  var index = $(".idLibroVender").length;

  alert(index);

  if(codigo == "" || codigo == NaN)
  {
    alert("ingrese el código del libro.");
    $("#cantidadlibro").val(1);
    $('#clavelibro').focus();
    return;
  }

  $.ajax({
    dataType: "json",
    url: "http://0.0.0.0:3000/products/find.json?codigo=" + codigo})
  .done(function(data) {
      if(data.id == null){
        alert("No se encontró el libro.");
        resetAgregaLibro();
        return;
      }

        //armar el nuevo producto a agregar
        //alert("Datos del libro:" + data.id + " Codigo: " + data.codigo);
        var nuevoLibro = "<tr><td><input class=\"idLibroVender\" id=\"sale_saleDetails_attributes_0_product_id\" name=\"sale[saleDetails_attributes]["+index+"][product_id]\" type=\"text\" value=\"" + data.id + "\"></td> <td><input type=\"text\" id=\"nombreProducto\" value=\"" + data.nombre+"\"></td> <td><input id=\"sale_saleDetails_attributes_0_preciounitario\" name=\"sale[saleDetails_attributes]["+index+"][preciounitario]\" type=\"text\" value=\"" + data.precio + "\"></td> <td><input class=\"cantidadVender\" id=\"sale_saleDetails_attributes_0_cantidad\" name=\"sale[saleDetails_attributes]["+index+"][cantidad]\" type=\"text\" value=\"" + $("#cantidadlibro").val() + "\"></td> <td><input class=\"importeProducto\" id=\"sale_saleDetails_attributes_0_importe\" name=\"sale[saleDetails_attributes]["+index+"][importe]\" type=\"text\" value=\"" + (data.precio * $("#cantidadlibro").val()) + "\"></td></tr>";

        $("#detallesVentaTable tbody").append(nuevoLibro);
        resetAgregaLibro();
        calculaTotales();
      }).fail(function(){
        resetAgregaLibro();
    });
  }

  function resetAgregaLibro(){
    $("#cantidadlibro").val(1);
    $('#clavelibro').val("");
    $('#clavelibro').focus();
  }

  function calculaTotales(){
    var productos = 0;
    var importeTotal = 0;
    $(".cantidadVender").each(function(index){
      productos += parseInt($(this).val());
    });

    $(".importeProducto").each(function(index){
      importeTotal += parseFloat($(this).val());
    });

    $("#totalArts").html(productos);
    $("#importeTotalVenta").html(formatCurrency(importeTotal));

  }

  //funcion tomada de http://selfcontained.us/2008/04/22/format-currency-in-javascript-simplified/
  function formatCurrency(num) {
    num = isNaN(num) || num === '' || num === null ? 0.00 : num;
    return "$ "+parseFloat(num).toFixed(2);
}