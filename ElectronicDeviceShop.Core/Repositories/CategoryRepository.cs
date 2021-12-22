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
    public class CategoryRepository : GenericRepository<Category>, ICategoryRepository
    {
        public CategoryRepository(ElectronicDeviceShopContext context) : base(context)
        {

        }
    }
}
