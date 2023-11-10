using Entities.Concrete;
using Core.Utilities.Result.Abstract;
using Entities.Dtos;

namespace Business.Repositories.ProductImageRepository
{
    public interface IProductImageService
    {
        Task<IResult> Add(ProductImageAddDto productImageAddDto);
        Task<IResult> Update(ProductImageUpdateDto productImageUpdateDto);
        Task<IResult> Delete(ProductImage productImage);
        Task<IResult> SetMainImage(int id);
        Task<IDataResult<List<ProductImage>>> GetList();
        Task<IDataResult<List<ProductImage>>> GetListByProductId(int productId);//delete iþlemi
        Task<IDataResult<ProductImage>> GetById(int id);
    }
}
