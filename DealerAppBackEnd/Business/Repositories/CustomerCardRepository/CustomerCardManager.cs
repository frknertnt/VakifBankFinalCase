using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.CustomerCardRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.CustomerCardRepository.Validation;
using Business.Repositories.CustomerCardRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.CustomerCardRepository;

namespace Business.Repositories.CustomerCardRepository
{
    public class CustomerCardManager : ICustomerCardService
    {
        private readonly ICustomerCardDal _customerCardDal;

        public CustomerCardManager(ICustomerCardDal customerCardDal)
        {
            _customerCardDal = customerCardDal;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(CustomerCardValidator))]
        [RemoveCacheAspect("ICustomerCardService.Get")]

        public async Task<IResult> Add(CustomerCard customerCard)
        {
            await _customerCardDal.Add(customerCard);
            return new SuccessResult(CustomerCardMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(CustomerCardValidator))]
        [RemoveCacheAspect("ICustomerCardService.Get")]

        public async Task<IResult> Update(CustomerCard customerCard)
        {
            await _customerCardDal.Update(customerCard);
            return new SuccessResult(CustomerCardMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("ICustomerCardService.Get")]

        public async Task<IResult> Delete(CustomerCard customerCard)
        {
            await _customerCardDal.Delete(customerCard);
            return new SuccessResult(CustomerCardMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<CustomerCard>>> GetList()
        {
            return new SuccessDataResult<List<CustomerCard>>(await _customerCardDal.GetAll());
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<CustomerCard>>> GetListByCustomerId(int customerId)
        {
            return new SuccessDataResult<List<CustomerCard>>(await _customerCardDal.GetListByCustomerId(customerId));
        }

        [SecuredAspect()]
        public async Task<IDataResult<CustomerCard>> GetById(int id)
        {
            return new SuccessDataResult<CustomerCard>(await _customerCardDal.Get(p => p.Id == id));
        }

    }
}
