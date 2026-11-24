using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text.RegularExpressions;

namespace CRUD.Biblioteca
{
    /// <summary>
    /// Reglas de validación compartidas por todas las páginas del CRUD.
    /// Concentrar la lógica aquí evita repetirla en cada .aspx.cs (reutilización).
    /// </summary>
    public static class ValidadorUsuario
    {
        public const int EdadMinima = 1;
        public const int EdadMaxima = 120;

        private static readonly Regex PatronCorreo =
            new Regex(@"^[^@\s]+@[^@\s]+\.[^@\s]+$", RegexOptions.Compiled);

        /// <summary>
        /// Valida los textos que vienen del formulario. Devuelve la lista de errores
        /// (vacía si todo está bien) y, cuando es válido, el objeto Usuario ya convertido.
        /// </summary>
        public static List<string> Validar(string nombre, string edad, string correo,
                                           string fechaNacimiento, out Usuario usuario)
        {
            List<string> errores = new List<string>();
            usuario = null;

            string nom = (nombre ?? string.Empty).Trim();
            string mail = (correo ?? string.Empty).Trim();

            if (nom.Length == 0)
                errores.Add("El nombre es obligatorio.");
            else if (nom.Length > 150)
                errores.Add("El nombre no puede superar los 150 caracteres.");

            int edadNum;
            if (!int.TryParse(edad, NumberStyles.Integer, CultureInfo.InvariantCulture, out edadNum))
                errores.Add("La edad debe ser un número entero.");
            else if (edadNum < EdadMinima || edadNum > EdadMaxima)
                errores.Add("La edad debe estar entre " + EdadMinima + " y " + EdadMaxima + ".");

            if (mail.Length == 0)
                errores.Add("El correo es obligatorio.");
            else if (mail.Length > 150 || !PatronCorreo.IsMatch(mail))
                errores.Add("El correo no tiene un formato válido.");

            DateTime fecha;
            if (!DateTime.TryParseExact(fechaNacimiento ?? string.Empty, "yyyy-MM-dd",
                    CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha))
                errores.Add("La fecha de nacimiento no es válida.");
            else if (fecha.Date > DateTime.Today)
                errores.Add("La fecha de nacimiento no puede ser futura.");

            if (errores.Count == 0)
            {
                usuario = new Usuario
                {
                    Nombre = nom,
                    Edad = edadNum,
                    Correo = mail,
                    FechaNacimiento = fecha.Date
                };
            }

            return errores;
        }
    }
}
