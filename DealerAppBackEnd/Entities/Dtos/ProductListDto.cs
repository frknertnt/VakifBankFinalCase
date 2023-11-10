﻿using Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Dtos
{
    public class ProductListDto : Product
    {
        public decimal Price { get; set; }//unit price
        public decimal Discount { get; set; }//bayiye ait indirim
        public string MainImageUrl { get; set; }
        public List<string> Images { get; set; }

    }
}
