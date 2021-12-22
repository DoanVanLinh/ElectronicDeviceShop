using Autofac;
using Autofac.Integration.Mvc;
using Autofac.Integration.WebApi;
using ElectronicDeviceShop.Core;
using ElectronicDeviceShop.Core.Infrastructures;
using ElectronicDeviceShop.Core.Repositories;
using ElectronicDeviceShop.Services.Accounts;
using ElectronicDeviceShop.Services.BillDetails;
using ElectronicDeviceShop.Services.Bills;
using ElectronicDeviceShop.Services.Categories;
using ElectronicDeviceShop.Services.Products;
using ElectronicDeviceShop.Services.Suppliers;
using ElectronicDeviceShop.Services.Permissions;
using ElectronicDeviceShop.Services.PermissionDetails;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace ElectronicDeviceShop.Web.App_Start
{
    public class AutofacConfig
    {
        public static void RegisterComponents()
        {
            var builder = new ContainerBuilder();
            //register
            builder.RegisterControllers(typeof(MvcApplication).Assembly);
            builder.RegisterApiControllers(typeof(MvcApplication).Assembly);

            builder.RegisterType<ElectronicDeviceShopContext>().AsSelf().InstancePerRequest();

            builder.RegisterType<UnitOfWork>().As<IUnitOfWork>().InstancePerRequest();

            // Scan an assembly for components


            builder.RegisterAssemblyTypes(typeof(CategoryRepository).Assembly)
                   .Where(t => t.Name.EndsWith("Repository"))
                   .AsImplementedInterfaces()
                   .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(CategoryService).Assembly)
                 .Where(t => t.Name.EndsWith("Service"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(ProductRepository).Assembly)
                .Where(t => t.Name.EndsWith("Repository"))
                .AsImplementedInterfaces()
                .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(ProductService).Assembly)
                 .Where(t => t.Name.EndsWith("Service"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(SupplierRepository).Assembly)
                 .Where(t => t.Name.EndsWith("Repository"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(SupplierService).Assembly)
                 .Where(t => t.Name.EndsWith("Service"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(AccountRepository).Assembly)
                 .Where(t => t.Name.EndsWith("Repository"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(AccountService).Assembly)
                 .Where(t => t.Name.EndsWith("Service"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(BillRepository).Assembly)
                 .Where(t => t.Name.EndsWith("Repository"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(BillService).Assembly)
                 .Where(t => t.Name.EndsWith("Service"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(BillDetailRepository).Assembly)
                 .Where(t => t.Name.EndsWith("Repository"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(BillDetailService).Assembly)
                 .Where(t => t.Name.EndsWith("Service"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(PermissionRepository).Assembly)
                 .Where(t => t.Name.EndsWith("Repository"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(PermissionService).Assembly)
                 .Where(t => t.Name.EndsWith("Service"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(PermissionDetailRepository).Assembly)
                 .Where(t => t.Name.EndsWith("Repository"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            builder.RegisterAssemblyTypes(typeof(PermissionDetailService).Assembly)
                 .Where(t => t.Name.EndsWith("Service"))
                 .AsImplementedInterfaces()
                 .InstancePerLifetimeScope();

            var container = builder.Build();
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
            GlobalConfiguration.Configuration.DependencyResolver = new AutofacWebApiDependencyResolver(container);
        }

    }
}