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
using ElectronicDeviceShop.ViewModels.Permissions;
using System.Data.Entity;
using ElectronicDeviceShop.Services.Permissions;

namespace ElectronicDeviceShop.Services.Permissions
{
    public class PermissionService : IPermissionService
    {
        private readonly IUnitOfWork unitOfWork;
        public PermissionService(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }

        public IEnumerable<PermissionDetailViewModel> GetAllPermission()
        {
            var permissions = unitOfWork.PermissionRepository.GetAll().Where(p => p.Status != Status.IsDeleted);
            return Mapper.Map<IEnumerable<PermissionDetailViewModel>>(permissions);
        }

        public PermissionDetailViewModel GetDetailPermissionByCode(string code)
        {
            var permission = unitOfWork.PermissionRepository.GetAll().Where(p=>p.Code == code).FirstOrDefault();
            return Mapper.Map<PermissionDetailViewModel>(permission);
        }
    }
}
