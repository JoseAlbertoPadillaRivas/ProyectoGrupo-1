using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using PJumboAPI.Models;

namespace PJumboAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MenuController : ControllerBase
    {
        private readonly IConfiguration _conf;

        public MenuController(IConfiguration conf)
        {
            _conf = conf;
        }


        [HttpPost]
        [Route("CrearPlato")]
        public IActionResult CrearPlato(Plato plato)        {
            
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.QueryFirstOrDefault<Plato>("CrearPlato", new { plato.Nombre,plato.Precio,plato.Descripcion,plato.RutaImagen });

                if (result != null)
                {
                    respuesta.Codigo = 0;
                    respuesta.Mensaje = result.ConsecutivoPlato.ToString();

                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "El plato no se ha registrado correctamente";
                }

                return Ok(respuesta);
            }
        }

        [HttpGet]
        [Route("MostrarMenu")]
        public IActionResult MostrarMenu()
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Query<Plato>("MostrarMenu", new { });

                if (result.Any())
                {
                    respuesta.Codigo = 0;
                    respuesta.Contenido = result;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "No hay platos registrados en el sistema";
                }

                return Ok(respuesta);
            }
        }

       
        [HttpGet]
        [Route("ConsultarPlato")]
        public IActionResult ConsultarPlato(int ConsecutivoPlato)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.QueryFirstOrDefault<Plato>("ConsultarPlato", new { ConsecutivoPlato });

                if (result != null)
                {
                    respuesta.Codigo = 0;
                    respuesta.Contenido = result;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "No se encontró la información del Plato";
                }

                return Ok(respuesta);
            }
        }

        [HttpPut]
        [Route("ActualizarPlato")]
        public IActionResult ActualizarPlato(Plato plato)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Execute("ActualizarPlato", new { plato.ConsecutivoPlato, plato.Nombre, plato.Precio, plato.Descripcion});

                if (result > 0)
                {
                    respuesta.Codigo = 0;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "La información del plato no se ha actualizado correctamente";
                }

                return Ok(respuesta);
            }
        }

        [HttpPut]
        [Route("ActualizarEstado")]
        public IActionResult ActualizarEstado(Plato plato)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Execute("ActualizarEstadoPlato", new { plato.ConsecutivoPlato });

                if (result > 0)
                {
                    respuesta.Codigo = 0;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "El estado del plato no se ha actualizado correctamente";
                }

                return Ok(respuesta);
            }
        }
    }
}
