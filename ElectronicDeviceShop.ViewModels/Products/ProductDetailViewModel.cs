using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Products
{
    public class ProductDetailViewModel
    {
        public int ID_Product { get; set; }

        [Display(Name ="Danh mục")]
        public int ID_Category { get; set; }

        [Display(Name = "Nhà cung cấp")]
        public int ID_Supplier { get; set; }

        [Display(Name = "Tên sản phẩm")]
        public string Name { get; set; }

        [Display(Name = "Url")]
        public string UrlSlug { get; set; }

        [Display(Name = "Giá")]
        public decimal Price { get; set; }

        [Display(Name = "Mẫu")]
        public string Model { get; set; }

        [Display(Name = "Số lượng")]
        public int Amount { get; set; }

        [Display(Name = "Bảo hành")]
        public int Guarantee { get; set; }

        [Display(Name = "Xuất xứ")]
        public string Origin { get; set; }

        [Display(Name = "Khuyến mãi")]
        public int Discount { get; set; }

        [Display(Name = "Mô tả ngắn")]
        public string ShortDescription { get; set; }

        [Display(Name = "Chi tiết")]
        public string Detail { get; set; }

        [Display(Name = "Hình ảnh")]
        public string Image { get; set; }
    }
}
