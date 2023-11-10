using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess.EntityFramework;
using Entities.Concrete;
using DataAccess.Repositories.OrderRepository;
using DataAccess.Context.EntityFramework;
using Entities.Dtos;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.Repositories.OrderRepository
{
    public class EfOrderDal : EfEntityRepositoryBase<Order, DealerContextDb>, IOrderDal
    {
        public async Task<OrderDto> GetByIdDto(int id)
        {
            using (var context = new DealerContextDb())
            {
                var result = from order in context.Orders.Where(p => p.Id == id)
                             join customer in context.Customers on order.CustomerId equals customer.Id
                             select new OrderDto
                             {
                                 Id = order.Id,
                                 CustomerId = order.CustomerId,
                                 CustomerName = customer.Name,
                                 Date = order.Date,
                                 OrderNumber = order.OrderNumber,
                                 Status = order.Status,
                                 Quantity = context.OrderDetails.Where(p => p.OrderId == order.Id).Sum(s => s.Quantity),
                                 Total = context.OrderDetails.Where(p => p.OrderId == order.Id).Sum(s => s.Price * s.Quantity)
                             };
                return await result.FirstOrDefaultAsync();
            }
        }

        public async Task<List<OrderDto>> GetListByCustomerIdDto(int customerId)
        {
            using (var context = new DealerContextDb())
            {
                var result = from order in context.Orders.Where(p => p.CustomerId == customerId)
                             join customer in context.Customers on order.CustomerId equals customer.Id
                             select new OrderDto
                             {
                                 Id = order.Id,
                                 CustomerId = order.CustomerId,
                                 CustomerName = customer.Name,
                                 Date = order.Date,
                                 OrderNumber = order.OrderNumber,
                                 Status = order.Status,
                                 Quantity = context.OrderDetails.Where(p => p.OrderId == order.Id).Sum(s => s.Quantity),
                                 Total = context.OrderDetails.Where(p => p.OrderId == order.Id).Sum(s => s.Price * s.Quantity),
                                 IsPaid = order.IsPaid
                             };
                return await result.OrderByDescending(p => p.Id).ToListAsync();
            }
        }

        public async Task<List<OrderDto>> GetListDto()
        {
            using (var context = new DealerContextDb())
            {
                var result = from order in context.Orders
                             join customer in context.Customers on order.CustomerId equals customer.Id
                             select new OrderDto
                             {
                                 Id = order.Id,
                                 CustomerId = customer.Id,
                                 CustomerName = customer.Name,
                                 Date = order.Date,
                                 OrderNumber = order.OrderNumber,
                                 Status = order.Status,
                                 Quantity = context.OrderDetails.Where(p => p.OrderId == order.Id).Sum(s => s.Quantity),
                                 Total = context.OrderDetails.Where(p => p.OrderId == order.Id).Sum(s => s.Price * s.Quantity),
                                 IsPaid = order.IsPaid
                             };
                return await result.OrderByDescending(p => p.Id).ToListAsync();
            }
        }

        public string GetOrderNumber()
        {
            using (var context = new DealerContextDb())
            {
                //En son sipariþ numarasýný bulup ona 1 ekleyeceðiz
                var findLastOrder = context.Orders.OrderBy(p => p.Id).LastOrDefault();

                if (findLastOrder is null)
                    return "SN00000000000001";

                string findLastOrderNumber = findLastOrder.OrderNumber;
                findLastOrderNumber = findLastOrderNumber.Substring(2, 14);
                int orderNumber = Convert.ToInt16(findLastOrderNumber);
                orderNumber++;
                string newOrderNumber = orderNumber.ToString();

                for (int i = 0; newOrderNumber.Length < 14; i++)
                {
                    newOrderNumber = "0" + newOrderNumber;
                }

                newOrderNumber = "SN" + newOrderNumber;
                return newOrderNumber;
            }
        }


    }
}
