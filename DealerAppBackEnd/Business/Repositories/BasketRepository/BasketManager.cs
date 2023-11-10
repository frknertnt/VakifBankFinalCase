using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.BasketRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.BasketRepository.Validation;
using Business.Repositories.BasketRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.BasketRepository;
using Entities.Dtos;
using Business.Utilities.CheckExist;
using Castle.Core.Resource;
using Core.Utilities.Business;
using DataAccess.Context.EntityFramework;

namespace Business.Repositories.BasketRepository
{
    //CRUD Process
    public class BasketManager : IBasketService
    {
        private readonly IBasketDal _basketDal;   

        public BasketManager(IBasketDal basketDal)
        {
            _basketDal = basketDal;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(BasketValidator))]
        [RemoveCacheAspect("IBasketService.Get")]
        public async Task<IResult> Add(Basket basket)
        {
            using (var context = new DealerContextDb())//check exist servisi çaðrýldýðýnda baðýmlýlýk hatasý veriyor o nedenle direkt context nesnesi kullanýldý
            {
                var result = context.Products.Find(basket.ProductId);
                if (result.Stock < basket.Quantity)
                    return new ErrorResult("Stok sayýsý yetersiz");

                var existingBasket = context.Baskets
                    .FirstOrDefault(b => b.ProductId == basket.ProductId && b.CustomerId == basket.CustomerId);

                // Eðer basket zaten varsa, miktarý güncelle
                if (existingBasket != null)
                {
                    existingBasket.Quantity += basket.Quantity;
                    existingBasket.Price = basket.Price;
                    context.Baskets.Update(existingBasket);
                    await context.SaveChangesAsync();
                    return new SuccessResult(BasketMessages.Added);
                }
                else
                {
                    await _basketDal.Add(basket);
                    return new SuccessResult(BasketMessages.Added);
                }
            }
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(BasketValidator))]
        [RemoveCacheAspect("IBasketService.Get")]
        public async Task<IResult> Update(Basket basket)
        {
            await _basketDal.Update(basket);
            return new SuccessResult(BasketMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("IBasketService.Get")]
        public async Task<IResult> Delete(Basket basket)
        {
            await _basketDal.Delete(basket);
            return new SuccessResult(BasketMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<Basket>>> GetList()
        {
            return new SuccessDataResult<List<Basket>>(await _basketDal.GetAll());
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<BasketListDto>>> GetListByCustomerId(int customerId)
        {
            return new SuccessDataResult<List<BasketListDto>>(await _basketDal.GetListByCustomerId(customerId));
        }

        [SecuredAspect()]
        public async Task<IDataResult<Basket>> GetById(int id)
        {
            return new SuccessDataResult<Basket>(await _basketDal.Get(p => p.Id == id));
        }

        public async Task<List<Basket>> GetListByProductId(int productId)
        {
            return await _basketDal.GetAll(p=>p.ProductId == productId);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(BasketValidator))]
        [RemoveCacheAspect("IBasketService.Get")]
        public async Task<IResult> UpdateQuantity(int basketId, bool isIncrease)
        {
            using (var context = new DealerContextDb())
            {
                var result = context.Baskets.Find(basketId);
                var product = context.Products.Find(result.ProductId);
                if (isIncrease && result.Quantity < product.Stock)
                {
                    result.Quantity += 1;
                    await _basketDal.Update(result);
                }
                else if (isIncrease == false)
                {
                    result.Quantity -= 1;
                    await _basketDal.Update(result);
                }
                else
                {
                    return new ErrorResult("Stok sayýsý yetersiz");
                }
            };
            return new SuccessResult(BasketMessages.Updated);
        }
    }
}
