using ProyectoPJumbo.Models;

namespace ProyectoPJumbo.Servicios
{
    public interface IMetodosComunes
    {
        string Encrypt(string texto);

        List<Carrito> ConsultarCarritoServicio();
    }
}
