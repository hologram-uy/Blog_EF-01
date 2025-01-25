using System;
using System.Text.RegularExpressions;

namespace Modelo.Util
{
    public static class ValidarArticulo
    {
        /// <summary>
        /// Valida una entidad de tipo Artículo.
        /// </summary>
        /// <param name="articulo"> el objeto artículo a validar</param>
        /// <returns>true si pasa las validaciones, de lo contrario false</returns>
        public static bool Validar(Articulo articulo)
        {
            // 1. Código
            if(!Regex.IsMatch(articulo.CodigoArt, @"^[a-zA-Z0-9]{10}$"))
            {
                Console.WriteLine($"El código {articulo.CodigoArt} no es válido.");
                return false;
            }

            // 2. Descripción
            if (!Regex.IsMatch(articulo.Descripcion, @"^.{3,40}$"))
            {
                Console.WriteLine($"La descripción del artículo debe contener entre 3 y 40 carácteres.");
                return false;
            }

            // 3. Precio
            if (articulo.Precio <= 0)
            {
                Console.WriteLine($"Debe especificar un precio mayor a cero.");
                return false;
            }

            // 4. FchIngreso
            if (articulo.FchIngreso == default(DateTime))
            {
                Console.WriteLine($"La fecha del artículo no es válida.");
                return false;
            }

            // 5. Categoría
            if (articulo.Categoria == null)
            {
                Console.WriteLine($"La categoría no puede ser nula.");
                return false;
            }

            return true;
        }
    }
}