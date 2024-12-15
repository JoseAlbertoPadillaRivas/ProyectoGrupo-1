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
                string consecutivoRolString = HttpContext.Session.GetString("ConsecutivoRol") ?? "0";
                int consecutivoRol = int.Parse(consecutivoRolString);

                // URL del API con el parámetro consecutivoRol
                string url = $"{_conf.GetSection("Variables:RutaApi").Value}Menu/MostrarMenu?consecutivoRol={consecutivoRol}";

                // Llama al API
                var response = client.GetAsync(url).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    // Convierte el contenido a la lista de platos
                    var datosContenido = JsonSerializer.Deserialize<List<Plato>>((JsonElement)result.Contenido!);
                    return View(datosContenido.ToList());
                }

                // Si no hay datos, retorna una vista vacía
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

        [HttpGet]
        public async Task<IActionResult> ActualizarPlato(int consecutivoPlato)
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Menu/ConsultarPlato?ConsecutivoPlato=" + consecutivoPlato;

                var response = await client.GetAsync(url);
                var result = await response.Content.ReadFromJsonAsync<Respuesta>();

                 if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<Plato>((JsonElement)result.Contenido!);
                    return Json(datosContenido); // Devuelve JSON en lugar de una vista
                }

                return Json(null);
            }
        }

        [HttpPost]
        public IActionResult ActualizarPlato(IFormFile Imagen, Plato plato)
        {
            var ext = string.Empty;
            var folder = string.Empty;

            if (Imagen != null)
            {
                ext = Path.GetExtension(Path.GetFileName(Imagen.FileName));
                folder = Path.Combine(_env.ContentRootPath, "wwwroot\\Platos");

                if (ext.ToLower() != ".png")
                {
                    ViewBag.Mensaje = "La imagen debe ser .png";
                    return View();
                }
            }

            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Menu/ActualizarPlato";

                JsonContent datos = JsonContent.Create(plato);
                
                var response = client.PutAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    if (Imagen != null)
                    {
                        string archivo = Path.Combine(folder, plato.ConsecutivoPlato + ext);
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


        [HttpPost]
        public IActionResult ActualizarEstado(Plato model)
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Menu/ActualizarEstado";

                JsonContent datos = JsonContent.Create(model);
                                
                var response = client.PutAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    return RedirectToAction("Menu", "Menu");
                }
                else
                {
                    ViewBag.Mensaje = result!.Mensaje;
                    var datos2 = ObtenerDatosPlatos();
                    return View("ConsultarPlatos", datos2);
                }
            }
        }
        private List<Plato> ObtenerDatosPlatos()
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Menu/MostrarMenu";

                var response = client.GetAsync(url).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<List<Plato>>((JsonElement)result.Contenido!);
                    return datosContenido!.ToList();
                }

                return new List<Plato>();
            }
        }
    }    
}
