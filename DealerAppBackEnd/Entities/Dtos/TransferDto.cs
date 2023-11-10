using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Dtos
{
    public class TransferDto
    {
        public int SenderAccountId { get; set; }
        public int ReceiverAccountId { get; set; }
        public int OrderId { get; set; }
        public decimal Amount { get; set; }
    }
}
