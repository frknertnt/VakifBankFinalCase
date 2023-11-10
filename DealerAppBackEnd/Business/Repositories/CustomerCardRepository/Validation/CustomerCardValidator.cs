using System;
using System.Collections.Generic;
using FluentValidation;
using System.Text;
using System.Threading.Tasks;
using Entities.Concrete;

namespace Business.Repositories.CustomerCardRepository.Validation
{
    public class CustomerCardValidator : AbstractValidator<CustomerCard>
    {
        public CustomerCardValidator()
        {
        }
    }
}
