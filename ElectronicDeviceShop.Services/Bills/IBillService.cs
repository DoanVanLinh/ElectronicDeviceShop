using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.Bills;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.Bills
{
    public interface IBillService
    {
        ResponseResult Edit(EditBillViewModel request);
        ResponseResult Create(CreateBillViewModel request);

        IEnumerable<BillViewModel> GetAll();
        IEnumerable<BillDetailViewModel> GetAllDetailBill();
        IEnumerable<BillViewModel> GetDetailBillByStatus(Status status);
        EditBillViewModel GetEditBillById(int id);
        BillDetailViewModel GetDetailBillById(int id);
        EditBillViewModel GetBillNewest();
    }
}
