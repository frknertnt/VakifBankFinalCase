using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.UserAccountRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.UserAccountRepository.Validation;
using Business.Repositories.UserAccountRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.UserAccountRepository;

namespace Business.Repositories.UserAccountRepository
{
    public class UserAccountManager : IUserAccountService
    {
        private readonly IUserAccountDal _userAccountDal;

        public UserAccountManager(IUserAccountDal userAccountDal)
        {
            _userAccountDal = userAccountDal;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(UserAccountValidator))]
        [RemoveCacheAspect("IUserAccountService.Get")]

        public async Task<IResult> Add(UserAccount userAccount)
        {
            await _userAccountDal.Add(userAccount);
            return new SuccessResult(UserAccountMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(UserAccountValidator))]
        [RemoveCacheAspect("IUserAccountService.Get")]

        public async Task<IResult> Update(UserAccount userAccount)
        {
            await _userAccountDal.Update(userAccount);
            return new SuccessResult(UserAccountMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("IUserAccountService.Get")]

        public async Task<IResult> Delete(UserAccount userAccount)
        {
            await _userAccountDal.Delete(userAccount);
            return new SuccessResult(UserAccountMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<UserAccount>>> GetList()
        {
            return new SuccessDataResult<List<UserAccount>>(await _userAccountDal.GetAll());
        }

        [SecuredAspect()]
        public async Task<IDataResult<UserAccount>> GetById(int id)
        {
            return new SuccessDataResult<UserAccount>(await _userAccountDal.Get(p => p.Id == id));
        }

    }
}
