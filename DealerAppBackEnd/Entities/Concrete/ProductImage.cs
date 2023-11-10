using Entities.Concrete.Base;

namespace Entities.Concrete
{
    public class ProductImage : BaseEntity
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public string ImageUrl { get; set; }
        public bool IsMainImage { get; set; }
    }
}
