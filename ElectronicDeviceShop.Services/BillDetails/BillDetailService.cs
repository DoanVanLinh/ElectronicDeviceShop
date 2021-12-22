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
using ElectronicDeviceShop.ViewModels.BillDetails;

namespace ElectronicDeviceShop.Services.BillDetails
{
    public class BillDetailService : IBillDetailService
    {
        private readonly IUnitOfWork unitOfWork;
        public BillDetailService(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }

        public ResponseResult Create(CreateBillDetailViewModel request)
        {
            try
            {
                var billDetail = Mapper.Map<BillDetail>(request);
                this.unitOfWork.BillDetailRepository.Add(billDetail);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public ResponseResult Delete(DeleteBillDetailViewModel request)
        {
            try
            {
                var billDetail = Mapper.Map<BillDetail>(request);
                this.unitOfWork.BillDetailRepository.Delete(billDetail);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public IEnumerable<BillDetailDetailViewModel> GetAllSuccessBillDetail()
        {
            var bill = unitOfWork.BillRepository.GetAll().Where(b => b.Status == Status.SuccessOrders);
            List<int> idBill = new List<int>();
            foreach (var item in bill)
            {
                idBill.Add(item.ID_Bill);
            }
            var billDetails = unitOfWork.BillDetailRepository.GetAll().Where(b => idBill.Contains(b.ID_Bill));
            return Mapper.Map<IEnumerable<BillDetailDetailViewModel>>(billDetails);
        }

        public IEnumerable<BillDetailDetailViewModel> GetDetailBillDetailByBill(int bill)
        {
           var billDetails = unitOfWork.BillDetailRepository.GetAll().Where(b => b.ID_Bill == bill);
            return Mapper.Map<IEnumerable<BillDetailDetailViewModel>>(billDetails);
        }
    }
}
