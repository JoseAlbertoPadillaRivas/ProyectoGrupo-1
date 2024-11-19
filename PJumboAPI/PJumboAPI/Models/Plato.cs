namespace PJumboAPI.Models
{
    public class Plato
    {
        public int ConsecutivoPlato { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public int Precio { get; set; }
        public string RutaImagen { get; set; } = string.Empty;
    }
}
