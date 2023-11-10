using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.CustomerAccountRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.CustomerAccountRepository.Validation;
using Business.Repositories.CustomerAccountRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.CustomerAccountRepository;

namespace Business.Repositories.CustomerAccountRepository
{
    public class CustomerAccountManager : ICustomerAccountService
    {
        private readonly ICustomerAccountDal _customerAccountDal;

        public CustomerAccountManager(ICustomerAccountDal customerAccountDal)
        {
            _customerAccountDal = customerAccountDal;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(CustomerAccountValidator))]
        [RemoveCacheAspect("ICustomerAccountService.Get")]

        public async Task<IResult> Add(CustomerAccount customerAccount)
        {
            await _customerAccountDal.Add(customerAccount);
            return new SuccessResult(CustomerAccountMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(CustomerAccountValidator))]
        [RemoveCacheAspect("ICustomerAccountService.Get")]

        public async Task<IResult> Update(CustomerAccount customerAccount)
        {
            await _customerAccountDal.Update(customerAccount);
            return new SuccessResult(CustomerAccountMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("ICustomerAccountService.Get")]

        public async Task<IResult> Delete(CustomerAccount customerAccount)
        {
            await _customerAccountDal.Delete(customerAccount);
            return new SuccessResult(CustomerAccountMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<CustomerAccount>>> GetList()
        {
            return new SuccessDataResult<List<CustomerAccount>>(await _customerAccountDal.GetAll());
        }
        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<CustomerAccount>>> GetListByCustomerId(int customerId)
        {
            return new SuccessDataResult<List<CustomerAccount>>(await _customerAccountDal.GetListByCustomerId(customerId));
        }

        [SecuredAspect()]
        public async Task<IDataResult<CustomerAccount>> GetById(int id)
        {
            return new SuccessDataResult<CustomerAccount>(await _customerAccountDal.Get(p => p.Id == id));
        }

    }
}
