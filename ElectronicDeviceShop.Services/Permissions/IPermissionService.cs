using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.Permissions;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.Permissions
{
    public interface IPermissionService
    {
        //ResponseResult Edit(EditPermissionViewModel request);
        //ResponseResult Create(CreatePermissionViewModel request);
        //ResponseResult Delete(DeletePermissionViewModel request);

        //IEnumerable<PermissionViewModel> GetPermissionByAccount(int id);
        //EditPermissionViewModel GetEditPermissionById(int id);
        PermissionDetailViewModel GetDetailPermissionByCode(string code);
        IEnumerable<PermissionDetailViewModel> GetAllPermission();
        //DeletePermissionViewModel GetDeletePermissionById(int id);
    }
}
