using Microsoft.AspNetCore.Mvc;
using ProyectoPJumbo.Models;

namespace ProyectoPJumbo.Controllers
{
    public class EmpleadoController : Controller
    {

        [HttpGet]
        public IActionResult RegistrarEmpleado()
        {
            return View();
        }

        [HttpPost]
        public IActionResult RegistrarEmpleado(Empleado model)
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
