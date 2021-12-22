using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Categories
{
    public class CreateCategoryViewModel
    {
        public int ID_Category { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(255)]
        [Display(Name = "Tên danh mục")]
        public string Name { get; set; }

        [StringLength(255)]
        [Display(Name = "Url")]
        public string UrlSlug { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(255)]
        [Display(Name = "Biểu tượng")]
        public string Icon { get; set; }
    }
}
