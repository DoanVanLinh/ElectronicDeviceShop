using ElectronicDeviceShop.Common;
using ElectronicDeviceShop.Services.Categories;
using ElectronicDeviceShop.Services.PermissionDetails;
using ElectronicDeviceShop.Services.Permissions;
using ElectronicDeviceShop.Services.Products;
using ElectronicDeviceShop.Services.Suppliers;
using ElectronicDeviceShop.ViewModels.Products;
using ElectronicDeviceShop.Web.Areas.Admin.Filters;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDeviceShop.Web.Areas.Admin.Controllers
{
    [CustomAuthorize(Roles = "Admin,Staff")]
    public class ProductController : Controller
    {

        private readonly IProductService productService;
        private readonly ICategoryService categoryService;
        private readonly ISupplierService supplierService;
        private readonly IPermissionService permissionService;
        private readonly IPermissionDetailService permissionDetailService;
        private readonly PermissionHelper permissionHelper;

        private readonly int pageSize = 4;
        public ProductController(IProductService productService, ICategoryService categoryService, ISupplierService supplierService, IPermissionService permissionService, IPermissionDetailService permissionDetailService)
        {
            this.productService = productService;
            this.categoryService = categoryService;
            this.supplierService = supplierService;
            this.permissionHelper = new PermissionHelper(permissionService, permissionDetailService);
        }
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Index()
        {
            return View();
        }
        public JsonResult CheckPermission()
        {
            int id = int.Parse(Session["ID_Account"].ToString());
            return permissionHelper.CheckPermission(id, "PRODUCTS");
        }
        public JsonResult GetAll(string txtSearch, int? page)
        {
            var products = productService.GetAll();
            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;
                products = products.Where(s => s.Name.ToLower().Contains(txtSearch.ToLower())
                                            || s.Origin.ToLower().Contains(txtSearch.ToLower())
                                            || s.Price.ToString().ToLower().Contains(txtSearch.ToLower())
                                            || s.Amount.ToString().ToLower().Contains(txtSearch.ToLower()));
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
            return Json(new { all = products, data = dataProduct, pageCurrent = page, numSize = numSize, pageSize = pageSize }, JsonRequestBehavior.AllowGet);
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

        [HttpPost]
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Create(CreateProductViewModel product)
        {
            var response = productService.Create(product);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Edit(EditProductViewModel product)
        {
            var response = productService.Edit(product);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Delete(int id)
        {
            var product = productService.GetDeleteProductById(id);
            var response = productService.Delete(product);

            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult UploadFiles()
        {
            // Checking no of files injected in Request object  
            if (Request.Files.Count > 0)
            {
                try
                {
                    //  Get all files from Request object  
                    HttpFileCollectionBase files = Request.Files;
                    for (int i = 0; i < files.Count; i++)
                    {
                        HttpPostedFileBase file = files[i];
                        string fname;

                        // Checking for Internet Explorer  
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            fname = testfiles[testfiles.Length - 1];
                        }
                        else
                        {
                            fname = file.FileName;
                        }

                        // Get the complete folder path and store the file inside it.  
                        fname = Path.Combine(Server.MapPath("~/wwwroot/ImageProducts/"), fname);
                        file.SaveAs(fname);
                    }
                    // Returns message that successfully uploaded  
                    return Json("File Uploaded Successfully!");
                }
                catch (Exception ex)
                {
                    return Json("Error occurred. Error details: " + ex.Message);
                }
            }
            else
            {
                return Json("No files selected.");
            }
        }
    }
}