using ElectronicDeviceShop.Core.IRepositories;
using ElectronicDeviceShop.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Core.Infrastructures
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly ElectronicDeviceShopContext context;

        private IAccountRepository accountRepository;
        private IBillRepository billRepository;
        private ICartRepository cartRepository;
        private ICategoryRepository categoryRepository;
        private IProductRepository productRepository;
        private ISupplierRepository supplierRepository;
        private IPermissionRepository permissionRepository;
        private IPermissionDetailRepository permissionDetailRepository;
        private IBillDetailRepository billDetailRepository;

        public UnitOfWork(ElectronicDeviceShopContext context)
        {
            this.context = context;
        }
        public IAccountRepository AccountRepository
        {
            get
            {
                if (this.accountRepository == null)
                {
                    this.accountRepository = new AccountRepository(this.context);
                }
                return this.accountRepository;

            }
        }
        public IBillRepository BillRepository
        {
            get
            {
                if (this.billRepository == null)
                {
                    this.billRepository = new BillRepository(this.context);
                }
                return this.billRepository;

            }
        }
        public ICartRepository CartRepository
        {
            get
            {
                if (this.cartRepository == null)
                {
                    this.cartRepository = new CartRepository(this.context);
                }
                return this.cartRepository;

            }
        }
        public ICategoryRepository CategoryRepository
        {
            get
            {
                if (this.categoryRepository == null)
                {
                    this.categoryRepository = new CategoryRepository(this.context);
                }
                return this.categoryRepository;

            }
        }
        public IProductRepository ProductRepository
        {
            get
            {
                if (this.productRepository == null)
                {
                    this.productRepository = new ProductRepository(this.context);
                }
                return this.productRepository;

            }
        }
        public ISupplierRepository SupplierRepository
        {
            get
            {
                if (this.supplierRepository == null)
                {
                    this.supplierRepository = new SupplierRepository(this.context);
                }
                return this.supplierRepository;

            }
        } 
        public IBillDetailRepository BillDetailRepository
        {
            get
            {
                if (this.billDetailRepository == null)
                {
                    this.billDetailRepository = new BillDetailRepository(this.context);
                }
                return this.billDetailRepository;

            }
        }
        public IPermissionRepository PermissionRepository
        {
            get
            {
                if (this.permissionRepository == null)
                {
                    this.permissionRepository = new PermissionRepository(this.context);
                }
                return this.permissionRepository;

            }
        }
        public IPermissionDetailRepository PermissionDetailRepository
        {
            get
            {
                if (this.permissionDetailRepository == null)
                {
                    this.permissionDetailRepository = new PermissionDetailRepository(this.context);
                }
                return this.permissionDetailRepository;

            }
        }
        public ElectronicDeviceShopContext ElectronicDeviceShopContext => throw new NotImplementedException();

        public void Dispose()
        {
            this.context.Dispose();
        }

        public int SaveChange()
        {
            return this.context.SaveChanges();
        }

        public async Task<int> SaveChangeAsync()
        {
            return await this.context.SaveChangesAsync();
        }
    }
}
