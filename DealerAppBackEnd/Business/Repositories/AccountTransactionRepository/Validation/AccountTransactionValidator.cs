using System;
using System.Collections.Generic;
using FluentValidation;
using System.Text;
using System.Threading.Tasks;
using Entities.Concrete;

namespace Business.Repositories.AccountTransactionRepository.Validation
{
    public class AccountTransactionValidator : AbstractValidator<AccountTransaction>
    {
        public AccountTransactionValidator()
        {
        }
    }
}
