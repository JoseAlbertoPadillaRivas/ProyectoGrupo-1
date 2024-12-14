using Microsoft.AspNetCore.Mvc;

namespace ProyectoPJumbo.Controllers
{
    public class ErrorController : Controller
    {
        public IActionResult MostrarError()
        {
            return View("Error");
        }
    }
}
