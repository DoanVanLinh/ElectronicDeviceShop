using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.BillDetails;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.BillDetails
{
    public interface IBillDetailService
    {
        IEnumerable<BillDetailDetailViewModel> GetDetailBillDetailByBill(int bill);
        IEnumerable<BillDetailDetailViewModel> GetAllSuccessBillDetail();
        ResponseResult Create(CreateBillDetailViewModel request);
        ResponseResult Delete(DeleteBillDetailViewModel request);
    }
}
