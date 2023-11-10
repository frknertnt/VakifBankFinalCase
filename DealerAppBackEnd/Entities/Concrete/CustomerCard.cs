using Entities.Concrete.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Concrete
{
    public class CustomerCard : BaseEntity
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public string CardHolder { get; set; }
        public string CardNumber { get; set; }
        public decimal Limit { get; set; }
        public string Cvv { get; set; }
    }
}
