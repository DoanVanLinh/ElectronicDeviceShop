using ElectronicDeviceShop.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.PermissionDetails
{
    public class PermissionDetailDetailViewModel
    {
        public int ID_PermissionDetail { get; set; }

        public int ID_Permission { get; set; }

        public int ID_Account { get; set; }

        public bool? View { get; set; }

        public bool? Create { get; set; }

        public bool? Edit { get; set; }

        public bool? Delete { get; set; }
        public Status Status { get; set; }
    }
}
