﻿using ElectronicDeviceShop.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Bills
{
    public class BillDetailViewModel
    {
        public int ID_Bill { get; set; }

        public int ID_Account { get; set; }

        [Display(Name = "Tên người nhận")]
        public string ReceiverName { get; set; }

        [Display(Name = "Địa chỉ người nhận")]
        public string ReceiverAddress { get; set; }

        [Display(Name = "Email người nhận")]
        public string ReceiverEmail { get; set; }

        [Display(Name = "Số điện thoại người nhận")]
        public string ReceiverPhone { get; set; }

        [Column(TypeName = "ntext")]
        [Display(Name = "Ghi chú")]
        public string Note { get; set; }

        [Display(Name = "Kiểu thanh toán")]
        public string PayType { get; set; }

        [Column(TypeName = "date")]
        [Display(Name = "Ngày mua")]
        public DateTime BuyDate { get; set; }

    }
}
