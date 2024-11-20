using Microsoft.AspNetCore.Mvc;
using ProyectoPJumbo.Models;
using static System.Net.WebRequestMethods;
using System.Net.Http.Headers;
using System.Text.Json;
using ProyectoPJumbo.Servicios;

namespace ProyectoPJumbo.Controllers
{
    public class EmpleadoController : Controller
    {


        private readonly IHttpClientFactory _http;
        private readonly IConfiguration _conf;
        //private readonly IMetodosComunes _comunes;
        public EmpleadoController(IHttpClientFactory http, IConfiguration conf/*, IMetodosComunes comunes*/)
        {
            _http = http;
            _conf = conf;
            //_comunes = comunes;
        }

        [HttpGet]
        public IActionResult MostrarEmpleados()
        {
            using (var client = _http.CreateClient())
            {
                var consecutivo = int.Parse(HttpContext.Session.GetString("ConsecutivoUsuario")!);
                string url = _conf.GetSection("Variables:RutaApi").Value + "Empleado/MostrarEmpleados";

                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("TokenUsuario"));
                var response = client.GetAsync(url).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<List<Usuario>>((JsonElement)result.Contenido!);
                    return View(datosContenido!.Where(x => x.idUsuario != consecutivo).ToList());
                }

                return View(new List<Usuario>());
            }
        }
    }
}
