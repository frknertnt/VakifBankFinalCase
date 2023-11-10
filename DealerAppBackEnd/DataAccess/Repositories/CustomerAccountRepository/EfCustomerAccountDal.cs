using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess.EntityFramework;
using Entities.Concrete;
using DataAccess.Repositories.CustomerAccountRepository;
using DataAccess.Context.EntityFramework;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.Repositories.CustomerAccountRepository
{
    public class EfCustomerAccountDal : EfEntityRepositoryBase<CustomerAccount, DealerContextDb>, ICustomerAccountDal
    {
        public async Task<List<CustomerAccount>> GetListByCustomerId(int customerId)
        {
            using(var context = new DealerContextDb())
            {
                var result = context.CustomerAccounts.Where(c => c.CustomerId == customerId);
                return await result.ToListAsync();
            }
        }
    }
}
