using AutoMapper;
using ElectronicDeviceShop.Core.Infrastructures;
using ElectronicDeviceShop.Models;
using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.Results;
using ElectronicDeviceShop.ViewModels.Categories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.Categories
{
    public class CategoryService : ICategoryService
    {
        private readonly IUnitOfWork unitOfWork;
        public CategoryService(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }
        public ResponseResult Create(CreateCategoryViewModel request)
        {
            try
            {
                var category = Mapper.Map<Category>(request);
                this.unitOfWork.CategoryRepository.Add(category);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public ResponseResult Delete(DeleteCategoryViewModel request)
        {
            try
            {
                var category = Mapper.Map<Category>(request);
                this.unitOfWork.CategoryRepository.Delete(category.ID_Category);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public ResponseResult Edit(EditCategoryViewModel request)
        {
            try
            {
                var category = Mapper.Map<Category>(request);
                category.Status = Status.Active;
                this.unitOfWork.CategoryRepository.Update(category);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public IEnumerable<CategoryViewModel> GetAll()
        {
            var categorys = this.unitOfWork.CategoryRepository.GetAll().Where(p => p.Status != Status.IsDeleted);
            return Mapper.Map<IEnumerable<CategoryViewModel>>(categorys);
        }

        public EditCategoryViewModel GetEditCategoryById(int id)
        {
            var category = unitOfWork.CategoryRepository.GetById(id);
            return Mapper.Map<EditCategoryViewModel>(category);
        }
        public DeleteCategoryViewModel GetDeleteCategoryById(int id)
        {
            var category = unitOfWork.CategoryRepository.GetById(id);
            return Mapper.Map<DeleteCategoryViewModel>(category);
        }
        public CategoryDetailViewModel GetDetailCategoryById(int id)
        {
            var category = unitOfWork.CategoryRepository.GetById(id);
            return Mapper.Map<CategoryDetailViewModel>(category);
        }
    }
}
