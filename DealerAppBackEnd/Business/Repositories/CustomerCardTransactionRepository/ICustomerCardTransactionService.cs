using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.Concrete;
using Core.Utilities.Result.Abstract;
using Entities.Dtos;

namespace Business.Repositories.CustomerCardTransactionRepository
{
    public interface ICustomerCardTransactionService
    {
        Task<IResult> Add(CustomerCardTransaction customerCardTransaction);
        Task<IResult> Update(CustomerCardTransaction customerCardTransaction);
        Task<IResult> Delete(CustomerCardTransaction customerCardTransaction);
        Task<IDataResult<List<CustomerCardTransaction>>> GetList();
        Task<IDataResult<CustomerCardTransaction>> GetById(int id);
        Task<IResult> PayWithCard(CardPayDto cardPayDto);
    }
}
