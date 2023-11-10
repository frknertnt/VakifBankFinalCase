using Business.Repositories.CustomerAccountRepository;
using Business.Repositories.CustomerCardRepository;
using Entities.Concrete;
using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerCardsController : ControllerBase
    {
        private readonly ICustomerCardService _customerCardService;

        public CustomerCardsController(ICustomerCardService customerCardService)
        {
            _customerCardService = customerCardService;
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Add(CustomerCard customerCard)
        {
            var result = await _customerCardService.Add(customerCard);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Update(CustomerCard customerCard)
        {
            var result = await _customerCardService.Update(customerCard);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Delete(CustomerCard customerCard)
        {
            var result = await _customerCardService.Delete(customerCard);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpGet("[action]")]
        public async Task<IActionResult> GetList()
        {
            var result = await _customerCardService.GetList();
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpGet("[action]/{customerId}")]
        public async Task<IActionResult> GetListByCustomerId(int customerId)
        {
            var result = await _customerCardService.GetListByCustomerId(customerId);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var result = await _customerCardService.GetById(id);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

    }
}
