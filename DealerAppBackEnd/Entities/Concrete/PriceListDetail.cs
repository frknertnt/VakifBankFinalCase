using Entities.Concrete.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Concrete
{
    public class PriceListDetail : BaseEntity
    {
        public int Id { get; set; }
        public int PriceListId { get; set; }
        public int ProductId { get; set; }
        public decimal Price { get; set; }
    }
}
