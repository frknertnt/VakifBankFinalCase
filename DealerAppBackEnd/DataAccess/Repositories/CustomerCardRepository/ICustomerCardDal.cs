using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess;
using Entities.Concrete;

namespace DataAccess.Repositories.CustomerCardRepository
{
    public interface ICustomerCardDal : IEntityRepository<CustomerCard>
    {
        Task<List<CustomerCard>> GetListByCustomerId(int customerId);
    }
}
