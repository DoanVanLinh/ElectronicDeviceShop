using ElectronicDeviceShop.Services.PermissionDetails;
using ElectronicDeviceShop.Services.Permissions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace ElectronicDeviceShop.Common
{
    public class PermissionHelper : Controller
    {
        private readonly IPermissionService permissionService;
        private readonly IPermissionDetailService permissionDetailService;

        public PermissionHelper(IPermissionService permissionService, IPermissionDetailService permissionDetailService)
        {
            this.permissionService = permissionService;
            this.permissionDetailService = permissionDetailService;
        }

        public JsonResult CheckPermission(int id,string code)
        {
            var permission = permissionService.GetDetailPermissionByCode(code);
            var permissionDetail = permissionDetailService.GetDetailPermissionDetailByIdAccountIdPermission(id, permission.ID_Permission);
            return Json(permissionDetail, JsonRequestBehavior.AllowGet);
        }
    }
}
