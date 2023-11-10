using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.ProductImageRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.ProductImageRepository.Validation;
using Business.Repositories.ProductImageRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.ProductImageRepository;
using Entities.Dtos;
using Business.Abstract;
using Core.Utilities.Business;
using Business.Utilities.CheckExist;
using Core.Aspects.Transaction;

namespace Business.Repositories.ProductImageRepository
{
    public class ProductImageManager : IProductImageService
    {
        private readonly IProductImageDal _productImageDal;
        private readonly IFileService _fileService;
        private readonly ICheckExist checkExist;

        public ProductImageManager(IProductImageDal productImageDal, IFileService fileService, ICheckExist checkExist)
        {
            _productImageDal = productImageDal;
            _fileService = fileService;
            this.checkExist = checkExist;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(ProductImageValidator))]
        [RemoveCacheAspect("IProductImageService.Get")]
        public async Task<IResult> Add(ProductImageAddDto productImageAddDto)
        {
            foreach (var img in productImageAddDto.Images)//eklenen resimlerde hata varsa atla hatasýzlarý ekle
            {
                IResult result = BusinessRules.Run(
               checkExist.CheckIfImageExtesionsAllow(img.FileName),
               checkExist.CheckIfImageSizeIsLessThanOneMb(img.Length)
               );

                if (result == null) // hata yoksa
                {
                    //Ekleme için Resmi kaydedip dosya adý almam gerek
                    string fileName = _fileService.FileSaveToServer(img, "C:/VkFinalCaseProject/AdminFrontEnd/src/assets/img/");//frontend adresi

                    ProductImage productImage = new()
                    {
                        Id = 0,
                        ImageUrl = fileName,
                        ProductId = productImageAddDto.ProductId,
                        IsMainImage = false
                    };

                    await _productImageDal.Add(productImage);
                }         
            }
            return new SuccessResult(ProductImageMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(ProductImageValidator))]
        [RemoveCacheAspect("IProductImageService.Get")]
        public async Task<IResult> Update(ProductImageUpdateDto productImageUpdateDto)
        {
            IResult result = BusinessRules.Run(
                checkExist.CheckIfImageExtesionsAllow(productImageUpdateDto.Image.FileName),
                checkExist.CheckIfImageSizeIsLessThanOneMb(productImageUpdateDto.Image.Length)
                );

            if (result != null)
                return result;

            //Yeni kayýt yapmadan önce önceki kaydý sil
            string path = @"./Content/img/" + productImageUpdateDto.ImageUrl;
            _fileService.FileDeleteToServer(path);
           
            //Ekleme için Resmi kaydedip dosya adý almam gerek
            string fileName = _fileService.FileSaveToServer(productImageUpdateDto.Image, "./Content/img/");

            ProductImage productImage = new()
            {
                Id = productImageUpdateDto.Id,
                ImageUrl = fileName,
                ProductId = productImageUpdateDto.ProductId,
                IsMainImage = productImageUpdateDto.IsMainImage
            };

            await _productImageDal.Update(productImage);
            return new SuccessResult(ProductImageMessages.Updated);
        }

        [SecuredAspect()]
        //[RemoveCacheAspect("IProductImageService.Get")]
        public async Task<IResult> Delete(ProductImage productImage)
        {
            string path = @"C:/VkFinalCaseProject/AdminFrontEnd/src/assets/img/" + productImage.ImageUrl;
            _fileService.FileDeleteToServer(path);

            await _productImageDal.Delete(productImage);
            return new SuccessResult(ProductImageMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<ProductImage>>> GetList()
        {
            return new SuccessDataResult<List<ProductImage>>(await _productImageDal.GetAll());
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<ProductImage>>> GetListByProductId(int productId)
        {
            return new SuccessDataResult<List<ProductImage>>(await _productImageDal.GetAll(p => p.ProductId == productId));
        }

        [SecuredAspect()]
        public async Task<IDataResult<ProductImage>> GetById(int id)
        {
            return new SuccessDataResult<ProductImage>(await _productImageDal.Get(p => p.Id == id));
        }

        [SecuredAspect()]
        [RemoveCacheAspect("IProductImageService.Get")]
        [RemoveCacheAspect("IProductService.Get")]

        public async Task<IResult> SetMainImage(int id)
        {
            var productImage = await _productImageDal.Get(p => p.Id == id);

            //Baþka anaresim var ise önce onu sil sonra ekle
            var productImages = await _productImageDal.GetAll(p=>p.ProductId == productImage.ProductId);
            foreach (var img in productImages)
            {
                img.IsMainImage = false;
                await _productImageDal.Update(img);
            }

            productImage.IsMainImage = true;
            await _productImageDal.Update(productImage);

            return new SuccessResult(ProductImageMessages.MainImageUpdateIsSuccessful);
        }
    }
}
