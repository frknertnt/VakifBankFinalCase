using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess.EntityFramework;
using Entities.Concrete;
using DataAccess.Repositories.CustomerCardRepository;
using DataAccess.Context.EntityFramework;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.Repositories.CustomerCardRepository
{
    public class EfCustomerCardDal : EfEntityRepositoryBase<CustomerCard, DealerContextDb>, ICustomerCardDal
    {
        public async Task<List<CustomerCard>> GetListByCustomerId(int customerId)
        {
            using (var context = new DealerContextDb())
            {
                var result = context.CustomerCards.Where(c => c.CustomerId == customerId);
                return await result.ToListAsync();
            }
        }
    }
}
