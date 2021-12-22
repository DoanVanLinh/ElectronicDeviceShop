using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Products
{
    public class ProductViewModel
    {
        public int ID_Product { get; set; }

        [Display(Name = "Tên sản phẩm")]
        public string Name { get; set; }

        [Display(Name = "Giá")]
        public decimal Price { get; set; }

        [Display(Name = "Số lượng")]
        public int Amount { get; set; }

        [Display(Name = "Xuất xứ")]
        public string Origin { get; set; }

        [Display(Name = "Hình ảnh")]
        public string Image { get; set; }
    }
}
