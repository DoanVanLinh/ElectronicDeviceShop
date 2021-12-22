using ElectronicDeviceShop.Common;
using ElectronicDeviceShop.Services.PermissionDetails;
using ElectronicDeviceShop.Services.Permissions;
using ElectronicDeviceShop.Services.Suppliers;
using ElectronicDeviceShop.ViewModels.Suppliers;
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
    public class SupplierController : Controller
    {
        private readonly ISupplierService supplierService;
        private readonly IPermissionService permissionService;
        private readonly IPermissionDetailService permissionDetailService;
        private readonly PermissionHelper permissionHelper;
        private readonly int pageSize = 4;
        public SupplierController(ISupplierService supplierService, IPermissionService permissionService, IPermissionDetailService permissionDetailService)
        {
            this.supplierService = supplierService;
            this.permissionService = permissionService;
            this.permissionDetailService = permissionDetailService;
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
            return permissionHelper.CheckPermission(id, "SUPPLIERS");
        }
        public JsonResult GetAll(string txtSearch, int? page)
        {
            var suppliers = supplierService.GetAll();
            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;
                suppliers = suppliers.Where(s => s.Name.ToLower().Contains(txtSearch.ToLower()));
            }

            if (page <= 0)
                page = 1;
            int totalPage = suppliers.Count();
            float totalNumsize = (totalPage / (float)pageSize);
            int numSize = (int)Math.Ceiling(totalNumsize);
            if (page > numSize)
                page = numSize;

            ViewBag.pageCurrent = page;
            ViewBag.pageSize = pageSize;
            ViewBag.numSize = numSize;
            ViewBag.all = suppliers;

            int start = (int)(page - 1) * pageSize;
            var dataSupplier = suppliers.Skip(start).Take(pageSize);
            return Json(new { all = suppliers, data = dataSupplier, pageCurrent = page, numSize = numSize, pageSize = pageSize }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetById(int id)
        {
            var supplier = supplierService.GetEditSupplierById(id);
            return Json(supplier, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Create(CreateSupplierViewModel supplier)
        {
            var response = supplierService.Create(supplier);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Edit(EditSupplierViewModel supplier)
        {
            var response = supplierService.Edit(supplier);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Delete(int id)
        {
            var supplier = supplierService.GetDeleteSupplierById(id);
            var response = supplierService.Delete(supplier);

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