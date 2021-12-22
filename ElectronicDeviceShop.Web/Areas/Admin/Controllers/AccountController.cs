using ElectronicDeviceShop.Common;
using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.Services.Accounts;
using ElectronicDeviceShop.Services.Categories;
using ElectronicDeviceShop.Services.PermissionDetails;
using ElectronicDeviceShop.Services.Permissions;
using ElectronicDeviceShop.ViewModels.Accounts;
using ElectronicDeviceShop.ViewModels.Categories;
using ElectronicDeviceShop.ViewModels.PermissionDetails;
using ElectronicDeviceShop.ViewModels.Results;
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
    public class AccountController : Controller
    {
        private readonly IAccountService accountService;
        private readonly IPermissionService permissionService;
        private readonly IPermissionDetailService permissionDetailService;
        private readonly PermissionHelper permissionHelper;
        private readonly int pageSize = 4;
        public AccountController(IAccountService accountService, IPermissionService permissionService, IPermissionDetailService permissionDetailService)
        {
            this.accountService = accountService;
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
            return permissionHelper.CheckPermission(id, "ACCOUNTS");
        }
        public JsonResult Logout()
        {
            Session["ID_Account"] = -1;
            return Json(new ResponseResult().IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetPermissionById(int idAccount)
        {
            var permission = permissionService.GetAllPermission();
            List<PermissionDetailDetailViewModel> permissionDetails = new List<PermissionDetailDetailViewModel>();
            foreach (var item in permission)
            {
                var permissionDetail = permissionDetailService.GetDetailPermissionDetailByIdAccountIdPermission(idAccount, item.ID_Permission);
                permissionDetails.Add(permissionDetail);
            }
            return Json(new { permission = permission, permissionDetail = permissionDetails }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetAll(string txtSearch, int? page)
        {
            var accounts = accountService.GetAll();
            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;
                accounts = accounts.Where(s => s.UserName.ToLower().Contains(txtSearch.ToLower()) ||
                                                s.Email.ToLower().Contains(txtSearch.ToLower()));
            }

            if (page <= 0)
                page = 1;
            int totalPage = accounts.Count();
            float totalNumsize = (totalPage / (float)pageSize);
            int numSize = (int)Math.Ceiling(totalNumsize);
            if (page > numSize)
                page = numSize;

            ViewBag.pageCurrent = page;
            ViewBag.pageSize = pageSize;
            ViewBag.numSize = numSize;
            ViewBag.all = accounts;

            int start = (int)(page - 1) * pageSize;
            var dataAccount = accounts.Skip(start).Take(pageSize);
            return Json(new { all = accounts, data = dataAccount, pageCurrent = page, numSize = numSize, pageSize = pageSize }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetById(int id)
        {
            var account = accountService.GetEditAccountById(id);
            return Json(account, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Create(CreateAccountViewModel account)
        {
            var response = accountService.Create(account);
            var accountNewest = accountService.GetNewestAccount();

            if (response.IsSuccessed&&accountNewest.Role !=2)
            {
                var allPermission = permissionService.GetAllPermission();
                foreach (var item in allPermission)
                {
                    PermissionDetailDetailViewModel permissionDetail = new PermissionDetailDetailViewModel();
                    permissionDetail.ID_Permission = item.ID_Permission;
                    permissionDetail.ID_Account = accountNewest.ID_Account;
                    var response2 = permissionDetailService.Create(permissionDetail);
                    if (!response2.IsSuccessed)
                    {
                        response = new ResponseResult("Lỗi");
                        break;
                    }
                }
                return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult EditPermission(PermissionDetailDetailViewModel permissionDetail)
        {
            var perDetail = permissionDetailService.GetDetailPermissionDetailByIdAccountIdPermission(permissionDetail.ID_Account, permissionDetail.ID_Permission);
            permissionDetail.ID_PermissionDetail = perDetail.ID_PermissionDetail;
            var response = permissionDetailService.Edit(permissionDetail);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Delete(int id)
        {
            var account = accountService.GetDeleteAccountById(id);
            var response = accountService.Delete(account);

            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Profile()
        {
            int id = int.Parse(Session["ID_Account"].ToString());
            var account = accountService.GetDetailAccountById(id);
            return View(account);
        }
        public JsonResult CheckPassword(EditAccountViewModel account)
        {
            var response = accountService.CheckPassword(account);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Edit(EditAccountViewModel account)
        {
            account.Password = accountService.GetAccountByUserName(account.UserName).Password;
            var response = accountService.Edit(account);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ChangePassword(EditAccountViewModel account)
        {
            var acc = accountService.GetEditAccountById(int.Parse(Session["ID_Account"].ToString()));
            acc.Password = account.Password;
            var response = accountService.Edit(acc);
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