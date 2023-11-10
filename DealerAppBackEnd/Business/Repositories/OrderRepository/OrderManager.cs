using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.OrderRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.OrderRepository.Validation;
using Business.Repositories.OrderRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.OrderRepository;
using Entities.Dtos;
using Business.Repositories.OrderDetailRepository;
using Business.Repositories.BasketRepository;
using Castle.Core.Resource;
using Business.Utilities.CheckExist;
using Core.Utilities.Business;

namespace Business.Repositories.OrderRepository
{
    public class OrderManager : IOrderService
    {
        private readonly IOrderDal _orderDal;
        private readonly IOrderDetailService _orderDetailService;
        private readonly IBasketService _basketService;
        

        public OrderManager(IOrderDal orderDal, IBasketService basketService, IOrderDetailService orderDetailService)
        {
            _orderDal = orderDal;
            _basketService = basketService;
            _orderDetailService = orderDetailService;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(OrderValidator))]
        [RemoveCacheAspect("IOrderService.Get")]
        public async Task<IResult> Add(int customerId)
        {
            var baskets = await _basketService.GetListByCustomerId(customerId);
            string newOrderNumber = _orderDal.GetOrderNumber();

            Order order = new()
            {
                Id = 0,
                CustomerId = baskets.Data[0].CustomerId,
                Date = DateTime.Now,
                OrderNumber = newOrderNumber,
                Status = "Onay Bekliyor",
                IsPaid = false
            };

            await _orderDal.Add(order);
            foreach (var basket in baskets.Data)
            {
                OrderDetail orderDetail = new()
                {
                    Id = 0,
                    OrderId = order.Id,
                    Price = basket.Price,
                    ProductId = basket.ProductId,
                    Quantity = basket.Quantity,
                };
                await _orderDetailService.Add(orderDetail);
                Basket basketEntity = new()
                {
                    Id = basket.Id,
                    CustomerId = basket.CustomerId,
                    Price = basket.Price,
                    Quantity = basket.Quantity,
                    ProductId = basket.ProductId,
                };
                await _basketService.Delete(basketEntity);
            }
            return new SuccessResult(OrderMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(OrderValidator))]
        [RemoveCacheAspect("IOrderService.Get")]

        public async Task<IResult> Update(Order order)
        {
            await _orderDal.Update(order);
            return new SuccessResult(OrderMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("IOrderService.Get")]

        public async Task<IResult> Delete(Order order)
        {
            var details = await _orderDetailService.GetList(order.Id);

            foreach (var detail in details.Data)//data result d�nd��� i�in .Data
            {
                await _orderDetailService.Delete(detail);
            }
            await _orderDal.Delete(order);
            return new SuccessResult(OrderMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<Order>>> GetList()
        {
            return new SuccessDataResult<List<Order>>(await _orderDal.GetAll());
        } 
        
        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<Order>>> GetListByCustomerId(int customerId)
        {
            return new SuccessDataResult<List<Order>>(await _orderDal.GetAll(p=>p.CustomerId == customerId));
        }

        [SecuredAspect()]
        public async Task<IDataResult<Order>> GetById(int id)
        {
            return new SuccessDataResult<Order>(await _orderDal.Get(p => p.Id == id));
        }

        public async Task<IDataResult<List<OrderDto>>> GetListDto()
        {
            return new SuccessDataResult<List<OrderDto>>(await _orderDal.GetListDto()); 
        }

        public async Task<IDataResult<List<OrderDto>>> GetListByCustomerIdDto(int customerId)
        {
            return new SuccessDataResult<List<OrderDto>>(await _orderDal.GetListByCustomerIdDto(customerId));
        }

        public async Task<IDataResult<OrderDto>> GetByIdDto(int id)
        {
            return new SuccessDataResult<OrderDto>(await _orderDal.GetByIdDto(id));
        }
    }
}
