using ElectronicDeviceShop.Models.EntityBase;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace ElectronicDeviceShop.Models
{
    public partial class BillDetail: BaseEntity
    {
        [Key]
        public int ID_Billdetail { get; set; }

        public int ID_Bill { get; set; }

        public int ID_Product { get; set; }

        public int Amount { get; set; }

        [Column(TypeName = "money")]
        public decimal CurrentlyPrice { get; set; }
        public virtual Bill Bill { get; set; }
        public virtual Product Product { get; set; }
    }
}
