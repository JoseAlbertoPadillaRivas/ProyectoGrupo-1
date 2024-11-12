using Microsoft.AspNetCore.Mvc;
using ProyectoPJumbo.Models;
using System.Text.Json;
using static System.Net.WebRequestMethods;

namespace ProyectoPJumbo.Controllers
{
    public class EmpleadoController : Controller
    {
        //Inyecciones
        private readonly IHttpClientFactory _http;
        private readonly IConfiguration _conf;
        public EmpleadoController(IHttpClientFactory http, IConfiguration conf)
        {


            _http = http;
            _conf = conf;

        }

        [HttpGet]
        public IActionResult RegistrarEmpleado()
        {
            return View();
        }

        [HttpPost]
        public IActionResult RegistrarEmpleado(Empleado model)
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Empleado/RegistrarEmpleado";

                JsonContent datos = JsonContent.Create(model);

                var response = client.PostAsync(url, datos).Result; //LLama al Api//
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    return RedirectToAction("Inicio", "Home");
                }
                else
                {
                    ViewBag.Mensaje = result!.Mensaje;
                    return View();
                }
            }
        }

        [HttpGet]
        public IActionResult MostrarEmpleado()
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Empleado/MostrarEmpleado";

                var response = client.GetAsync(url).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<List<Empleado>>((JsonElement)result.Contenido!);
                    return View(datosContenido);
                }

                return View(new List<Empleado>());
            }
        }

        // Clase número 9//
        [HttpGet]
        public IActionResult EditarEmpleado()
        {
            return View();
        }

        [HttpPost]
        public IActionResult EditarEmpleado(Empleado model)
        {
            return View();
        }

        //Más Adelante ,no tocar//
        [HttpGet]
        public IActionResult GenerarFactura()
        {
            return View();
        }

   









    }

}
