using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.CustomerRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.CustomerRepository.Validation;
using Business.Repositories.CustomerRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.CustomerRepository;
using Entities.Dtos;
using Core.Utilities.Hashing;
using Business.Repositories.UserRepository;
using Core.Utilities.Business;
using Business.Utilities.CheckExist;
using Business.Repositories.CustomerRelationShipRepository;

namespace Business.Repositories.CustomerRepository
{
    public class CustomerManager : ICustomerService
    {
        private readonly ICustomerDal _customerDal;
        private readonly ICustomerRelationShipService _customerRelationShipService;
        private readonly ICheckExist _checkExist;

        public CustomerManager(ICustomerDal customerDal, ICheckExist checkExist, ICustomerRelationShipService customerRelationShipService)
        {
            _customerDal = customerDal;
            _customerRelationShipService = customerRelationShipService;
            _checkExist = checkExist;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(CustomerValidator))]
        [RemoveCacheAspect("ICustomerService.Get")]
        public async Task<IResult> Add(CustomerRegisterDto customerRegisterDto)
        {
            IResult result = BusinessRules
            .Run(await _checkExist.CheckIfEmailExists(GetByEmail, customerRegisterDto.Email));

            if (result != null)
                return result;

            byte[] passwordHash, passwordSalt;
            HashingHelper.CreatePassword(customerRegisterDto.Password, out passwordHash, out passwordSalt);//parolayý þifreleyip iki ayrý deðeri ayný anda döndürmek için out anahtar kelimesini kullandýk.
            Customer customer = new Customer()
            {
                Id = 0,
                Name = customerRegisterDto.Name,
                Email = customerRegisterDto.Email,
                PasswordHash = passwordHash,
                PasswordSalt = passwordSalt
            };
            await _customerDal.Add(customer);
            return new SuccessResult(CustomerMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(CustomerValidator))]
        [RemoveCacheAspect("ICustomerService.Get")]
        public async Task<IResult> Update(Customer customer)
        {
            await _customerDal.Update(customer);
            return new SuccessResult(CustomerMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("ICustomerService.Get")]
        public async Task<IResult> Delete(Customer customer)
        {
            IResult result = BusinessRules.Run(
                await _checkExist.CheckIfCustomerOrderExist(customer.Id)
                );
            if (result != null)
                return result;

            var customerRelationship = await _customerRelationShipService.GetByCustomerId(customer.Id);
            if (customerRelationship.Data != null)
                await _customerRelationShipService.Delete(customerRelationship.Data);


            await _customerDal.Delete(customer);
            return new SuccessResult(CustomerMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<CustomerDto>>> GetList()
        {
            return new SuccessDataResult<List<CustomerDto>>(await _customerDal.GetListDto());
        }

        [SecuredAspect()]
        public async Task<IDataResult<Customer>> GetById(int id)
        {
            return new SuccessDataResult<Customer>(await _customerDal.Get(p => p.Id == id));
        }

        public async Task<Customer> GetByEmail(string email)
        {
            var result = await _customerDal.Get(p => p.Email == email);
            return result;
        }

        [SecuredAspect()]
        public async Task<IResult> ChangePasswordByAdminPanel(CustomerChangePasswordByAdminPanelDto customerDto)
        {
            byte[] passwordHash, passwordSalt;
            HashingHelper.CreatePassword(customerDto.Password, out passwordHash, out passwordSalt);
            var customer = await _customerDal.Get(p => p.Id == customerDto.Id);
            customer.PasswordHash = passwordHash;
            customer.PasswordSalt = passwordSalt;

            await _customerDal.Update(customer);
            return new SuccessResult(CustomerMessages.ChangedPassword);
        }

        public async Task<IDataResult<CustomerDto>> GetDtoById(int id)
        {
            return new SuccessDataResult<CustomerDto>(await _customerDal.GetDto(id));
        }
    }
}
