using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Products
{
    public class CreateProductViewModel
    {
        public int ID_Product { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [Display(Name = "Danh mục")]
        public int ID_Category { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [Display(Name = "Nhà cung cấp")]
        public int ID_Supplier { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(255)]
        [Display(Name = "Tên sản phẩm")]
        public string Name { get; set; }

        [StringLength(255)]
        [Display(Name = "Url")]
        public string UrlSlug { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [Display(Name = "Giá")]
        public int Price { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(255)]
        [Display(Name = "Mẫu")]
        public string Model { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [Display(Name = "Số lượng")]
        [Range(1, Int32.MaxValue, ErrorMessage = "Số lượng phải lớn hơn 0!")]
        public int Amount { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [Display(Name = "Bảo hành")]
        [Range(1, Int32.MaxValue, ErrorMessage = "Số năm phải lớn hơn 0!")]
        public int Guarantee { get; set; }

        [StringLength(255)]
        [Display(Name = "Xuất xứ")]
        public string Origin { get; set; }

        [Display(Name = "Khuyến mãi")]
        [Range(0, 100, ErrorMessage = "Khuyến mãi từ 0% - 100%!")]
        public int Discount { get; set; }

        [Display(Name = "Mô tả ngắn")]
        [Column(TypeName = "ntext")]
        public string ShortDescription { get; set; }

        [Display(Name = "Chi tiết")]
        [Column(TypeName = "ntext")]
        public string Detail { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [Display(Name = "Hình ảnh")]
        [StringLength(255)]
        public string Image { get; set; }
    }
}
