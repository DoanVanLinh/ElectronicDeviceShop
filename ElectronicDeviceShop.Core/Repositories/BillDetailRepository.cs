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
    public class BillDetailRepository : GenericRepository<BillDetail>, IBillDetailRepository
    {
        public BillDetailRepository(ElectronicDeviceShopContext context) : base(context)
        {

        }
    }
}
