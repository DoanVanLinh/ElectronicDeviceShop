using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Core
{
    class ElectronicDeviceShopInitializer : CreateDatabaseIfNotExists<ElectronicDeviceShopContext>
    {
        public void SeedData(ElectronicDeviceShopContext context)
        {
            base.Seed(context);
        }
    }
}
