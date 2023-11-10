using Business.Repositories.BasketRepository;
using Business.Repositories.OrderDetailRepository;
using Business.Repositories.OrderRepository;
using Business.Repositories.ProductRepository;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Context.EntityFramework;
using DataAccess.Repositories.PriceListDetailRepository;
using Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Utilities.CheckExist
{
    public class CheckExistManager : ICheckExist
    {
        private readonly IBasketService _basketService;
        private readonly IOrderDetailService _orderDetailService;
        private readonly IPriceListDetailDal _priceListDetailDal;
        private readonly IOrderService _orderService;
        

        public CheckExistManager(IBasketService basketService, IOrderDetailService orderDetailService, IPriceListDetailDal priceListDetailDal, IOrderService orderService)
        {
            _basketService = basketService;
            _orderDetailService = orderDetailService;
            _priceListDetailDal = priceListDetailDal;
            _orderService = orderService;
        }

        public async Task<IResult> CheckIfCustomerOrderExist(int customerId)
        {
            var result = await _orderService.GetListByCustomerId(customerId);
            if (result.Data.Count > 0)
                return new ErrorResult("Siparişi bulunan müşteri silinemez");

            return new SuccessResult();
        }

        public async Task<IResult> CheckIfEmailExists<T>(Func<string, Task<T>> getByEmail, string email) where T : class
        {
            var list = await getByEmail(email);
            if (list != null)
                return new ErrorResult("Bu email başkası tarafından kullanılıyor");
            return new SuccessResult();
        }

        public IResult CheckIfImageExtesionsAllow(string fileName)
        {
            var ext = fileName.Substring(fileName.LastIndexOf('.'));
            var extension = ext.ToLower();
            List<string> AllowFileExtensions = new List<string> { ".jpg", ".jpeg", ".gif", ".png" };
            if (!AllowFileExtensions.Contains(extension))
                return new ErrorResult("Eklediğiniz fotoğraf .jpg, .jpeg, .gif, .png türlerinden biri olmalıdır!");
            return new SuccessResult();
        }

        public IResult CheckIfImageSizeIsLessThanOneMb(long imgSize)
        {
            decimal imgMbSize = Convert.ToDecimal(imgSize * 0.000001);
            if (imgMbSize > 5)
                return new ErrorResult("Yüklediğiniz resmi boyutu en fazla 5 mb olmalıdır");
            return new SuccessResult();
        }

        public async Task<IResult> CheckIfProductExist(PriceListDetail priceListDetail)
        {
            var result = await _priceListDetailDal.Get(p => p.PriceListId == priceListDetail.PriceListId && p.ProductId == priceListDetail.ProductId);
            if (result != null)
                return new ErrorResult("Ürün daha önce fiyat listesine eklenmiş");
            return new SuccessResult();
        }

        public async Task<IResult> CheckIfProductExistToBaskets(int productId)
        {
            var result = await _basketService.GetListByProductId(productId);
            if(result.Count() > 0 )
                return new ErrorResult("Sepette bulunan ürün silinemez");

            return new SuccessResult();
        }

        public async Task<IResult> CheckIfProductExistToOrderDetails(int productId)
        {
            var result = await _orderDetailService.GetListByProductId(productId);
            if (result.Count() > 0)
                return new ErrorResult("Siparişte olan ürün silinemez");

            return new SuccessResult();
        }     
    }
}
