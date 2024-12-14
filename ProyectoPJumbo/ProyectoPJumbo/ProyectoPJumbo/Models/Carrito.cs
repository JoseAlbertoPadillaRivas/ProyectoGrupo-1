namespace ProyectoPJumbo.Models
{
    public class Carrito
    {
        public int ConsecutivoCarrito { get; set; }
        public int idUsuario { get; set; }
        public int ConsecutivoPlato { get; set; }
        public int Cantidad { get; set; }
        public decimal Total { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public int Precio { get; set; }
        public string Descripcion { get; set; } = string.Empty;
        public string RutaImagen { get; set; } = string.Empty;
    }
}
