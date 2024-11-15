﻿using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using PJumboAPI.Models;

namespace PJumboAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IConfiguration _conf;

        public LoginController(IConfiguration conf)
        {
            _conf = conf;
        }



        [HttpPost]
        [Route("RegistroUsuarios")]
        public IActionResult RegistroUsuarios(Usuario model)
        {

            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Execute("RegistroUsuarios", new { model.Cedula, model.NombreUsuario, model.Correo, model.Contrasenna });

                if (result > 0)
                {
                    respuesta.Codigo = 0;
                }

                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "Su información no se ha registrado correctamente";
                }

                return Ok(respuesta);
            }

        }

        [HttpPost]
        [Route("IniciarSesion")]
        public IActionResult IniciarSesion(Usuario model)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.QueryFirstOrDefault<Usuario>("IniciarSesion", new { model.Correo, model.Contrasenna });

                if (result != null)
                {
                    respuesta.Codigo = 0;
                    respuesta.Contenido = result;

                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "Su información no se encontró en nuestro sistema";
                }

                return Ok(respuesta);
            }
        }


        //LLamado a las acciones de puesto Empleados//

        [HttpGet]
        [Route("MostrarEmpleado")]
        public IActionResult MostrarEmpleado()
        {

            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Query<Empleado>("MostrarEmpleado", new { });

                if (result.Any())
                {
                    respuesta.Codigo = 0;
                    respuesta.Contenido = result;
                }

                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "Su resgistro de empleado no sé encuentra en nuestro sistema por favor verificar.";
                }

                return Ok(respuesta);
            }

        }


        [HttpPut]
        [Route("ActualizarEmpleado")]
        public IActionResult ActualizarEmpleado(Empleado model)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Execute("ActualizarEmpleado", new { model.Identificacion, model.Nombre, model.CorreoEmpleado, model.ConsecutivoRol });

                if (result > 0)
                {
                    respuesta.Codigo = 0;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "Su información de puesto empleado no se ha actualizado correctamente";
                }

                return Ok(respuesta);
            }
        }


        [HttpDelete]
        [Route("EliminarEmpleado")]
        public IActionResult EliminarEmpleado(long idEmpleado)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();

                // Ejecutar la consulta DELETE para eliminar al empleado
                var result = context.Execute("DELETE FROM Empleados WHERE IdEmpleado = @IdEmpleado", new { IdEmpleado = idEmpleado });

                if (result > 0)
                {
                    respuesta.Codigo = 0;  // Eliminación exitosa
                    respuesta.Mensaje = "El empleado ha sido eliminado correctamente.";
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "No se pudo eliminar el empleado. Verifique si el empleado existe.";
                }

                return Ok(respuesta);  // Retornar la respuesta con el código y mensaje
            }
        }

    }
}
