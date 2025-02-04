using System;
namespace  FoodShare
{
   public class Association : User
    {
        public int IdAssociation { get; set; }
        public string Contact { get; set; }

        public Association(int idAssociation, int idUser, string nom, string prenom, string email, string mdp, string role, string contact)
            : base(idUser, nom, prenom, email, mdp, role)
        {
            IdAssociation = idAssociation;
            Contact = contact;
        }
    }
}
