using ElectronicDeviceShop.Models;
using ElectronicDeviceShop.Models.EntityBase;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace ElectronicDeviceShop.Models
{
    public partial class PermissionDetail : BaseEntity
    {
        [Key]
        public int ID_PermissionDetail { get; set; }

        public int ID_Permission { get; set; }

        public int ID_Account { get; set; }

        public bool? View { get; set; }

        public bool? Create { get; set; }

        public bool? Edit { get; set; }

        public bool? Delete { get; set; }

        public virtual Account Account { get; set; }

        public virtual Permission Permission { get; set; }
    }
}
