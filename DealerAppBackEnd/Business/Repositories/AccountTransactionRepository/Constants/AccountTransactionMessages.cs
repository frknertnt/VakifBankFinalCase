using System;
using System.Collections.Generic;
using FluentValidation;
using System.Text;
using System.Threading.Tasks;

namespace Business.Repositories.AccountTransactionRepository.Constants
{
    public class AccountTransactionMessages
    {
        public static string Added = "Transfer Başarılı";
        public static string Updated = "Güncelleme işlemi başarılı";
        public static string Deleted = "Silme işlemi başarılı";
        public static string PayCard = "Ödeme başarılı";
    }
}
