using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Carts
{
    public class CartViewModel
    {
        public int ID_Cart { get; set; }

        [Display(Name = "Sản phẩm")]
        public int ID_Product { get; set; }

        [Display(Name = "Tài khoản")]
        public int ID_Account { get; set; }

        [Display(Name = "Số Lượng")]
        public int Amount { get; set; }
    }
}
