using Microsoft.AspNetCore.Mvc;
using ProyectoPJumbo.Models;
using ProyectoPJumbo.Servicios;
using System.Net.Http.Headers;
using System.Text.Json;

namespace ProyectoPJumbo.Controllers
{
    public class CarritoController : Controller
    {
        private readonly IHttpClientFactory _http;
        private readonly IConfiguration _conf;
        private readonly IHostEnvironment _env;
        private readonly IMetodosComunes _comunes;

        public CarritoController(IHttpClientFactory http, IConfiguration conf, IHostEnvironment env, IMetodosComunes comunes)
        {
            _http = http;
            _conf = conf;
            _env = env;
            _comunes = comunes;
        }

        [HttpPost]
        public IActionResult AgregarCarrito(int ConsecutivoPlato, int Cantidad)
        {
            using (var client = _http.CreateClient())
            {
                var idUsuario = int.Parse(HttpContext.Session.GetString("idUsuario")!.ToString());

                var url = _conf.GetSection("Variables:RutaApi").Value + "Carrito/AgregarCarrito";

                var model = new Carrito();
                model.idUsuario = idUsuario;
                model.ConsecutivoPlato = ConsecutivoPlato;
                model.Cantidad = Cantidad;

                JsonContent datos = JsonContent.Create(model);

                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("TokenUsuario"));
                var response = client.PostAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                var carrito = _comunes.ConsultarCarritoServicio();
                HttpContext.Session.SetString("Total", carrito.Sum(x => x.Total).ToString());

                return Json(result!.Codigo);
            }
        }

        [HttpGet]
        public IActionResult ConsultarCarrito()
        {
            return View(_comunes.ConsultarCarritoServicio());
        }

    }
}
