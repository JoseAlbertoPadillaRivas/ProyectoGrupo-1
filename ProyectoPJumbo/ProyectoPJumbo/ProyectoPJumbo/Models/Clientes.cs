namespace ProyectoPJumbo.Models
{
    public class Clientes
    {

        public long IdCliente { get; set; }
        public string Identificacion { get; set; } = string.Empty;
        public string Contrasena { get; set; } = string.Empty;
        public string NombreCliente { get; set; } = string.Empty;
        public string CorreoCliente { get; set; } = string.Empty;
        public string Telefono { get; set; } = string.Empty;

    }
}
