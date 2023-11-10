using Entities.Concrete.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Concrete
{
    public class CustomerAccount : BaseEntity
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public string IBAN { get; set; }
        public string BankName { get; set; }
        public decimal Balance { get; set; }
    }
}
