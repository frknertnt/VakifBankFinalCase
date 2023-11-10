using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.Concrete;
using Core.Utilities.Result.Abstract;

namespace Business.Repositories.CustomerAccountRepository
{
    public interface ICustomerAccountService
    {
        Task<IResult> Add(CustomerAccount customerAccount);
        Task<IResult> Update(CustomerAccount customerAccount);
        Task<IResult> Delete(CustomerAccount customerAccount);
        Task<IDataResult<List<CustomerAccount>>> GetList();
        Task<IDataResult<List<CustomerAccount>>> GetListByCustomerId(int customerId);
        Task<IDataResult<CustomerAccount>> GetById(int id);
    }
}
