using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess.EntityFramework;
using Entities.Concrete;
using DataAccess.Repositories.CustomerRepository;
using DataAccess.Context.EntityFramework;
using Entities.Dtos;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.Repositories.CustomerRepository
{
    public class EfCustomerDal : EfEntityRepositoryBase<Customer, DealerContextDb>, ICustomerDal
    {
        public async Task<List<CustomerDto>> GetListDto()
        {
            using(var context = new DealerContextDb())
            {
                var result = from customer in context.Customers
                             select new CustomerDto
                             {
                                 Id = customer.Id,
                                 Email = customer.Email,
                                 Name = customer.Name,
                                 PasswordHash = customer.PasswordHash,
                                 PasswordSalt = customer.PasswordSalt,
                                 Discount =
                                 (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id) != null
                                 ? context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id).Select(s => s.Discount).FirstOrDefault()
                                : 0),
                                 PriceListId =
                                 (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id) != null
                                ? context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id).Select(s => s.PriceListId).FirstOrDefault()
                                : 0),
                                 PriceListName =
                                 (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id) != null
                                 ? context.PriceLists.Where(p => p.Id == (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id).Select(s => s.PriceListId).FirstOrDefault())).Select(s => s.Name).FirstOrDefault()
                                 : "")
                             };
                return await result.OrderBy(p => p.Name).ToListAsync();
            }
        }

        public async Task<CustomerDto> GetDto(int id)
        {
            using (var context = new DealerContextDb())
            {
                var result = from customer in context.Customers.Where(p => p.Id == id)
                             select new CustomerDto
                             {
                                 Id = customer.Id,
                                 Email = customer.Email,
                                 Name = customer.Name,
                                 PasswordHash = customer.PasswordHash,
                                 PasswordSalt = customer.PasswordSalt,
                                 Discount =
                                 (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id) != null
                                 ? context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id).Select(s => s.Discount).FirstOrDefault()
                                : 0),
                                 PriceListId =
                                 (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id) != null
                                ? context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id).Select(s => s.PriceListId).FirstOrDefault()
                                : 0),
                                 PriceListName =
                                 (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id) != null
                                 ? context.PriceLists.Where(p => p.Id == (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id).Select(s => s.PriceListId).FirstOrDefault())).Select(s => s.Name).FirstOrDefault()
                                 : "")
                             };
                return await result.FirstOrDefaultAsync();
            }
        }
    }
}
