using System;
using System.Collections.Generic;

namespace FoodShare
{
    public class Controleur
    {
        private static Modele unModele = new Modele("localhost", "bddfoodshare", "root", "root");

        // Gestion des Utilisateurs
        public static void InsertUser(User unUser)
        {
            unModele.InsertUser(unUser);
        }

        public static void UpdateUser(User unUser)
        {
            unModele.UpdateUser(unUser);
        }

        public static void DeleteUser(int idUser)
        {
            unModele.DeleteUser(idUser);
        }

        public static User SelectWhereUser(int idUser)
        {
            return unModele.SelectWhereUser(idUser);
        }

        public static List<User> SelectAllUsers()
        {
            return unModele.SelectAllUsers();
        }

        public static List<User> SelectLikeUsers(string filtre)
        {
            return unModele.SelectLikeUsers(filtre);
        }

        // Gestion des Associations
        public static void InsertAssociation(Association uneAssociation)
        {
            unModele.InsertAssociation(uneAssociation);
        }

        public static void UpdateAssociation(Association uneAssociation)
        {
            unModele.UpdateAssociation(uneAssociation);
        }

        public static void DeleteAssociation(int idAssociation)
        {
            unModele.DeleteAssociation(idAssociation);
        }

        public static Association SelectWhereAssociation(int idAssociation)
        {
            return unModele.SelectWhereAssociation(idAssociation);
        }

        public static List<Association> SelectAllAssociations()
        {
            return unModele.SelectAllAssociations();
        }

        // Gestion des Restaurants
        public static void InsertRestaurant(Restaurant unRestaurant)
        {
            unModele.InsertRestaurant(unRestaurant);
        }

        public static void UpdateRestaurant(Restaurant unRestaurant)
        {
            unModele.UpdateRestaurant(unRestaurant);
        }

        public static void DeleteRestaurant(int idRestaurant)
        {
            unModele.DeleteRestaurant(idRestaurant);
        }

        public static Restaurant SelectWhereRestaurant(int idRestaurant)
        {
            return unModele.SelectWhereRestaurant(idRestaurant);
        }

        public static List<Restaurant> SelectAllRestaurants()
        {
            return unModele.SelectAllRestaurants();
        }

        // Gestion des Dons
        public static void InsertDon(Don unDon)
        {
            unModele.InsertDon(unDon);
        }

        public static void UpdateDon(Don unDon)
        {
            unModele.UpdateDon(unDon);
        }

        public static void DeleteDon(int idDon)
        {
            unModele.DeleteDon(idDon);
        }

        public static Don SelectWhereDon(int idDon)
        {
            return unModele.SelectWhereDon(idDon);
        }

        public static List<Don> SelectAllDons()
        {
            return unModele.SelectAllDons();
        }

        // Gestion des Plats
        public static void InsertPlat(Plat unPlat)
        {
            unModele.InsertPlat(unPlat);
        }

        public static void UpdatePlat(Plat unPlat)
        {
            unModele.UpdatePlat(unPlat);
        }

        public static void DeletePlat(int idPlat)
        {
            unModele.DeletePlat(idPlat);
        }

        public static Plat SelectWherePlat(int idPlat)
        {
            return unModele.SelectWherePlat(idPlat);
        }

        public static List<Plat> SelectAllPlats()
        {
            return unModele.SelectAllPlats();
        }

        // Gestion des relations entre Don et Plat (Composer)
        public static void InsertComposer(Composer unComposer)
        {
            unModele.InsertComposer(unComposer);
        }

        public static void DeleteComposer(int idDon, int idPlat)
        {
            unModele.DeleteComposer(idDon, idPlat);
        }

        public static List<Plat> GetPlatsByDonId(int idDon)
        {
            return unModele.GetPlatsByDonId(idDon);
        }
    }
}
