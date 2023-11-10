using Business.Abstract;
using Business.Aspects.Secured;
using Business.Repositories.CustomerRepository;
using Business.Repositories.UserRepository;
using Business.Utilities;
using Business.Utilities.CheckExist;
using Business.ValidationRules.FluentValidation;
using Core.Aspects.Validation;
using Core.Utilities.Business;
using Core.Utilities.Hashing;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using Core.Utilities.Security.JWT;
using Entities.Concrete;
using Entities.Dtos;

namespace Business.Authentication
{
    public class AuthManager : IAuthService
    {
        private readonly IUserService _userService;
        private readonly ITokenHandler _tokenHandler;
        private readonly ICustomerService _customerService;
        private readonly ICheckExist _checkExist;

        public AuthManager(IUserService userService, ITokenHandler tokenHandler, ICustomerService customerService, ICheckExist checkExist)
        {
            _userService = userService;
            _tokenHandler = tokenHandler;
            _customerService = customerService;
            _checkExist = checkExist;
        }

        public async Task<IDataResult<AdminToken>> UserLogin(LoginAuthDto loginDto)
        {
            var user = await _userService.GetByEmail(loginDto.Email);
            if (user == null)
                return new ErrorDataResult<AdminToken>("Kullanıcı maili sistemde bulunamadı!");

            var result = HashingHelper.VerifyPasswordHash(loginDto.Password, user.PasswordHash, user.PasswordSalt);

            List<OperationClaim> operationClaims = await _userService.GetUserOperationClaims(user.Id);

            if (result)
            {
                AdminToken token = new();
                token = _tokenHandler.CreateUserToken(user, operationClaims);
                return new SuccessDataResult<AdminToken>(token);
            }
            return new ErrorDataResult<AdminToken>("Kullanıcı maili ya da şifre bilgisi yanlış");
        }

        public async Task<IDataResult<CustomerToken>> CustomerLogin(CustomerLoginDto customerLoginDto)
        {
            var customer = await _customerService.GetByEmail(customerLoginDto.Email);
            if (customer == null)
                return new ErrorDataResult<CustomerToken>("Kullanıcı maili sistemde bulunamadı!");

            var result = HashingHelper.VerifyPasswordHash(customerLoginDto.Password, customer.PasswordHash, customer.PasswordSalt);

            if (result)
            {
                CustomerToken token = new();
                token = _tokenHandler.CreateCustomerToken(customer);
                return new SuccessDataResult<CustomerToken>(token);
            }
            return new ErrorDataResult<CustomerToken>("Kullanıcı maili ya da şifre bilgisi yanlış");
        }

        [ValidationAspect(typeof(AuthValidator))]
        public async Task<IResult> Register(RegisterAuthDto registerDto)
        {
            IResult result = BusinessRules.Run(
            await _checkExist.CheckIfEmailExists(_userService.GetByEmail, registerDto.Email),
            _checkExist.CheckIfImageExtesionsAllow(registerDto.Image.FileName),
            _checkExist.CheckIfImageSizeIsLessThanOneMb(registerDto.Image.Length)
            );

            if (result != null)
                return result;

            await _userService.Add(registerDto);
            return new SuccessResult("Kullanıcı kaydı başarıyla tamamlandı");
        }

        
    }
}
