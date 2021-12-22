using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Models.Enums
{
    public enum Status
    {
        IsDeleted,
        Active,
        NewOrders,
        ConfirmOrders,
        ShippingOrders,
        SuccessOrders,
        CancelOrders,
    }
}
