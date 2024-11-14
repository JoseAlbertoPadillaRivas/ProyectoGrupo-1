using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using PJumboAPI.Models;

namespace PJumboAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly IConfiguration _conf;

        public UsuarioController(IConfiguration conf)
        {
            _conf = conf;
        }


    }
}
