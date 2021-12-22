using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Categories
{
    public class CategoryDetailViewModel
    {
        public int ID_Category { get; set; }

        [Display(Name ="Tên danh mục")]
        public string Name { get; set; }

        [Display(Name = "Url")]
        public string UrlSlug { get; set; }

        [Display(Name = "Biểu tượng")]
        public string Icon { get; set; }
    }
}
