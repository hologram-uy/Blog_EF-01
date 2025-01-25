using System;
using System.Collections.Generic;
using System.Linq;
using Modelo;
using Modelo.Util;

namespace EjemploEFConsola
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // 1. Declaramos e inicializamos el contexto
            Blog_EF01Entities context = new Blog_EF01Entities();

            // 2. Creamos una lista para recuperar los artículos 
            //    y la recorremos con un foreach
            List<Articulo> articulos = context.Articulo.ToList();

            foreach (var articulo in articulos)
            {
                Console.WriteLine($"Código: {articulo.CodigoArt}, " +
                                  $"Descripción: {articulo.Descripcion}, " +
                                  $"Categoría: {articulo.Categoria.Nombre}");
            }

            if(1==2)
            {
                // 3. Consultar un objeto de la tabla Categoria para añadir un artículo nuevo
                Categoria categoria
                    = context.Categoria
                                .Where(c => c.CodigoCat.Equals("ESC123"))
                                .FirstOrDefault();

                // 4. Creamos el nuevo artículo
                Articulo nuevoArticulo = new Articulo
                {
                    CodigoArt = "JGOGEO0001",
                    Descripcion = "Juego de geometría escolar",
                    Precio = 150.00m,
                    FchIngreso = DateTime.Now,
                    Categoria = categoria
                };

                // 5. Validación del nuevo objeto
                //    Invocamos la clase validar artículo desde Util
                bool esValido = ValidarArticulo.Validar(nuevoArticulo);

                // 6. Busco el código del artículo nuevo en la tabla
                Articulo buscoArticuloRepetido
                    = context.Articulo
                                .Where(a => a.CodigoArt.ToLower()
                                .Equals(nuevoArticulo.CodigoArt.ToLower()))
                                .FirstOrDefault();

                // 7. Falló las validaciones, se ingresó algún dato incorrecto
                if (!esValido)
                {
                    Console.WriteLine($"Las propiedades del artículo no son válidas.");
                    return;
                }

                // 8. Artículo repetido, buscoArticuloRepetido no es nulo
                if (buscoArticuloRepetido != null)
                {
                    Console.WriteLine($"El artículo con código {nuevoArticulo.CodigoArt} ya se encuentra registrado.");
                    return;
                }

                // 9. Llegué hasta acá, todo salió bien
                //    Agrego el nuevo artículo al contexto, pero aún no lo salvé en la base de datos
                context.Articulo.Add(nuevoArticulo);

                // 10. Esta es la operación que me confirma el insert (.Add)
                context.SaveChanges();

                // Brindamos un mensaje de éxito
                Console.WriteLine($"El artículo con código {nuevoArticulo.CodigoArt} fue agregado a la base de datos.");
            }

            if(1==2)
            {
                // 11. Modificar artículo
                Articulo articuloMalIngresado
                    = context.Articulo.Where(a => a.CodigoArt
                                      .Equals("K000000011"))
                                      .FirstOrDefault();

                // Necesito el objeto categoria TECH25 para la actualización
                Categoria categoriaTech 
                    = context.Categoria
                             .Where(c => c.CodigoCat.Equals("TECH25"))
                             .FirstOrDefault();

                if (articuloMalIngresado != null && categoriaTech != null)
                {
                    // Usamos las propiedades de navegación para modificar la categoría
                    articuloMalIngresado.Categoria = categoriaTech;

                    // Salvamos los cambios que hicimos en el contexto para el update en la base de datos
                    context.SaveChanges();

                    // Brindamos un mensaje de éxito
                    Console.WriteLine($"El artículo con código {articuloMalIngresado.CodigoArt} fue actualizado con éxito.");
                }
            }

            if(1==2)
            {
                // 12. Eliminar todos los artículos con categoría "MIS789"
                //     Para esto vamos a usar RemoveRange para los artículos que tienen esa categoría
                context.Articulo.RemoveRange(context.Articulo
                                .Where(a => a.Categoria.CodigoCat
                                .Equals("MIS789")));

                // Salvamos los cambios que hicimos en el contexto para el delete en la base de datos
                context.SaveChanges();

                // Brindamos un mensaje de éxito
                Console.WriteLine($"Los artículos con categoria 'MIS789' fueron eliminados con éxito.");
            }

            // Para que no se cierre la terminal
            Console.ReadLine();
        }
    }
}