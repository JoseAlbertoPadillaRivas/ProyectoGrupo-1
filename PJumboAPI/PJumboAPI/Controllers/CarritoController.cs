using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using PJumboAPI.Models;

namespace PJumboAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CarritoController : ControllerBase
    {
        private readonly IConfiguration _conf;
        public CarritoController(IConfiguration conf, IHostEnvironment env)
        {
            _conf = conf;
        }

        [HttpPost]
        [Route("AgregarCarrito")]
        public IActionResult AgregarCarrito(Carrito carrito)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Execute("AgregarCarrito", new { carrito.idUsuario, carrito.ConsecutivoPlato, carrito.Cantidad });

                if (result > 0)
                {
                    respuesta.Codigo = 0;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "El plato no se ha registrado correctamente en el carrito";
                }

                return Ok(respuesta);
            }
        }

        [HttpGet]
        [Route("ConsultarCarrito")]
        public IActionResult ConsultarCarrito(int idUsuario)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Query<Carrito>("ConsultarCarrito", new { idUsuario });

                if (result.Any())
                {
                    respuesta.Codigo = 0;
                    respuesta.Contenido = result;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "No hay platos en su carrito momento";
                }

                return Ok(respuesta);
            }
        }

        [HttpPost]
        [Route("RemoverPlatoCarrito")]
        public IActionResult RemoverPlatoCarrito(Carrito model)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Execute("RemoverPlatoCarrito", new { model.idUsuario, model.ConsecutivoPlato });

                if (result > 0)
                {
                    respuesta.Codigo = 0;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "El plato no se ha removido del carrito";
                }

                return Ok(respuesta);
            }
        }

        [HttpPost]
        [Route("PagarCarrito")]
        public IActionResult PagarCarrito(Carrito carrito)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Execute("PagarCarrito", new { carrito.idUsuario });

                if (result > 0)
                {
                    respuesta.Codigo = 0;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "No se realizó el pago de su carrito";
                }

                return Ok(respuesta);
            }
        }

        [HttpGet]
        [Route("ConsultarFacturas")]
        public IActionResult ConsultarFacturas(int idUsuario)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Query<Carrito>("ConsultarFacturas", new { idUsuario });

                if (result.Any())
                {
                    respuesta.Codigo = 0;
                    respuesta.Contenido = result;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "No hay facturas en este momento";
                }

                return Ok(respuesta);
            }
        }
    }
}
