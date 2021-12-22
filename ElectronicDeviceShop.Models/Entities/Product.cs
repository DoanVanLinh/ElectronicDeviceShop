using ElectronicDeviceShop.Models.EntityBase;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace ElectronicDeviceShop.Models
{

    public partial class Product : BaseEntity
    {
        public Product()
        {
            BillDetails = new HashSet<BillDetail>();
            Carts = new HashSet<Cart>();
        }

        [Key]
        public int ID_Product { get; set; }

        public int ID_Category { get; set; }

        public int ID_Supplier { get; set; }

        [Required]
        [StringLength(255)]
        public string Name { get; set; }

        [StringLength(255)]
        public string UrlSlug { get; set; }

        [Column(TypeName = "money")]
        public decimal Price { get; set; }

        [Required]
        [StringLength(255)]
        public string Model { get; set; }

        public int Amount { get; set; }

        public int Guarantee { get; set; }

        [StringLength(255)]
        public string Origin { get; set; }

        public int? Discount { get; set; }

        [Column(TypeName = "ntext")]
        public string ShortDescription { get; set; }

        [Column(TypeName = "ntext")]
        public string Detail { get; set; }

        [Required]
        [StringLength(255)]
        public string Image { get; set; }

        public virtual ICollection<BillDetail> BillDetails { get; set; }

        public virtual ICollection<Cart> Carts { get; set; }

        public virtual Category Category { get; set; }

        public virtual Supplier Supplier { get; set; }
    }
}
