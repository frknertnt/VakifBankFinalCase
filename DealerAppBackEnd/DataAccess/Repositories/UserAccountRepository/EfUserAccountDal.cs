using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess.EntityFramework;
using Entities.Concrete;
using DataAccess.Repositories.UserAccountRepository;
using DataAccess.Context.EntityFramework;

namespace DataAccess.Repositories.UserAccountRepository
{
    public class EfUserAccountDal : EfEntityRepositoryBase<UserAccount, DealerContextDb>, IUserAccountDal
    {
    }
}
