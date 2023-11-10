using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.Concrete;
using Core.Utilities.Result.Abstract;
using Entities.Dtos;

namespace Business.Repositories.AccountTransactionRepository
{
    public interface IAccountTransactionService
    {
        Task<IResult> Add(AccountTransaction accountTransaction);
        Task<IResult> Update(AccountTransaction accountTransaction);
        Task<IResult> Delete(AccountTransaction accountTransaction);
        Task<IDataResult<List<AccountTransaction>>> GetList();
        Task<IDataResult<List<AccountTransactionDto>>> GetAllDto();
        Task<IDataResult<AccountTransaction>> GetById(int id);
        Task<IResult> Transfer(int senderAccountId, int receiverAccountId, decimal amount, int orderId);
        
    }
}
