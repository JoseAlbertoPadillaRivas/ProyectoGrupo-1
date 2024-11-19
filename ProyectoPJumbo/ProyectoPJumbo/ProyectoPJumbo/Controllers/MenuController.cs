using Microsoft.AspNetCore.Mvc;
using ProyectoPJumbo.Models;
using ProyectoPJumbo.Servicios;
using System.Net.Http.Headers;
using System.Text.Json;

namespace ProyectoPJumbo.Controllers
{
    public class MenuController : Controller
    {

        private readonly IHttpClientFactory _http;
        private readonly IConfiguration _conf;

        public MenuController(IHttpClientFactory http, IConfiguration conf)
        {
            _http = http;
            _conf = conf;           
        }

        [HttpGet]
        public IActionResult Menu()
        {
            using (var client = _http.CreateClient())
            {               
                string url = _conf.GetSection("Variables:RutaApi").Value + "Menu/MostrarMenu";

                var response = client.GetAsync(url).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<List<Plato>>((JsonElement)result.Contenido!);
                    return View(datosContenido.ToList());
                }

                return View(new List<Plato>());
            }
        }

        [HttpGet]
        public IActionResult CrearPlato()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CrearPlato(Plato plato)
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Menu/CrearPlato";

                JsonContent datos = JsonContent.Create(plato);

                var response = client.PostAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    return RedirectToAction("Menu", "Menu");
                }
                else
                {
                    ViewBag.Mensaje = result!.Mensaje;
                    return View();
                }
            }
        }
    }
}
