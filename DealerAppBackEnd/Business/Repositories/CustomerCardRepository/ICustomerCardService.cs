using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.Concrete;
using Core.Utilities.Result.Abstract;

namespace Business.Repositories.CustomerCardRepository
{
    public interface ICustomerCardService
    {
        Task<IResult> Add(CustomerCard customerCard);
        Task<IResult> Update(CustomerCard customerCard);
        Task<IResult> Delete(CustomerCard customerCard);
        Task<IDataResult<List<CustomerCard>>> GetList();
        Task<IDataResult<List<CustomerCard>>> GetListByCustomerId(int customerId);
        Task<IDataResult<CustomerCard>> GetById(int id);
    }
}
