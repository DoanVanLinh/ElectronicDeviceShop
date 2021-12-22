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
    public class BillRepository : GenericRepository<Bill>, IBillRepository
    {
        public BillRepository(ElectronicDeviceShopContext context) : base(context)
        {

        }
    }
}
