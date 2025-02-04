using System;
namespace FoodShare 
{
  public class Plat
    {
        public int IdPlat { get; set; }
        public int IdRestaurant { get; set; }
        public string Nom { get; set; }
        public string Description { get; set; }
        public string Prix { get; set; }

        public Plat(int idPlat, int idRestaurant, string nom, string description, string prix)
        {
            IdPlat = idPlat;
            IdRestaurant = idRestaurant;
            Nom = nom;
            Description = description;
            Prix = prix;
        }
    }
}
