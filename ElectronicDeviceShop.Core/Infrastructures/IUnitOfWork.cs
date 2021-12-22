using ElectronicDeviceShop.Core.IRepositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Core.Infrastructures
{
    public interface IUnitOfWork : IDisposable
    {
        IAccountRepository AccountRepository { get; }
        IBillRepository BillRepository { get; }
        ICartRepository CartRepository { get; }
        ICategoryRepository CategoryRepository { get; }
        IProductRepository ProductRepository { get; }
        ISupplierRepository SupplierRepository { get; }
        IBillDetailRepository BillDetailRepository { get; }
        IPermissionRepository PermissionRepository { get; }
        IPermissionDetailRepository PermissionDetailRepository { get; }

        ElectronicDeviceShopContext ElectronicDeviceShopContext { get; }
        int SaveChange();
        Task<int> SaveChangeAsync();
    }
}
