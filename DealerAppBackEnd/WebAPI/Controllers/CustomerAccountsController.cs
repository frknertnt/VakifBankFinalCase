using Business.Repositories.CustomerAccountRepository;
using Entities.Concrete;
using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerAccountsController : ControllerBase
    {
        private readonly ICustomerAccountService _customerAccountService;

        public CustomerAccountsController(ICustomerAccountService customerAccountService)
        {
            _customerAccountService = customerAccountService;
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Add(CustomerAccount customerAccount)
        {
            var result = await _customerAccountService.Add(customerAccount);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Update(CustomerAccount customerAccount)
        {
            var result = await _customerAccountService.Update(customerAccount);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Delete(CustomerAccount customerAccount)
        {
            var result = await _customerAccountService.Delete(customerAccount);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpGet("[action]")]
        public async Task<IActionResult> GetList()
        {
            var result = await _customerAccountService.GetList();
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }
        [HttpGet("[action]/{customerId}")]
        public async Task<IActionResult> GetListByCustomerId(int customerId)
        {
            var result = await _customerAccountService.GetListByCustomerId(customerId);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var result = await _customerAccountService.GetById(id);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

    }
}
