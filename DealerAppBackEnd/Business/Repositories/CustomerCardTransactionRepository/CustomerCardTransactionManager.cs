using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.CustomerCardTransactionRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.CustomerCardTransactionRepository.Validation;
using Business.Repositories.CustomerCardTransactionRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.CustomerCardTransactionRepository;
using Entities.Dtos;
using Business.Repositories.AccountTransactionRepository.Constants;
using MailKit.Search;

namespace Business.Repositories.CustomerCardTransactionRepository
{
    public class CustomerCardTransactionManager : ICustomerCardTransactionService
    {
        private readonly ICustomerCardTransactionDal _customerCardTransactionDal;

        public CustomerCardTransactionManager(ICustomerCardTransactionDal customerCardTransactionDal)
        {
            _customerCardTransactionDal = customerCardTransactionDal;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(CustomerCardTransactionValidator))]
        [RemoveCacheAspect("ICustomerCardTransactionService.Get")]

        public async Task<IResult> Add(CustomerCardTransaction customerCardTransaction)
        {
            await _customerCardTransactionDal.Add(customerCardTransaction);
            return new SuccessResult(CustomerCardTransactionMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(CustomerCardTransactionValidator))]
        [RemoveCacheAspect("ICustomerCardTransactionService.Get")]

        public async Task<IResult> Update(CustomerCardTransaction customerCardTransaction)
        {
            await _customerCardTransactionDal.Update(customerCardTransaction);
            return new SuccessResult(CustomerCardTransactionMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("ICustomerCardTransactionService.Get")]

        public async Task<IResult> Delete(CustomerCardTransaction customerCardTransaction)
        {
            await _customerCardTransactionDal.Delete(customerCardTransaction);
            return new SuccessResult(CustomerCardTransactionMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<CustomerCardTransaction>>> GetList()
        {
            return new SuccessDataResult<List<CustomerCardTransaction>>(await _customerCardTransactionDal.GetAll());
        }

        [SecuredAspect()]
        public async Task<IDataResult<CustomerCardTransaction>> GetById(int id)
        {
            return new SuccessDataResult<CustomerCardTransaction>(await _customerCardTransactionDal.Get(p => p.Id == id));
        }

        public async Task<IResult> PayWithCard(CardPayDto cardPayDto)
        {
            await _customerCardTransactionDal.PayWithCard(cardPayDto);
            return new SuccessResult(AccountTransactionMessages.Added);
        }
    }
}
