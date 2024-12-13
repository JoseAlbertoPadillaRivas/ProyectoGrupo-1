using Microsoft.AspNetCore.Mvc;
using ProyectoPJumbo.Models;
using ProyectoPJumbo.Servicios;
using System.Net.Http.Headers;
using System.Reflection;
using System.Text.Json;

namespace ProyectoPJumbo.Controllers
{
    public class MenuController : Controller
    {

        private readonly IHttpClientFactory _http;
        private readonly IConfiguration _conf;
        private readonly IHostEnvironment _env;

        public MenuController(IHttpClientFactory http, IConfiguration conf, IHostEnvironment env)
        {
            _http = http;
            _conf = conf;
            _env = env;
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
        public IActionResult CrearPlato(IFormFile Imagen,Plato plato)
        {
            var ext = string.Empty;
            var folder = string.Empty;
            plato.RutaImagen = string.Empty;

            if (Imagen != null)
            {
                ext = Path.GetExtension(Path.GetFileName(Imagen.FileName));
                folder = Path.Combine(_env.ContentRootPath, "wwwroot\\Platos");
                plato.RutaImagen = "/Platos/";

                if (ext.ToLower() != ".png")
                {
                    ViewBag.Mensaje = "La imagen debe ser .png";
                    return View();
                }
            }

            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Menu/CrearPlato";

                JsonContent datos = JsonContent.Create(plato);

                var response = client.PostAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    if (Imagen != null)
                    {
                        string archivo = Path.Combine(folder, result.Mensaje + ext);
                        using (Stream fs = new FileStream(archivo, FileMode.Create))
                        {
                            Imagen.CopyTo(fs);
                        }
                    }
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
