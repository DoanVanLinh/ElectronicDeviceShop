using ElectronicDeviceShop.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.BillDetails
{
    public class CreateBillDetailViewModel
    {
        public int ID_BillDetail { get; set; }
        public int ID_Bill { get; set; }
        public int ID_Product { get; set; }
        public int Amount { get; set; }
        public decimal CurrentlyPrice { get; set; }
        public Status Status { get; set; }
    }
}
