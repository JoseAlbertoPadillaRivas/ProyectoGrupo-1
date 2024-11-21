function ConsultarNombre() {

    let identificacion = $("#Cedula").val();
    $("#NombreUsuario").val("");

    if (identificacion.length >= 9) {
        $.ajax({
            method: "GET",
            url: "https://apis.gometa.org/cedulas/" + identificacion,
            dataType: "json",
            success: function (data) {
                $("#NombreUsuario").val(data.nombre);
            }
        });
    }

}
