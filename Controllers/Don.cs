using System;
namespace FoodShare 
{
  public class Don
    {
        public int IdDon { get; set; }
        public int IdAssociation { get; set; }
        public string Montant { get; set; }
        public DateTime Date { get; set; }

        public Don(int idDon, int idAssociation, string montant, DateTime date)
        {
            IdDon = idDon;
            IdAssociation = idAssociation;
            Montant = montant;
            Date = date;
        }
    }
}
