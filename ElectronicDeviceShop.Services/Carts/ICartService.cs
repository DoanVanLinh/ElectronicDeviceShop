using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.Carts;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.Carts
{
    public interface ICartService
    {
        ResponseResult Edit(EditCartViewModel request);
        ResponseResult Create(CreateCartViewModel request);
        ResponseResult Delete(DeleteCartViewModel request);

        IEnumerable<CartViewModel> GetCartByAccount(int id);
        EditCartViewModel GetEditCartById(int id);
        CartDetailViewModel GetDetailCartById(int id);
        DeleteCartViewModel GetDeleteCartById(int id);
    }
}
