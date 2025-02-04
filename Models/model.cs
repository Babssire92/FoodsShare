using System;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.Data.Common;
using System.Diagnostics;

namespace BddFoodShare
{
    public class Modele
    {
        private string serveur, bdd, user, mdp;
        private MySqlConnection maConnexion;

        public Modele(string serveur, string bdd, string user, string mdp)
        {
            this.serveur = serveur;
            this.bdd = bdd;
            this.user = user;
            this.mdp = mdp;
            string url = "SslMode=None";
            url += "; Server=" + this.serveur;
            url += "; Port=3306"; 
            url += "; Database=" + this.bdd;
            url += "; User Id=" + this.user;
            url += "; Password=" + this.mdp;

            try
            {
                this.maConnexion = new MySqlConnection(url);
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion à la BDD : " + url);
            }
        }

        /************** Gestion des Utilisateurs **************/
        public void InsertUser(User unUser)
        {
            string requete = "CALL insertUser(@nom, @prenom, @email, @mdp, @role);";
            ExecuteNonQuery(requete, new Dictionary<string, object>
            {
                {"@nom", unUser.Nom},
                {"@prenom", unUser.Prenom},
                {"@email", unUser.Email},
                {"@mdp", unUser.Mdp},
                {"@role", unUser.Role}
            });
        }

        public void DeleteUser(int idUser)
        {
            string requete = "CALL deleteUser(@idUser);";
            ExecuteNonQuery(requete, new Dictionary<string, object> { { "@idUser", idUser } });
        }

        public void UpdateUser(User unUser)
        {
            string requete = "CALL updateUser(@idUser, @nom, @prenom, @email, @mdp, @role);";
            ExecuteNonQuery(requete, new Dictionary<string, object>
            {
                {"@idUser", unUser.Id},
                {"@nom", unUser.Nom},
                {"@prenom", unUser.Prenom},
                {"@email", unUser.Email},
                {"@mdp", unUser.Mdp},
                {"@role", unUser.Role}
            });
        }

        public List<User> SelectAllUsers()
        {
            string requete = "SELECT * FROM v_liste_users;";
            return ExecuteQuery<User>(requete, reader => new User(
                reader.GetInt32(0),
                reader.GetString(1),
                reader.GetString(2),
                reader.GetString(3),
                reader.GetString(4),
                reader.GetString(5)
            ));
        }

        /************** Gestion des Associations **************/
        public void InsertAssociation(Association uneAssociation)
        {
            string requete = "CALL insertAssociation(@nom, @adresse, @telephone);";
            ExecuteNonQuery(requete, new Dictionary<string, object>
            {
                {"@nom", uneAssociation.Nom},
                {"@adresse", uneAssociation.Adresse},
                {"@telephone", uneAssociation.Telephone}
            });
        }

        public void DeleteAssociation(int idAssociation)
        {
            string requete = "CALL deleteAssociation(@idAssociation);";
            ExecuteNonQuery(requete, new Dictionary<string, object> { { "@idAssociation", idAssociation } });
        }

        public List<Association> SelectAllAssociations()
        {
            string requete = "SELECT * FROM v_liste_associations;";
            return ExecuteQuery<Association>(requete, reader => new Association(
                reader.GetInt32(0),
                reader.GetString(1),
                reader.GetString(2),
                reader.GetString(3)
            ));
        }

        /************** Gestion des Restaurants **************/
        public void InsertRestaurant(Restaurant unRestaurant)
        {
            string requete = "CALL insertRestaurant(@nom, @adresse, @telephone);";
            ExecuteNonQuery(requete, new Dictionary<string, object>
            {
                {"@nom", unRestaurant.Nom},
                {"@adresse", unRestaurant.Adresse},
                {"@telephone", unRestaurant.Telephone}
            });
        }

        public List<Restaurant> SelectAllRestaurants()
        {
            string requete = "SELECT * FROM v_liste_restaurants;";
            return ExecuteQuery<Restaurant>(requete, reader => new Restaurant(
                reader.GetInt32(0),
                reader.GetString(1),
                reader.GetString(2),
                reader.GetString(3)
            ));
        }

        /************** Gestion des Dons **************/
        public void InsertDon(Don unDon)
        {
            string requete = "CALL insertDon(@dateDon, @idRestaurant, @idAssociation);";
            ExecuteNonQuery(requete, new Dictionary<string, object>
            {
                {"@dateDon", unDon.DateDon},
                {"@idRestaurant", unDon.IdRestaurant},
                {"@idAssociation", unDon.IdAssociation}
            });
        }

        public List<Don> SelectAllDons()
        {
            string requete = "SELECT * FROM v_liste_dons;";
            return ExecuteQuery<Don>(requete, reader => new Don(
                reader.GetInt32(0),
                reader.GetDateTime(1),
                reader.GetInt32(2),
                reader.GetInt32(3)
            ));
        }

        /************** Gestion des Plats **************/
        public void InsertPlat(Plat unPlat)
        {
            string requete = "CALL insertPlat(@nom, @type, @quantite);";
            ExecuteNonQuery(requete, new Dictionary<string, object>
            {
                {"@nom", unPlat.Nom},
                {"@type", unPlat.Type},
                {"@quantite", unPlat.Quantite}
            });
        }

        public List<Plat> SelectAllPlats()
        {
            string requete = "SELECT * FROM v_liste_plats;";
            return ExecuteQuery<Plat>(requete, reader => new Plat(
                reader.GetInt32(0),
                reader.GetString(1),
                reader.GetString(2),
                reader.GetInt32(3)
            ));
        }

        /************** Gestion des relations Don - Plat (Composer) **************/
        public void InsertComposer(Composer unComposer)
        {
            string requete = "CALL insertComposer(@idDon, @idPlat, @quantite);";
            ExecuteNonQuery(requete, new Dictionary<string, object>
            {
                {"@idDon", unComposer.IdDon},
                {"@idPlat", unComposer.IdPlat},
                {"@quantite", unComposer.Quantite}
            });
        }

        /************** Méthodes Utilitaires **************/
        private void ExecuteNonQuery(string requete, Dictionary<string, object> parameters)
        {
            MySqlCommand uneCmde = null;
            try
            {
                this.maConnexion.Open();
                uneCmde = this.maConnexion.CreateCommand();
                uneCmde.CommandText = requete;
                foreach (var param in parameters)
                {
                    uneCmde.Parameters.AddWithValue(param.Key, param.Value);
                }
                uneCmde.ExecuteNonQuery();
                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur execution requete: " + requete);
            }
        }

        private List<T> ExecuteQuery<T>(string requete, Func<DbDataReader, T> map)
        {
            List<T> resultats = new List<T>();
            try
            {
                this.maConnexion.Open();
                MySqlCommand uneCmde = this.maConnexion.CreateCommand();
                uneCmde.CommandText = requete;
                DbDataReader unReader = uneCmde.ExecuteReader();
                while (unReader.Read())
                {
                    resultats.Add(map(unReader));
                }
                unReader.Close();
                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur execution requete: " + requete);
            }
            return resultats;
        }
    }
}
