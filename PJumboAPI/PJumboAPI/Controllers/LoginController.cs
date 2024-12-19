using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using PJumboAPI.Models;

namespace PJumboAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IConfiguration _conf;

        public LoginController(IConfiguration conf)
        {
            _conf = conf;
        }



        [HttpPost]
        [Route("RegistroUsuarios")]
        public IActionResult RegistroUsuarios(Usuario model)
        {

            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.Execute("RegistroUsuarios", new { model.Cedula, model.NombreUsuario, model.Correo, model.Contrasenna });

                if (result > 0)
                {
                    respuesta.Codigo = 0;
                }

                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "Su información no se ha registrado correctamente";
                }

                return Ok(respuesta);
            }

        }

        [HttpPost]
        [Route("IniciarSesion")]
        public IActionResult IniciarSesion(Usuario model)
        {
            using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var respuesta = new Respuesta();
                var result = context.QueryFirstOrDefault<Usuario>("IniciarSesion", new { model.Correo, model.Contrasenna });

                if (result != null)
                {
                    respuesta.Codigo = 0;
                    respuesta.Contenido = result;

                }
                else
                {
                    respuesta.Codigo = -1;
                    respuesta.Mensaje = "Su información no se encontró en nuestro sistema";
                }

                return Ok(respuesta);
            }
        }

        //[HttpPost]
        //[Route("RecuperarAcceso")]
        //public IActionResult RecuperarAcceso(Usuario model)
        //{
        //    using (var context = new SqlConnection(_conf.GetSection("ConnectionStrings:DefaultConnection").Value))
        //    {
        //        var respuesta = new Respuesta();

        //        //var parameters = new DynamicParameters();
        //        //parameters.Add("CorreoElectronico", model.Correo);
        //        //var result = context.QueryFirstOrDefault<Usuario>("ValidarUsuario", parameters);

        //        var result = context.QueryFirstOrDefault<Usuario>("ValidarUsuario", new { model.Correo });

        //        if (result != null)
        //        {
        //            var Codigo = GenerarCodigo();
        //            var Contrasenna = Encrypt(Codigo);
        //            var UsaClaveTemp = true;
        //            var Vigencia = DateTime.Now.AddMinutes(10);
        //            context.Execute("ActualizarContrasenna", new { result.Consecutivo, Contrasenna, UsaClaveTemp, Vigencia });

        //            var ruta = Path.Combine(_env.ContentRootPath, "RecuperarAcceso.html");
        //            var html = System.IO.File.ReadAllText(ruta);

        //            html = html.Replace("@@Nombre", result.Nombre);
        //            html = html.Replace("@@Contrasenna", Codigo);
        //            html = html.Replace("@@Vencimiento", Vigencia.ToString("dd/MM/yyyy hh:mm tt"));

        //            EnviarCorreo(result.Correo, "Recuperar Accesos Sistema", html);

        //            respuesta.Codigo = 0;
        //            respuesta.Contenido = result;
        //        }
        //        else
        //        {
        //            respuesta.Codigo = -1;
        //            respuesta.Mensaje = "Su información no se encontró en nuestro sistema";
        //        }

        //        return Ok(respuesta);
        //    }
        }

    }
}
