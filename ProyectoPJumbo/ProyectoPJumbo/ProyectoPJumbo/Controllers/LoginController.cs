using Microsoft.AspNetCore.Mvc;
using ProyectoPJumbo.Models;

namespace ProyectoPJumbo.Controllers
{
    public class LoginController : Controller
    {

        [HttpGet]
        public IActionResult InicioSesion()
        {
            return View();
        }

        [HttpPost]
        public IActionResult InicioSesion(Clientes model)
        {
            return View();
        }

        [HttpGet]
        public IActionResult Registrarse()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Registrarse(Clientes model)
        {
            return View();
        }

        [HttpGet]
        public IActionResult RecuperarAcceso()
        {
            return View();
        }

        [HttpPost]
        public IActionResult RecuperarAcceso(Clientes model)
        {
            return View();
        }
    }
}
