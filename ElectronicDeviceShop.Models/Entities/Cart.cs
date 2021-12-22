using ElectronicDeviceShop.Models.EntityBase;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace ElectronicDeviceShop.Models
{
    public partial class Cart : BaseEntity
    {
        [Key]
        public int ID_Cart { get; set; }

        public int ID_Product { get; set; }

        public int ID_Account { get; set; }

        public int Amount { get; set; }

        public virtual Account Account { get; set; }

        public virtual Product Product { get; set; }
    }
}
