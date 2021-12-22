using ElectronicDeviceShop.Services.Categories;
using ElectronicDeviceShop.Services.Products;
using ElectronicDeviceShop.Services.Suppliers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDeviceShop.Web.Controllers
{
    public class ProductController : Controller
    {
        private readonly IProductService productService;
        private readonly ICategoryService categoryService;
        private readonly ISupplierService supplierService;

        private readonly int pageSize = 12;
        public ProductController(IProductService productService, ICategoryService categoryService, ISupplierService supplierService)
        {
            this.productService = productService;
            this.categoryService = categoryService;
            this.supplierService = supplierService;
        }

        public ActionResult Index()
        {

            if (Session["ID_Account"] == null)
            {
                Session["ID_Account"] = -1;
                Session["RoleAcc"] = -1;
            }
            return View();
        }
        public JsonResult GetAll(string txtSearch, int? page, List<int> categoryFilter, List<int> supplierFilter)
        {
            var products = productService.GetAllDetail();
            var max = products.Max(p => p.Price);
            if (categoryFilter!=null && supplierFilter!=null)
                products = productService.GetAllDetail().Where(p=> categoryFilter.Contains(p.ID_Category)&&supplierFilter.Contains(p.ID_Supplier));
            else if(categoryFilter != null)
                products = productService.GetAllDetail().Where(p => categoryFilter.Contains(p.ID_Category));
            else if(supplierFilter != null)
                products = productService.GetAllDetail().Where(p => supplierFilter.Contains(p.ID_Supplier));

            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;
                products = products.Where(s => s.Name.ToLower().Contains(txtSearch.ToLower())
                                            || s.Price.ToString().ToLower().Contains(txtSearch.ToLower()));
            }

            if (page <= 0)
                page = 1;
            int totalPage = products.Count();
            float totalNumsize = (totalPage / (float)pageSize);
            int numSize = (int)Math.Ceiling(totalNumsize);
            if (page > numSize)
                page = numSize;

            ViewBag.pageCurrent = page;
            ViewBag.pageSize = pageSize;
            ViewBag.numSize = numSize;
            ViewBag.all = products;

            int start = (int)(page - 1) * pageSize;
            var dataProduct = products.Skip(start).Take(pageSize);
            return Json(new { all = products, data = dataProduct, pageCurrent = page, numSize = numSize, pageSize = pageSize, max = max }, JsonRequestBehavior.AllowGet);

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

        public ActionResult Detail(int id)
        {
            var product = productService.GetDetailProductById(id);
            return View(product);
        }
    }
}