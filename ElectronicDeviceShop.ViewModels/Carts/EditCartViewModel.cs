using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Carts
{
    public class EditCartViewModel
    {
        public int ID_Cart { get; set; }

        [Display(Name = "Sản phẩm")]
        public int ID_Product { get; set; }

        [Display(Name = "Tài khoản")]
        public int ID_Account { get; set; }

        [Range(1, Int32.MaxValue, ErrorMessage = "Số lượng phải là số không âm!")]
        [Display(Name = "Số Lượng")]
        public int Amount { get; set; }
    }
}
