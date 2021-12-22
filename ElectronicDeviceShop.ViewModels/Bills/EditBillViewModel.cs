using ElectronicDeviceShop.Models.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Bills
{
    public class EditBillViewModel
    {
        public int ID_Bill { get; set; }
        public int ID_Account { get; set; }
        public string ReceiverName { get; set; }
        public string ReceiverAddress { get; set; }
        public string ReceiverEmail { get; set; }
        public string ReceiverPhone { get; set; }
        public string Note { get; set; }
        public string PayType { get; set; }
        public DateTime BuyDate { get; set; }
        public Status Status { get; set; }
    }
}
