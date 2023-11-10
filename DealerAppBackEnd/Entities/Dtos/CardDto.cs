using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Dtos
{
    public class CardDto
    {
        public int CustomerCardId { get; set; }
        public int ReceiverAccountId { get; set; }
        public decimal Amount { get; set; }
        public int OrderId { get; set; }
    }
}
