using ElectronicDeviceShop.Services.Categories;
using ElectronicDeviceShop.Services.Products;
using ElectronicDeviceShop.Services.Suppliers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDeviceShop.Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly IProductService productService;
        private readonly ICategoryService categoryService;
        private readonly ISupplierService supplierService;
        public HomeController(IProductService productService, ICategoryService categoryService, ISupplierService supplierService)
        {
            this.productService = productService;
            this.categoryService = categoryService;
            this.supplierService = supplierService;
        }

        public ActionResult Index()
        {
            
            return View();
        }
        public JsonResult GetAll()
        {
            var products = productService.GetAllDetail();
            var dataProduct = products.Skip(0).Take(10);
            return Json(new { all = products, data = dataProduct }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetById(int id)
        {
            var product = productService.GetEditProductById(id);
            var sup = supplierService.GetDetailSupplierById(product.ID_Supplier).Name;
            var cate = categoryService.GetDetailCategoryById(product.ID_Category).Name;

            return Json(new { product = product, supplier = sup, category = cate }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSupGetCate()
        {
            var supplier = supplierService.GetAll().Select(s => new
            {
                ID = s.ID_Supplier,
                Name = s.Name
            }).ToList();
            var category = categoryService.GetAll().Select(c => new
            {
                ID = c.ID_Category,
                Name = c.Name
            }).ToList();
            return Json(new { supplier = supplier, category = category }, JsonRequestBehavior.AllowGet);
        }

    }
}