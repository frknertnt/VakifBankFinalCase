using Core.Utilities.Result.Abstract;
using Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Utilities.CheckExist
{
    public interface ICheckExist
    {
        Task<IResult> CheckIfEmailExists<T>(Func<string, Task<T>> getByEmail, string email) where T : class;
        IResult CheckIfImageSizeIsLessThanOneMb(long imgSize);
        IResult CheckIfImageExtesionsAllow(string fileName);
        Task<IResult> CheckIfProductExistToBaskets(int productId);
        Task<IResult> CheckIfProductExistToOrderDetails(int productId);
        Task<IResult> CheckIfProductExist(PriceListDetail priceListDetail);
        Task<IResult> CheckIfCustomerOrderExist(int customerId);
        //Task<IResult> CheckIfProductStockEnough(int productId,decimal quantity);
    }
}
