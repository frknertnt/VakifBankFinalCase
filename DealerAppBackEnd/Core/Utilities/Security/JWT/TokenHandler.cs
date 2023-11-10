using Castle.Core.Resource;
using Core.Extensions;
using Entities.Concrete;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace Core.Utilities.Security.JWT
{
    public class TokenHandler : ITokenHandler
    {
        IConfiguration Configuration;

        public TokenHandler(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public AdminToken CreateUserToken(User user, List<OperationClaim> operationClaims)
        {
            var claims = SetClaims(user, operationClaims);
            var tokenDescriptor = GetTokenDescriptor(claims);

            JwtSecurityTokenHandler jwtSecurityTokenHandler = new JwtSecurityTokenHandler();
            AdminToken token = new AdminToken
            {
                AdminAccessToken = jwtSecurityTokenHandler.WriteToken(jwtSecurityTokenHandler.CreateToken(tokenDescriptor)),
                RefreshToken = CreateRefreshToken(),
                Expiration = tokenDescriptor.Expires ?? DateTime.Now
            };

            return token;
        }

        public CustomerToken CreateCustomerToken(Customer customer)
        {
            var claims = SetCustomerClaims(customer);
            var tokenDescriptor = GetTokenDescriptor(claims);

            JwtSecurityTokenHandler jwtSecurityTokenHandler = new JwtSecurityTokenHandler();
            CustomerToken token = new CustomerToken
            {
                CustomerAccessToken = jwtSecurityTokenHandler.WriteToken(jwtSecurityTokenHandler.CreateToken(tokenDescriptor)),
                RefreshToken = CreateRefreshToken(),
                Expiration = tokenDescriptor.Expires ?? DateTime.Now
            };

            return token;
        }

        private SecurityTokenDescriptor GetTokenDescriptor(IEnumerable<Claim> claims)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["Token:SecurityKey"]));
            var signingCredentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256Signature);

            return new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Issuer = Configuration["Token:Issuer"],
                Audience = Configuration["Token:Audience"],
                Expires = DateTime.Now.AddMinutes(60),
                NotBefore = DateTime.Now,
                SigningCredentials = signingCredentials
            };
        }

        private IEnumerable<Claim> SetClaims(User user, List<OperationClaim> operationClaims)
        {
            var claims = new List<Claim>();
            claims.AddId(user.Id.ToString());
            claims.AddName(user.Name);
            claims.AddRoles(operationClaims.Select(p => p.Name).ToArray());
            return claims;
        }

        private IEnumerable<Claim> SetCustomerClaims(Customer customer)
        {
            var claims = new List<Claim>();
            claims.AddId(customer.Id.ToString());
            claims.AddName(customer.Name);
            return claims;
        }

        public string CreateRefreshToken()
        {
            byte[] number = new byte[32];
            using (RandomNumberGenerator random = RandomNumberGenerator.Create())
            {
                random.GetBytes(number);
                return Convert.ToBase64String(number);
            }
        }
    }

}
