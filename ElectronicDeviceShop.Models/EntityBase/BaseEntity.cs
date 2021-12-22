using ElectronicDeviceShop.Models.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Models.EntityBase
{
    public class BaseEntity : IBaseEntity
    {
        //[Key]
        //public int Id { get; set; }

        [Display(Name = "Trạng thái")]
        public Status? Status { get; set; }
    }
}
