using System;
namespace FoodShare 
{
    public class User
    {
        protected int idUser;
        protected string nom, prenom, email, mdp, role;

        // Constructeurs 
        public User(int idUser, string nom, string prenom, string email, string mdp, string role)
        {
            this.idUser = idUser;
            this.nom = nom;
            this.prenom = prenom;
            this.email = email;
            this.mdp = mdp;
            this.role = role;
        }

        public User(string nom, string prenom, string email, string mdp, string role)
        {
            this.idUser = 0;
            this.nom = nom;
            this.prenom = prenom;
            this.email = email;
            this.mdp = mdp;
            this.role = role;
        }

        // Getters et Setters 
        public int IdUser { get => idUser; set => idUser = value; }
        public string Nom { get => nom; set => nom = value; }
        public string Prenom { get => prenom; set => prenom = value; }
        public string Email { get => email; set => email = value; }
        public string Mdp { get => mdp; set => mdp = value; }
        public string Role { get => role; set => role = value; }
    }
}
