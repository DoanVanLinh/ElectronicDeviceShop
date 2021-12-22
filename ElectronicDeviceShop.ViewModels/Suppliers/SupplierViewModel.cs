using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Suppliers
{
    public class SupplierViewModel
    {
        public int ID_Supplier { get; set; }

        [Display(Name = "Tên nhà cung cấp")]
        public string Name { get; set; }

        [Display(Name = "Url")]
        public string UrlSlug { get; set; }

        [Display(Name = "Biểu tượng")]
        public string Icon { get; set; }
    }
}
