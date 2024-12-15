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

        // Agregamos los platos hacia al carrito
        [HttpPost]
        public IActionResult AgregarCarrito(int ConsecutivoPlato, int Cantidad)
        {
            using (var client = _http.CreateClient())
            {
                var idUsuario = int.Parse(HttpContext.Session.GetString("ConsecutivoUsuario")!.ToString());

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

        // Consultamos los platos que estan dentro del carrito
        [HttpGet]
        public IActionResult ConsultarCarrito()
        {
            return View(_comunes.ConsultarCarritoServicio());
        }

        // Remover platos del carrito
        [HttpPost]
        public IActionResult RemoverPlatoCarrito(Carrito carrito)
        {
            using (var client = _http.CreateClient())
            {
                var url = _conf.GetSection("Variables:RutaApi").Value + "Carrito/RemoverPlatoCarrito";

                carrito.idUsuario = int.Parse(HttpContext.Session.GetString("ConsecutivoUsuario")!.ToString());

                JsonContent datos = JsonContent.Create(carrito);

                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("TokenUsuario"));
                var response = client.PostAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var carritos = _comunes.ConsultarCarritoServicio();
                    HttpContext.Session.SetString("Total", carritos.Sum(x => x.Total).ToString());

                    return RedirectToAction("ConsultarCarrito", "Carrito");
                }
                else
                {
                    ViewBag.Mensaje = result!.Mensaje;
                    return View("ConsultarCarrito", _comunes.ConsultarCarritoServicio());
                }
            }
        }

        // Se realiza el Pago del Carrito
        [HttpPost]
        public IActionResult PagarCarrito(Carrito carrito)
        {
            using (var client = _http.CreateClient())
            {
                var url = _conf.GetSection("Variables:RutaApi").Value + "Carrito/PagarCarrito";

                carrito.idUsuario = int.Parse(HttpContext.Session.GetString("ConsecutivoUsuario")!.ToString());

                JsonContent datos = JsonContent.Create(carrito);

                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("TokenUsuario"));
                var response = client.PostAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var carritos = _comunes.ConsultarCarritoServicio();
                    HttpContext.Session.SetString("Total", carritos.Sum(x => x.Total).ToString());

                    return RedirectToAction("ConsultarCarrito", "Carrito");
                }
                else
                {
                    ViewBag.Mensaje = result!.Mensaje;
                    return View("ConsultarCarrito", _comunes.ConsultarCarritoServicio());
                }
            }
        }

        // Se Consulta la Factura
        [HttpGet]
        public IActionResult ConsultarFacturas()
        {
            using (var client = _http.CreateClient())
            {
                var idUsuario = int.Parse(HttpContext.Session.GetString("ConsecutivoUsuario")!.ToString());

                string url = _conf.GetSection("Variables:RutaApi").Value + "Carrito/ConsultarFacturas?idUsuario=" + idUsuario;

                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("TokenUsuario"));
                var response = client.GetAsync(url).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<List<Carrito>>((JsonElement)result.Contenido!);
                    return View(datosContenido!.ToList());
                }

                return View(new List<Carrito>());
            }
        }
    }
}
