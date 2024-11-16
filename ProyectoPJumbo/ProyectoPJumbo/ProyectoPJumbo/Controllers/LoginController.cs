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
        //private readonly IMetodosComunes _comunes;
        public LoginController(IHttpClientFactory http, IConfiguration conf/*, IMetodosComunes comunes*/)
        {
            _http = http;
            _conf = conf;
            //_comunes = comunes;
        }


        //Acciones de los Uusarios de Pizzeria Jumbo//

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

                //model.Contrasenna = _comunes.Encrypt(model.Contrasenna);

                JsonContent datos = JsonContent.Create(model);

                var response = client.PostAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<Usuario>((JsonElement)result.Contenido!);

                    HttpContext.Session.SetString("ConsecutivoUsuario", datosContenido!.idUsuario.ToString());
                    HttpContext.Session.SetString("NombreUsuario", datosContenido!.NombreUsuario);

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
                string url = _conf.GetSection("Variables:RutaApi").Value + "Usuario/RegistroUsuarios";
                //model.Contrasenna = _comunes.Encrypt(model.Contrasenna);


                JsonContent datos = JsonContent.Create(model);

                var response = client.PostAsync(url, datos).Result; //LLama al Api//
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    return RedirectToAction("Login", "Login");
                }
                else
                {
                    ViewBag.Mensaje = result!.Mensaje;
                    return View();
                }
            }
        }


      
        
        //Acciones del Empleado//
        //Revisar y modificar en cualquier caso que lo ocupen chicos//


        [HttpGet]
        public IActionResult MostrarEmpleado()
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Usuario/MostrarEmpleado";

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

        [HttpGet]
        public IActionResult ActualizarEmpleado()
        {
            using (var client = _http.CreateClient())
            {
           
                var consecutivo = HttpContext.Session.GetString("ConsecutivoEmpleado");
                string url = _conf.GetSection("Variables:RutaApi").Value + "Empleado/MostrarEmpleado?Consecutivo=" + consecutivo;
                var response = client.GetAsync(url).Result;

                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    var datosContenido = JsonSerializer.Deserialize<Empleado>((JsonElement)result.Contenido!);                
                    return View(datosContenido);
                }
        
                return View(new Empleado());
            }
        }




        //Mas tarde//
        [HttpDelete]
        public IActionResult EliminarEmpleado()
        {
            return View();
        }



    }

}
