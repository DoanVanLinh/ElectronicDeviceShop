using AutoMapper;
using ElectronicDeviceShop.Core.Infrastructures;
using ElectronicDeviceShop.Models;
using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.Results;
using ElectronicDeviceShop.ViewModels.Products;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.Products
{
    public class ProductService : IProductService
    {
        private readonly IUnitOfWork unitOfWork;
        public ProductService(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }
        public ResponseResult Create(CreateProductViewModel request)
        {
            try
            {
                var product = Mapper.Map<Product>(request);
                this.unitOfWork.ProductRepository.Add(product);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public ResponseResult Delete(DeleteProductViewModel request)
        {
            try
            {
                var product = Mapper.Map<Product>(request);
                this.unitOfWork.ProductRepository.Delete(product.ID_Product);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public ResponseResult Edit(EditProductViewModel request)
        {
            try
            {
                var product = Mapper.Map<Product>(request);
                product.Status = Status.Active;
                this.unitOfWork.ProductRepository.Update(product);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public IEnumerable<ProductViewModel> GetAll()
        {
            var products = this.unitOfWork.ProductRepository.GetAll().Where(p => p.Status != Status.IsDeleted);
            return Mapper.Map<IEnumerable<ProductViewModel>>(products);
        }

        public EditProductViewModel GetEditProductById(int id)
        {
            var product = unitOfWork.ProductRepository.GetAll().Where(p=>p.ID_Product == id).FirstOrDefault();
            return Mapper.Map<EditProductViewModel>(product);
        }
        public DeleteProductViewModel GetDeleteProductById(int id)
        {
            var product = unitOfWork.ProductRepository.GetById(id);
            return Mapper.Map<DeleteProductViewModel>(product);
        }
        public ProductDetailViewModel GetDetailProductById(int id)
        {
            var product = unitOfWork.ProductRepository.GetAll().Where(p=>p.ID_Product == id).FirstOrDefault();
            return Mapper.Map<ProductDetailViewModel>(product);
        }

        public IEnumerable<ProductDetailViewModel> GetAllDetail()
        {
            var products = this.unitOfWork.ProductRepository.GetAll().Where(p => p.Status != Status.IsDeleted);
            return Mapper.Map<IEnumerable<ProductDetailViewModel>>(products);
        }
    }
}
