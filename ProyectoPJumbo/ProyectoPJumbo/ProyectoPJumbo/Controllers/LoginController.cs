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

                //model.Contrasenna = _comunes.Encrypt(model.Contrasenna);

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
                //model.Contrasenna = _comunes.Encrypt(model.Contrasenna);


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

        //Acciones del Empleado//
        //Revisar y modificar en cualquier caso  lo ocupen chicos//


        [HttpGet]
        public IActionResult MostrarEmpleado()
        {
            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Login/MostrarEmpleado";

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

                var consecutivo = HttpContext.Session.GetString("IdEmpleado");  //Revisar//
                string url = _conf.GetSection("Variables:RutaApi").Value + "Login/MostrarEmpleado?Consecutivo=" + consecutivo;
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


        [HttpPost]
        public IActionResult ActualizarEmpleado(Empleado model)
        {
            model.IdEmpleado = long.Parse(HttpContext.Session.GetString("IdEmpleado")!);

            using (var client = _http.CreateClient())
            {
                string url = _conf.GetSection("Variables:RutaApi").Value + "Login/ActualizarEmpleado";

                JsonContent datos = JsonContent.Create(model);

                var response = client.PutAsync(url, datos).Result;
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                if (result != null && result.Codigo == 0)
                {
                    HttpContext.Session.SetString("NombreEmpleado", model.Nombre);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ViewBag.Mensaje = result!.Mensaje;
                    return View();
                }
            }
        }

        [HttpPost]
        public IActionResult EliminarEmpleado(long idEmpleado)
        {
            using (var client = _http.CreateClient())
            {
                // Construir la URL con el parámetro IdEmpleado como parte de la consulta
                string url = _conf.GetSection("Variables:RutaApi").Value + "Login/EliminarEmpleado?IdEmpleado=" + idEmpleado;

                // Enviar la solicitud DELETE sin cuerpo, solo con la URL que contiene el parámetro
                var response = client.DeleteAsync(url).Result;

                // Leer la respuesta de la API
                var result = response.Content.ReadFromJsonAsync<Respuesta>().Result;

                // Verificar si la eliminación fue exitosa
                if (result != null && result.Codigo == 0)
                {
                    return RedirectToAction("Index", "Home"); // Redirigir a la página principal o a donde sea necesario
                }
                else
                {
                    ViewBag.Mensaje = result?.Mensaje ?? "Ocurrió un error al eliminar al empleado."; // Mensaje de error
                    return View();  // Mostrar la vista actual con el mensaje
                }
            }
        }

        [HttpGet]
        public IActionResult CerrarSesion()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }

    }

}
