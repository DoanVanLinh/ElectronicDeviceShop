using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Suppliers
{
    public class EditSupplierViewModel
    {
        public int ID_Supplier { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(255)]
        [Display(Name = "Tên nhà cung cấp")]
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
