using Entities.Concrete;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Dtos
{
    public class ProductImageUpdateDto : ProductImage// Eski productimage bilgileri hariç tüm bilgilere erişmem gerek
    {
        public IFormFile Image { get; set; }
    }
}
