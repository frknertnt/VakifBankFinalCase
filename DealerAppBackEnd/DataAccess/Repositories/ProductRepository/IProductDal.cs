using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess;
using Entities.Concrete;
using Entities.Dtos;

namespace DataAccess.Repositories.ProductRepository
{
    public interface IProductDal : IEntityRepository<Product>
    {
        /*Id ile müþteri tespiti yapýlýp müþteriye ait fiyat listesi bulucaz sonra
          bulunan fiyat listesinin iskonto oranýný alýcaz
         */
        Task<List<ProductListDto>> GetList();
        Task<List<ProductListDto>> GetProductList(int customerId);
    }
}
