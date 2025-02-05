using System;
namespace FoodShare 
{
  public class Restaurant 
    {
        public int IdRestaurant { get; set; }
        public string Nom { get; set; }
        public string Adresse { get; set; }
        public long Telephone { get; set; }

        public Restaurant(int idRestaurant, int idUser, string nom,string adresse, long telephone)
            
        {
            IdRestaurant = idRestaurant;
            Nom = nom;
            Adresse = adresse;
            Telephone = telephone;
        }
    }
}
