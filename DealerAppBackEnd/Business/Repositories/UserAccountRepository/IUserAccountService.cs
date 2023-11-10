using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.Concrete;
using Core.Utilities.Result.Abstract;

namespace Business.Repositories.UserAccountRepository
{
    public interface IUserAccountService
    {
        Task<IResult> Add(UserAccount userAccount);
        Task<IResult> Update(UserAccount userAccount);
        Task<IResult> Delete(UserAccount userAccount);
        Task<IDataResult<List<UserAccount>>> GetList();
        Task<IDataResult<UserAccount>> GetById(int id);
    }
}
