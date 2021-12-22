using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.BillDetails
{
    public class DetailProductByCategory
    {
        public string Name { get; set; }
        public string NameCategory { get; set; }
        public int Amount { get; set; }
        public int Month { get; set; }
        public decimal Price { get; set; }
        public decimal Total { get; set; }
    }
}
