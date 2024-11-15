﻿using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ProyectoPJumbo.Models
{
    public class Empleado
    {

        public long IdEmpleado { get; set; }
        public string Identificacion { get; set; } = string.Empty;
        public string Nombre { get; set; } = string.Empty;
        public string CorreoEmpleado { get; set; } = string.Empty;

        public string Contrasena { get; set; } = string.Empty;
        public decimal Salario { get; set; }

        [ForeignKey("Puesto")]
        public long IdPuesto { get; set; }
        public string DescripcionPuesto { get; set; } = string.Empty;

        public int ConsecutivoRol { get; set; }
        public string NombreRol { get; set; } = string.Empty;
    }
}
