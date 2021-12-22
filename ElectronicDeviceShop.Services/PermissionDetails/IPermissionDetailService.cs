using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.PermissionDetails;
using ElectronicDeviceShop.ViewModels.Permissions;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.PermissionDetails
{
    public interface IPermissionDetailService
    {
        ResponseResult Edit(PermissionDetailDetailViewModel request);
        ResponseResult Create(PermissionDetailDetailViewModel request);
        //ResponseResult Delete(DeletePermissionViewModel request);

        //IEnumerable<PermissionViewModel> GetPermissionByAccount(int id);
        //EditPermissionViewModel GetEditPermissionById(int id);
        PermissionDetailDetailViewModel GetDetailPermissionDetailByIdAccountIdPermission(int idAccount, int idPermission);
        //DeletePermissionViewModel GetDeletePermissionById(int id);
    }
}
