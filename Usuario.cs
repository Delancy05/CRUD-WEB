using System;

namespace CRUD.Biblioteca
{
    /// <summary>
    /// Modelo reutilizable de un usuario del CRUD.
    /// Vive en la biblioteca de clases (.dll) para poder usarse desde
    /// cualquier proyecto (web, escritorio, servicio...).
    /// </summary>
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string Nombre { get; set; }
        public int Edad { get; set; }
        public string Correo { get; set; }
        public DateTime FechaNacimiento { get; set; }
    }
}
