using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess.EntityFramework;
using Entities.Concrete;
using DataAccess.Repositories.CustomerCardTransactionRepository;
using DataAccess.Context.EntityFramework;
using Microsoft.EntityFrameworkCore;
using Entities.Dtos;

namespace DataAccess.Repositories.CustomerCardTransactionRepository
{
    public class EfCustomerCardTransactionDal : EfEntityRepositoryBase<CustomerCardTransaction, DealerContextDb>, ICustomerCardTransactionDal
    {
        public async Task PayWithCard(CardPayDto cardPayDto)
        {
            using (var context = new DealerContextDb())
            {
                var receiverAccount = await context.UserAccounts.SingleOrDefaultAsync(ua => ua.Id == cardPayDto.ReceiverAccountId);
                var customerCard = await context.CustomerCards.SingleOrDefaultAsync(c => c.Id == cardPayDto.CustomerCardId);
                var order = await context.Orders.SingleOrDefaultAsync(o => o.Id == cardPayDto.OrderId);

                if (customerCard == null)
                    throw new Exception("Kart bulunamadý");

                if (customerCard.Limit < cardPayDto.Amount)
                    throw new Exception("Yetersiz limit.");

                customerCard.Limit -= cardPayDto.Amount;
                receiverAccount.Balance += cardPayDto.Amount;

                var customerCardTransaction = new CustomerCardTransaction
                {
                    CustomerCardId = customerCard.Id,
                    UserAccountId = receiverAccount.Id,
                    Amount = cardPayDto.Amount,
                    Date = DateTime.Now
                };

                //Hesap Hareketleri olarak kayýt ekleme yok sadece ödeme iþlemi

                order.IsPaid = true;
                context.Orders.Update(order);
                context.CustomerCardTransactions.Add(customerCardTransaction);
                await context.SaveChangesAsync();
            }
        }
    }
}
