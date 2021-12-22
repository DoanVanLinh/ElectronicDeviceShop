using ElectronicDeviceShop.Common;
using ElectronicDeviceShop.Services.Categories;
using ElectronicDeviceShop.Services.PermissionDetails;
using ElectronicDeviceShop.Services.Permissions;
using ElectronicDeviceShop.ViewModels.Categories;
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
    public class CategoryController : Controller
    {
        private readonly ICategoryService categoryService;
        private readonly IPermissionService permissionService;
        private readonly IPermissionDetailService permissionDetailService;
        private readonly PermissionHelper permissionHelper;
        private readonly int pageSize = 4;
        public CategoryController(ICategoryService categoryService, IPermissionService permissionService, IPermissionDetailService permissionDetailService)
        {
            this.categoryService = categoryService;
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
            return permissionHelper.CheckPermission(id, "CATEGORIES");
        }
        public JsonResult GetAll(string txtSearch, int? page)
        {
            var categorys = categoryService.GetAll();
            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;
                categorys = categorys.Where(s => s.Name.ToLower().Contains(txtSearch.ToLower()));
            }

            if (page <= 0)
                page = 1;
            int totalPage = categorys.Count();
            float totalNumsize = (totalPage / (float)pageSize);
            int numSize = (int)Math.Ceiling(totalNumsize);
            if (page > numSize)
                page = numSize;

            ViewBag.pageCurrent = page;
            ViewBag.pageSize = pageSize;
            ViewBag.numSize = numSize;
            ViewBag.all = categorys;

            int start = (int)(page - 1) * pageSize;
            var dataCategory = categorys.Skip(start).Take(pageSize);
            return Json(new { all = categorys, data = dataCategory, pageCurrent = page, numSize = numSize, pageSize = pageSize }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetById(int id)
        {
            var category = categoryService.GetEditCategoryById(id);
            return Json(category, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Create(CreateCategoryViewModel category)
        {
            var response = categoryService.Create(category);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Edit(EditCategoryViewModel category)
        {
            var response = categoryService.Edit(category);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Delete(int id)
        {
            var category = categoryService.GetDeleteCategoryById(id);
            var response = categoryService.Delete(category);

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