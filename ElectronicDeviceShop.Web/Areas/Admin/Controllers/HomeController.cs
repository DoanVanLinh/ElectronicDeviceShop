using ElectronicDeviceShop.Services.Accounts;
using ElectronicDeviceShop.ViewModels.Accounts;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ElectronicDeviceShop.Web.Areas.Admin.Controllers
{
    public class HomeController : Controller
    {
        private readonly IAccountService accountService;
        public HomeController(IAccountService accountService)
        {
            this.accountService = accountService;
        }
        // GET: Admin/Home
        public ActionResult Index()
        {
            return View();
        }
        public JsonResult Login(LoginViewModel account)
        {
            ResponseResult response = new ResponseResult();
            var oldAccount = accountService.GetAccountByUserName(account.UserName);
            if (oldAccount == null || oldAccount.Role == 2)
                response = new ResponseResult("Lỗi!");
            else
                response = accountService.Login(account);
            if (response.IsSuccessed)
            {
                var accountAd = accountService.GetAll().Where(a => a.UserName == account.UserName).FirstOrDefault();
                HttpContext.Session.Add("USER", accountAd.UserName);
                HttpContext.Session.Add("Role", GetNameRole(accountAd.Role));
                Session["ID_Account"] = accountAd.ID_Account;
                Session["RoleAcc"] = accountAd.Role;
            }
            return Json(new { newUrl = Url.Action("Index", "Statistic"), response = response.IsSuccessed }, JsonRequestBehavior.AllowGet);

        }
        string GetNameRole(int role)
        {
            switch (role)
            {
                case 0:
                    return "Admin";
                case 1:
                    return "Staff";
                case 2:
                    return "User";
                default:
                    return "";
            }
        }

        [ChildActionOnly]
        public ActionResult _PartialAccount()
        {
            int id = int.Parse(Session["ID_Account"].ToString());
            var account = accountService.GetDetailAccountById(id);
            return PartialView(account);
        }
        [ChildActionOnly]
        public ActionResult _SideBar()
        {
            return PartialView();
        }


    }
}