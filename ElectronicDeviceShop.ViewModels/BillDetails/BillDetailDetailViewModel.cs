using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.BillDetails
{
    public class BillDetailDetailViewModel
    {
        public int ID_Billdetail { get; set; }

        public int ID_Bill { get; set; }

        public int ID_Product { get; set; }

        public int Amount { get; set; }

        public int CurrentlyPrice { get; set; }

    }
}
