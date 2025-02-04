using System;
namespace FoodShare 
{
  public class Restaurant : User
    {
        public int IdRestaurant { get; set; }
        public string Adresse { get; set; }
        public long Telephone { get; set; }

        public Restaurant(int idRestaurant, int idUser, string nom, string prenom, string email, string mdp, string role, string adresse, long telephone)
            : base(idUser, nom, prenom, email, mdp, role)
        {
            IdRestaurant = idRestaurant;
            Adresse = adresse;
            Telephone = telephone;
        }
    }
}
