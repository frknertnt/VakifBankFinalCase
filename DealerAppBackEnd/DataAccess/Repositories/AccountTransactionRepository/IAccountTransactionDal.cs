using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess;
using Entities.Concrete;
using Entities.Dtos;

namespace DataAccess.Repositories.AccountTransactionRepository
{
    public interface IAccountTransactionDal : IEntityRepository<AccountTransaction>
    {
        Task<List<AccountTransactionDto>> GetAllDto();
        Task Transfer(int senderAccountId, int receiverAccountId, decimal amount, int orderId);
    }
}
