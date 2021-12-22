using ElectronicDeviceShop.Models.EntityBase;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace ElectronicDeviceShop.Models
{

    public partial class Bill : BaseEntity
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Bill()
        {
            BillDetails = new HashSet<BillDetail>();
        }

        [Key]
        public int ID_Bill { get; set; }

        public int ID_Account { get; set; }

        [Required]
        [StringLength(50)]
        public string ReceiverName { get; set; }

        [Required]
        [StringLength(255)]
        public string ReceiverAddress { get; set; }

        [Required]
        [StringLength(255)]
        public string ReceiverEmail { get; set; }

        [Required]
        [StringLength(20)]
        public string ReceiverPhone { get; set; }

        [Column(TypeName = "ntext")]
        public string Note { get; set; }

        [Required]
        [StringLength(255)]
        public string PayType { get; set; }

        public DateTime BuyDate { get; set; }

        public virtual Account Account { get; set; }

        public virtual ICollection<BillDetail> BillDetails { get; set; }
    }
}
