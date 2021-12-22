using AutoMapper;
using ElectronicDeviceShop.Core.Infrastructures;
using ElectronicDeviceShop.Models;
using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ElectronicDeviceShop.ViewModels.Bills;

namespace ElectronicDeviceShop.Services.Bills
{
    public class BillService : IBillService
    {
        private readonly IUnitOfWork unitOfWork;
        public BillService(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }
        public ResponseResult Edit(EditBillViewModel request)
        {
            try
            {
                var bill = Mapper.Map<Bill>(request);
                this.unitOfWork.BillRepository.Update(bill);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public IEnumerable<BillViewModel> GetAll()
        {
            var bills = this.unitOfWork.BillRepository.GetAll().Where(p => p.Status != Status.IsDeleted);
            return Mapper.Map<IEnumerable<BillViewModel>>(bills);
        }

        public EditBillViewModel GetEditBillById(int id)
        {
            var bill = unitOfWork.BillRepository.GetAll().Where(p => p.Status != Status.IsDeleted && p.ID_Bill == id).FirstOrDefault();
            return Mapper.Map<EditBillViewModel>(bill);
        }
        public BillDetailViewModel GetDetailBillById(int id)
        {
            var bill = unitOfWork.BillRepository.GetById(id);
            return Mapper.Map<BillDetailViewModel>(bill);
        }
        IEnumerable<BillViewModel> IBillService.GetDetailBillByStatus(Status status)
        {
            var bills = unitOfWork.BillRepository.GetAll().Where(b => b.Status == status);
            return Mapper.Map<IEnumerable<BillViewModel>>(bills);
        }

        public ResponseResult Create(CreateBillViewModel request)
        {
            try
            {
                var bill = Mapper.Map<Bill>(request);
                bill.BuyDate = DateTime.Today;
                bill.Status = Status.NewOrders;
                this.unitOfWork.BillRepository.Add(bill);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public EditBillViewModel GetBillNewest()
        {
            var billDetail = this.unitOfWork.BillRepository.GetAll().Where(p => p.Status != Status.IsDeleted&&p.ID_Bill == GetAll().Max(bd=>bd.ID_Bill)).FirstOrDefault();
            return Mapper.Map<EditBillViewModel>(billDetail);
        }

        public IEnumerable<BillDetailViewModel> GetAllDetailBill()
        {
            var bills = unitOfWork.BillRepository.GetAll().Where(b => b.Status == Status.SuccessOrders);
            return Mapper.Map<IEnumerable<BillDetailViewModel>>(bills);
        }
    }
}
