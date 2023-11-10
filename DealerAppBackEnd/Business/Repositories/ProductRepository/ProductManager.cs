using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.ProductRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.ProductRepository.Validation;
using Business.Repositories.ProductRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.ProductRepository;
using Entities.Dtos;
using Business.Repositories.ProductImageRepository;
using Business.Repositories.PriceListDetailRepository;
using Business.Repositories.BasketRepository;
using Business.Repositories.OrderDetailRepository;
using Business.Utilities.CheckExist;
using Core.Utilities.Business;

namespace Business.Repositories.ProductRepository
{
    public class ProductManager : IProductService
    {
        private readonly ICheckExist _checkExist;
        private readonly IProductDal _productDal;
        private readonly IProductImageService _productImageService;//delete iþlemi için
        private readonly IPriceListDetailService _priceListDetailService;

        public ProductManager(IProductDal productDal, IProductImageService productImageService, IPriceListDetailService priceListDetailService, ICheckExist checkExist)
        {
            _productDal = productDal;
            _productImageService = productImageService;
            _priceListDetailService = priceListDetailService;
            _checkExist = checkExist;
        }

        [SecuredAspect("admin,product.add")]//yetkilendirme 
        [ValidationAspect(typeof(ProductValidator))]
        [RemoveCacheAspect("IProductService.Get")]

        public async Task<IResult> Add(Product product)
        {
            await _productDal.Add(product);
            return new SuccessResult(ProductMessages.Added);
        }

        [SecuredAspect("admin,product.update")]
        [ValidationAspect(typeof(ProductValidator))]
        [RemoveCacheAspect("IProductService.Get")]

        public async Task<IResult> Update(Product product)
        {
            await _productDal.Update(product);
            return new SuccessResult(ProductMessages.Updated);
        }

        [SecuredAspect("admin,product.delete")]
        [RemoveCacheAspect("IProductService.Get")]

        public async Task<IResult> Delete(Product product)
        {
            IResult result = BusinessRules.Run(
                await _checkExist.CheckIfProductExistToBaskets(product.Id),
                await _checkExist.CheckIfProductExistToOrderDetails(product.Id)
                );

            if (result != null)
                return result;

            var images = await _productImageService.GetListByProductId(product.Id);
            foreach (var image in images.Data)
            {
                await _productImageService.Delete(image);
            }

            var priceListProducts = await _priceListDetailService.GetListByProductId(product.Id);
            foreach (var price in priceListProducts)
            {
                await _priceListDetailService.Delete(price);
            }

            await _productDal.Delete(product);
            return new SuccessResult(ProductMessages.Deleted);
        }

        [SecuredAspect("admin,product.get")]
        [RemoveCacheAspect("IProductService.Get")]
        [PerformanceAspect()]
        public async Task<IDataResult<List<ProductListDto>>> GetList()
        {
            return new SuccessDataResult<List<ProductListDto>>(await _productDal.GetList());
        }

        [SecuredAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<ProductListDto>>> GetProductList(int customerId)
        {
            //Müþteriye özel fiyat
            return new SuccessDataResult<List<ProductListDto>>(await _productDal.GetProductList(customerId));
        }

        [SecuredAspect("admin,product.get")]
        public async Task<IDataResult<Product>> GetById(int id)
        {
            return new SuccessDataResult<Product>(await _productDal.Get(p => p.Id == id));
        }


    }
}
