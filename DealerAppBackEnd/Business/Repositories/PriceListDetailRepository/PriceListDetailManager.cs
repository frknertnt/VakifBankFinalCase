using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.PriceListDetailRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.PriceListDetailRepository.Validation;
using Business.Repositories.PriceListDetailRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.PriceListDetailRepository;
using Entities.Dtos;
using Core.Utilities.Business;
using Business.Utilities.CheckExist;

namespace Business.Repositories.PriceListDetailRepository
{
    public class PriceListDetailManager : IPriceListDetailService
    {
        private readonly IPriceListDetailDal _priceListDetailDal;
        private readonly ICheckExist _checkExist;

        public PriceListDetailManager(IPriceListDetailDal priceListDetailDal, ICheckExist checkExist)
        {
            _priceListDetailDal = priceListDetailDal;
            _checkExist = checkExist;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(PriceListDetailValidator))]
        [RemoveCacheAspect("IPriceListDetailService.Get")]
        public async Task<IResult> Add(PriceListDetail priceListDetail)
        {
            IResult result = BusinessRules.Run(
                await _checkExist.CheckIfProductExist(priceListDetail)
                );
            if (result != null)
                return result;

            await _priceListDetailDal.Add(priceListDetail);
            return new SuccessResult(PriceListDetailMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(PriceListDetailValidator))]
        [RemoveCacheAspect("IPriceListDetailService.Get")]

        public async Task<IResult> Update(PriceListDetail priceListDetail)
        {
            await _priceListDetailDal.Update(priceListDetail);
            return new SuccessResult(PriceListDetailMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("IPriceListDetailService.Get")]

        public async Task<IResult> Delete(PriceListDetail priceListDetail)
        {
            await _priceListDetailDal.Delete(priceListDetail);
            return new SuccessResult(PriceListDetailMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<PriceListDetail>>> GetList()
        {
            return new SuccessDataResult<List<PriceListDetail>>(await _priceListDetailDal.GetAll());
        }
        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<PriceListDetailDto>>> GetListDto(int priceListId)
        {
            return new SuccessDataResult<List<PriceListDetailDto>>(await _priceListDetailDal.GetListDto(priceListId));
        }

        [SecuredAspect()]
        public async Task<IDataResult<PriceListDetail>> GetById(int id)
        {
            return new SuccessDataResult<PriceListDetail>(await _priceListDetailDal.Get(p => p.Id == id));
        }

        public Task<List<PriceListDetail>> GetListByProductId(int productId)
        {
            return _priceListDetailDal.GetAll(p=>p.ProductId == productId);
        }
    }
}
