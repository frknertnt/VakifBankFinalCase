using Business.Repositories.CustomerCardTransactionRepository;
using Entities.Concrete;
using Entities.Dtos;
using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerCardTransactionsController : ControllerBase
    {
        private readonly ICustomerCardTransactionService _customerCardTransactionService;

        public CustomerCardTransactionsController(ICustomerCardTransactionService customerCardTransactionService)
        {
            _customerCardTransactionService = customerCardTransactionService;
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Add(CustomerCardTransaction customerCardTransaction)
        {
            var result = await _customerCardTransactionService.Add(customerCardTransaction);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Update(CustomerCardTransaction customerCardTransaction)
        {
            var result = await _customerCardTransactionService.Update(customerCardTransaction);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Delete(CustomerCardTransaction customerCardTransaction)
        {
            var result = await _customerCardTransactionService.Delete(customerCardTransaction);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpGet("[action]")]
        public async Task<IActionResult> GetList()
        {
            var result = await _customerCardTransactionService.GetList();
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var result = await _customerCardTransactionService.GetById(id);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> PayWithCard(CardPayDto cardPayDto)
        {
            var result = await _customerCardTransactionService.PayWithCard(cardPayDto);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

    }
}
