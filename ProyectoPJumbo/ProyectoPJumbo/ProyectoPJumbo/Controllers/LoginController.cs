using Microsoft.AspNetCore.Mvc;

namespace ProyectoPJumbo.Controllers
{
    public class LoginController : Controller
    {
        public IActionResult InicioSesion()
        {
            return View();
        }

        public IActionResult Registrarse()
        {
            return View();
        }

        public IActionResult RecuperarAcceso()
        {
            return View();
        }
    }
}
