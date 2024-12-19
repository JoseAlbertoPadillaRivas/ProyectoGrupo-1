using Microsoft.AspNetCore.Mvc;
using ProyectoPJumbo.Models;
using System.Text.Json;
using ProyectoPJumbo.Servicios;
using System.Net.Http.Headers;


namespace ProyectoPJumbo.Controllers
{
    public class LoginController : Controller
    {

        private readonly IHttpClientFactory _http;
        private readonly IConfiguration _conf;
        private readonly IMetodosComunes _comunes;
        public LoginController(IHttpClientFactory http, IConfiguration conf, IMetodosComunes comunes)
        {
            _http = http;
            _conf = conf;
            _comunes = comunes;
        }



        [HttpGet]
        public IActionResult IniciarSesion()
        {
            return View();
        }

        [HttpPost]
        public IActionResult IniciarSesion(Usuario model)
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Login/IniciarSesion";

                model.Contrasenna = _comunes.Encrypt(model.Contrasenna);

                JsonContent datos = JsonContent.Create(model);
                var response = client.PostAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<Usuario>((JsonElement)result.Contenido!);

                    HttpContext.Session.SetString("ConsecutivoUsuario", datosContenido!.idUsuario.ToString());
                    HttpContext.Session.SetString("Nombre", datosContenido!.NombreUsuario);
                    HttpContext.Session.SetString("ConsecutivoRol", datosContenido!.ConsecutivoRol.ToString());

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
        public IActionResult RegistroUsuarios()
        {
            return View();
        }

        [HttpPost]
        public IActionResult RegistroUsuarios(Usuario model)
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Login/RegistroUsuarios";
                model.Contrasenna = _comunes.Encrypt(model.Contrasenna);


                JsonContent datos = JsonContent.Create(model);

                var response = client.PostAsync(url, datos).Result; //LLama al Api//
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    return RedirectToAction("IniciarSesion", "Login");
                }
                else
                {
                    ViewBag.Mensaje = result!.Mensaje;
                    return View();
                }
            }
        }      

        [HttpGet]
        public IActionResult CerrarSesion()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }

        //[HttpGet]
        //public IActionResult RecuperarAcceso()
        //{
        //    return View();
        //}

        //[HttpPost]
        //public IActionResult RecuperarAcceso(Usuario model)
        //{
        //    using (var client = _http.CreateClient())
        //    {
        //        string url = _conf.GetSection("Variables:RutaApi").Value + "Login/RecuperarAcceso";

        //        JsonContent datos = JsonContent.Create(model);

        //        var response = client.PostAsync(url, datos).Result;
        //        var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

        //        if (result != null && result.Codigo == 0)
        //        {
        //            return RedirectToAction("IniciarSesion", "Login");
        //        }
        //        else
        //        {
        //            ViewBag.Mensaje = result!.Mensaje;
        //            return View();
        //        }
        //    }
        //}

    }

}
