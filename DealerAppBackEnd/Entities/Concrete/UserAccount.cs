using Entities.Concrete.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Concrete
{
    public class UserAccount : BaseEntity
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string BankName { get; set; }
        public string IBAN { get; set; }
        public decimal Balance { get; set; }
    }
}
