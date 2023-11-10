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
        /*Id ile m��teri tespiti yap�l�p m��teriye ait fiyat listesi bulucaz sonra
          bulunan fiyat listesinin iskonto oran�n� al�caz
         */
        Task<List<ProductListDto>> GetList();
        Task<List<ProductListDto>> GetProductList(int customerId);
    }
}
