using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.AccountTransactionRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.AccountTransactionRepository.Validation;
using Business.Repositories.AccountTransactionRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.AccountTransactionRepository;
using Entities.Dtos;

namespace Business.Repositories.AccountTransactionRepository
{
    public class AccountTransactionManager : IAccountTransactionService
    {
        private readonly IAccountTransactionDal _accountTransactionDal;

        public AccountTransactionManager(IAccountTransactionDal accountTransactionDal)
        {
            _accountTransactionDal = accountTransactionDal;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(AccountTransactionValidator))]
        [RemoveCacheAspect("IAccountTransactionService.Get")]

        public async Task<IResult> Add(AccountTransaction accountTransaction)
        {
            await _accountTransactionDal.Add(accountTransaction);
            return new SuccessResult(AccountTransactionMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(AccountTransactionValidator))]
        [RemoveCacheAspect("IAccountTransactionService.Get")]

        public async Task<IResult> Update(AccountTransaction accountTransaction)
        {
            await _accountTransactionDal.Update(accountTransaction);
            return new SuccessResult(AccountTransactionMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("IAccountTransactionService.Get")]

        public async Task<IResult> Delete(AccountTransaction accountTransaction)
        {
            await _accountTransactionDal.Delete(accountTransaction);
            return new SuccessResult(AccountTransactionMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<AccountTransaction>>> GetList()
        {
            return new SuccessDataResult<List<AccountTransaction>>(await _accountTransactionDal.GetAll());
        }

        [SecuredAspect()]
        public async Task<IDataResult<AccountTransaction>> GetById(int id)
        {
            return new SuccessDataResult<AccountTransaction>(await _accountTransactionDal.Get(p => p.Id == id));
        }

        public async Task<IDataResult<List<AccountTransactionDto>>> GetAllDto()
        {
            return new SuccessDataResult<List<AccountTransactionDto>>(await _accountTransactionDal.GetAllDto());
        }

        public async Task<IResult> Transfer(int senderAccountId, int receiverAccountId, decimal amount, int orderId)
        {
            await _accountTransactionDal.Transfer(senderAccountId, receiverAccountId, amount, orderId);
            return new SuccessResult(AccountTransactionMessages.Added);
        }

      
    }
}
