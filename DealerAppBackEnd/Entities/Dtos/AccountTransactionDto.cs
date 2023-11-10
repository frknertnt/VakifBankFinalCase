using Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Dtos
{
    public class AccountTransactionDto : AccountTransaction
    {
        public string SenderName { get; set; }
        public string ReceiverName { get; set; }
        public string SenderIban { get; set; }
        public string ReceiverIban { get; set; }
    }
}
