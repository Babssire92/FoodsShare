using System;
namespace  FoodShare
{
   public class Association : User
    {
        public int IdAssociation { get; set; }
        public string Nom { get; set; }
        public string Contact { get; set; }

        public Association(int idAssociation, int idUser, string nom, string contact)
           
        {
            IdAssociation = idAssociation;
            Nom = nom;
            Contact = contact;
        }
    }
}
