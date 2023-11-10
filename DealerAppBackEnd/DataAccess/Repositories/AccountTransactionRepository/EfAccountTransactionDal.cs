using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess.EntityFramework;
using Entities.Concrete;
using DataAccess.Repositories.AccountTransactionRepository;
using DataAccess.Context.EntityFramework;
using Entities.Dtos;
using Castle.Core.Resource;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.Repositories.AccountTransactionRepository
{
    public class EfAccountTransactionDal : EfEntityRepositoryBase<AccountTransaction, DealerContextDb>, IAccountTransactionDal
    {
        public async Task<List<AccountTransactionDto>> GetAllDto()
        {
            using (var context = new DealerContextDb())
            {
                var result = from at in context.AccountTransactions
                             join ca in context.CustomerAccounts on at.CustomerAccountId equals ca.Id
                             join ua in context.UserAccounts on at.UserAccountId equals ua.Id
                             join c in context.Customers on ca.CustomerId equals c.Id
                             join u in context.Users on ua.UserId equals u.Id
                             select new AccountTransactionDto
                             {
                                 Id = at.Id,
                                 Amount = at.Amount,
                                 Date = at.Date,
                                 CustomerAccountId = at.CustomerAccountId,
                                 UserAccountId = at.UserAccountId,
                                 ReceiverIban = ua.IBAN,
                                 SenderIban = ca.IBAN,
                                 ReceiverName = u.Name,
                                 SenderName = c.Name
                             };

                return await result.ToListAsync();
            }
        }


        public async Task Transfer(int senderAccountId, int receiverAccountId, decimal amount, int orderId)
        {
            using (var context = new DealerContextDb())
            {
                var senderAccount = await context.CustomerAccounts.SingleOrDefaultAsync(ca => ca.Id == senderAccountId);
                var receiverAccount = await context.UserAccounts.SingleOrDefaultAsync(ua => ua.Id == receiverAccountId);
                var order = await context.Orders.SingleOrDefaultAsync(o => o.Id == orderId);

                if (senderAccount.Balance < amount)
                    throw new Exception("Yetersiz bakiye.");


                senderAccount.Balance -= amount;
                receiverAccount.Balance += amount;


                var accountTransaction = new AccountTransaction
                {
                    CustomerAccountId = senderAccount.Id,
                    UserAccountId = receiverAccount.Id,
                    Amount = amount,
                    Date = DateTime.Now
                };

                order.IsPaid = true;
                context.Orders.Update(order);
                context.AccountTransactions.Add(accountTransaction);


                await context.SaveChangesAsync();
            }
        }


    }
}
