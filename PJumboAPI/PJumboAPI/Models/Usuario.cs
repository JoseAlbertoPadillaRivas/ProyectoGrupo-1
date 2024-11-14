namespace PJumboAPI.Models
{
    public class Usuario
    {
        public int idUsuario { get; set; }
        public string Cedula { get; set; } = string.Empty;

        public string NombreUsuario { get; set; } = string.Empty;
        public string Correo { get; set; } = string.Empty;
        public string Contrasenna { get; set; } = string.Empty;

        public double Salario { get; set; }
        public int ConsecutivoPuesto { get; set; }

        public int ConsecutivoRol { get; set; }
        public string NombreRol { get; set; } = string.Empty;


    }
}
