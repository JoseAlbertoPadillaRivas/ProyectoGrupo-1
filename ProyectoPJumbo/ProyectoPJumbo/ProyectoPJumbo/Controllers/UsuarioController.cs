using Microsoft.AspNetCore.Mvc;
using ProyectoPJumbo.Models;
using static System.Net.WebRequestMethods;
using System.Net.Http.Headers;
using System.Text.Json;
using ProyectoPJumbo.Servicios;

namespace ProyectoPJumbo.Controllers
{
    public class UsuarioController : Controller
    {


        private readonly IHttpClientFactory _http;
        private readonly IConfiguration _conf;
        //private readonly IMetodosComunes _comunes;
        public UsuarioController(IHttpClientFactory http, IConfiguration conf/*, IMetodosComunes comunes*/)
        {
            _http = http;
            _conf = conf;
            //_comunes = comunes;
        }



        [HttpGet]
        public IActionResult ActualizarPerfil()
        {
            using (var client = _http.CreateClient())
            {
                var consecutivo = HttpContext.Session.GetString("ConsecutivoUsuario");
                string url = _conf.GetSection("Variables:RutaApi").Value + "Usuario/ConsultarUsuario?idUsuario=" + consecutivo;
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("TokenUsuario"));

                var response = client.GetAsync(url).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<Usuario>((JsonElement)result.Contenido!);
                    return View(datosContenido);
                }

                return View(new Usuario());
            }
        }

        [HttpPost]
        public IActionResult ActualizarPerfil(Usuario model)
        {
            model.idUsuario = int.Parse(HttpContext.Session.GetString("ConsecutivoUsuario")!);

            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Usuario/ActualizarPerfil";

                JsonContent datos = JsonContent.Create(model);
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", HttpContext.Session.GetString("TokenUsuario"));


                var response = client.PutAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    HttpContext.Session.SetString("Nombre", model.NombreUsuario);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ViewBag.Mensaje = result!.Mensaje;
                    return View();
                }
            }
        }



        [HttpGet]
        public IActionResult ConsultarUsuarios()
        {
            using (var client = _http.CreateClient())
            {
                var consecutivo = int.Parse(HttpContext.Session.GetString("ConsecutivoUsuario")!);
                string url = _conf.GetSection("Variables:RutaApi").Value + "Usuario/ConsultarUsuarios";

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
