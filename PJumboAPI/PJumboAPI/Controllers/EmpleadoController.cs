using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using PJumboAPI.Models;

namespace PJumboAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmpleadoController : ControllerBase
    {
        private readonly IConfiguration _conf;

        public EmpleadoController(IConfiguration conf)
        {
            _conf = conf;
        }

        [HttpPost]
        [Route("RegistrarEmpleado")]
        public IActionResult RegistrarEmpleado(Empleado model)
        {

            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Execute("RegistrarEmpleado", new { model.Identificacion, model.Nombre, model.Contrasena,model.CorreoEmpleado,model.Salario,model.IdPuesto });

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

    }
    }

