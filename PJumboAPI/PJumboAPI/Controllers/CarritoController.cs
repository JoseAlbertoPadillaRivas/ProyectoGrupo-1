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
                    respuesta.Mensaje = "El producto no se ha registrado correctamente en el carrito";
                }

                return Ok(respuesta);
            }
        }

        [HttpGet]
        [Route("ConsultarCarrito")]
        public IActionResult ConsultarCarrito(int ConsecutivoCarrito)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Query<Carrito>("ConsultarCarrito", new { ConsecutivoCarrito });

                if (result.Any())
                {
                    respuesta.Codigo = 0;
                    respuesta.Contenido = result;
                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "No hay productos en su carrito momento";
                }

                return Ok(respuesta);
            }
        }

    }
}
