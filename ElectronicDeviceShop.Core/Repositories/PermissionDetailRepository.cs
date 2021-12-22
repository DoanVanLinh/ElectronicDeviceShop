using ElectronicDeviceShop.Core.Infrastructures;
using ElectronicDeviceShop.Core.IRepositories;
using ElectronicDeviceShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Core.Repositories
{
    public class PermissionDetailRepository : GenericRepository<PermissionDetail>, IPermissionDetailRepository
    {
        public PermissionDetailRepository(ElectronicDeviceShopContext context) : base(context)
        {

        }
    }
}
