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


        [HttpGet]
        public IActionResult MostrarEmpleado()
        {
            return View();
        }

        [HttpPost]
        public IActionResult MostrarEmpleado(Empleado model)
        {
            return View();
        }

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
