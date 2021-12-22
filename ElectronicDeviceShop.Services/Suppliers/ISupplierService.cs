using ElectronicDeviceShop.ViewModels.Results;
using ElectronicDeviceShop.ViewModels.Suppliers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.Suppliers
{
    public interface ISupplierService
    {
        ResponseResult Create(CreateSupplierViewModel request);
        ResponseResult Edit(EditSupplierViewModel request);
        ResponseResult Delete(DeleteSupplierViewModel request);

        IEnumerable<SupplierViewModel> GetAll();
        EditSupplierViewModel GetEditSupplierById(int id);
        DeleteSupplierViewModel GetDeleteSupplierById(int id);
        SupplierDetailViewModel GetDetailSupplierById(int id);
    }
}
