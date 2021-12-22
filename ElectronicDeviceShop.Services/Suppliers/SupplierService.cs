using AutoMapper;
using ElectronicDeviceShop.Core.Infrastructures;
using ElectronicDeviceShop.Models;
using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.Results;
using ElectronicDeviceShop.ViewModels.Suppliers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.Suppliers
{
    public class SupplierService : ISupplierService
    {
        private readonly IUnitOfWork unitOfWork;
        public SupplierService(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }
        public ResponseResult Create(CreateSupplierViewModel request)
        {
            try
            {
                var supplier = Mapper.Map<Supplier>(request);
                this.unitOfWork.SupplierRepository.Add(supplier);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public ResponseResult Delete(DeleteSupplierViewModel request)
        {
            try
            {
                var supplier = Mapper.Map<Supplier>(request);
                this.unitOfWork.SupplierRepository.Delete(supplier.ID_Supplier);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public ResponseResult Edit(EditSupplierViewModel request)
        {
            try
            {
                var supplier = Mapper.Map<Supplier>(request);
                supplier.Status = Status.Active;
                this.unitOfWork.SupplierRepository.Update(supplier);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public IEnumerable<SupplierViewModel> GetAll()
        {
            var suppliers = this.unitOfWork.SupplierRepository.GetAll().Where(p => p.Status != Status.IsDeleted);
            return Mapper.Map<IEnumerable<SupplierViewModel>>(suppliers);
        }

        public EditSupplierViewModel GetEditSupplierById(int id)
        {
            var supplier = unitOfWork.SupplierRepository.GetById(id);
            return Mapper.Map<EditSupplierViewModel>(supplier);
        }
        public DeleteSupplierViewModel GetDeleteSupplierById(int id)
        {
            var supplier = unitOfWork.SupplierRepository.GetById(id);
            return Mapper.Map<DeleteSupplierViewModel>(supplier);
        }
        public SupplierDetailViewModel GetDetailSupplierById(int id)
        {
            var supplier = unitOfWork.SupplierRepository.GetById(id);
            return Mapper.Map<SupplierDetailViewModel>(supplier);
        }

    }
}
