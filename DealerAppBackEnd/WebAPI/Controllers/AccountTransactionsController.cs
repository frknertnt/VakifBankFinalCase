using Business.Repositories.AccountTransactionRepository;
using Entities.Concrete;
using Entities.Dtos;
using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountTransactionsController : ControllerBase
    {
        private readonly IAccountTransactionService _accountTransactionService;

        public AccountTransactionsController(IAccountTransactionService accountTransactionService)
        {
            _accountTransactionService = accountTransactionService;
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Add(AccountTransaction accountTransaction)
        {
            var result = await _accountTransactionService.Add(accountTransaction);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Update(AccountTransaction accountTransaction)
        {
            var result = await _accountTransactionService.Update(accountTransaction);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Delete(AccountTransaction accountTransaction)
        {
            var result = await _accountTransactionService.Delete(accountTransaction);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpGet("[action]")]
        public async Task<IActionResult> GetList()
        {
            var result = await _accountTransactionService.GetList();
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }
        [HttpGet("[action]")]
        public async Task<IActionResult> GetAllDto()
        {
            var result = await _accountTransactionService.GetAllDto();
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var result = await _accountTransactionService.GetById(id);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }

        [HttpPost("[action]")]
        public async Task<IActionResult> Transfer(TransferDto transferDto)
        {
            var result = await _accountTransactionService.Transfer(transferDto.SenderAccountId, transferDto.ReceiverAccountId, transferDto.Amount, transferDto.OrderId);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result.Message);
        }
    


    }
}
