using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.Services.Accounts;
using ElectronicDeviceShop.Services.BillDetails;
using ElectronicDeviceShop.Services.Bills;
using ElectronicDeviceShop.Services.Products;
using ElectronicDeviceShop.ViewModels.Accounts;
using ElectronicDeviceShop.ViewModels.Bills;
using ElectronicDeviceShop.ViewModels.Products;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDeviceShop.Web.Controllers
{
    public class AccountController : Controller
    {
        private readonly IAccountService accountService;
        private readonly IBillService billService;
        private readonly IProductService productService;
        private readonly IBillDetailService billDetailService;
        private readonly int pageSize = 4;

        public AccountController(IAccountService accountService, IBillService billService, IBillDetailService billDetailService, IProductService productService)
        {
            this.accountService = accountService;
            this.billService = billService;
            this.billDetailService = billDetailService;
            this.productService = productService;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Register()
        {
            return View();
        }
        public ActionResult Detail()
        {
            if (Session["ID_Account"] != null)
            {
                int id = int.Parse(Session["ID_Account"].ToString());
                if (id > 0)
                {
                    var account = accountService.GetDetailAccountById(id);
                    if (account.Role == 2)
                    {
                        if (account.Phone != null)
                            account.Phone = account.Phone.Trim(' ');
                        return View(account);
                    }
                    else
                        return RedirectToAction("Index", "Account");
                }
                else
                    return RedirectToAction("Index", "Account");
            }
            else
                return RedirectToAction("Index", "Account");
        }
        public JsonResult Create(CreateAccountViewModel account)
        {
            var response = accountService.Create(account);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        public JsonResult CheckUserName(CreateAccountViewModel account)
        {
            var response = accountService.CheckUserName(account);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        public JsonResult CheckPassword(EditAccountViewModel account)
        {
            var response = accountService.CheckPassword(account);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        public JsonResult LoginUser(LoginViewModel account)
        {
            ResponseResult response = new ResponseResult();
            var oldAccount = accountService.GetAccountByUserName(account.UserName);
            if (oldAccount == null || oldAccount.Role != 2)
                response = new ResponseResult("Lỗi!");
            else
                response = accountService.Login(account);
            if (response.IsSuccessed)
            {
                Session["ID_Account"] = accountService.GetAll().Where(a => a.UserName == account.UserName).FirstOrDefault().ID_Account;
                Session["RoleAcc"] = 2;
            }
            return Json(new { newUrl = Url.Action("Index", "Home"), response = response.IsSuccessed }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Logout()
        {
            Session["ID_Account"] = -1;
            return Json(new ResponseResult().IsSuccessed, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetById(int id)
        {
            var account = accountService.GetEditAccountById(id);
            return Json(account, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Edit(EditAccountViewModel account)
        {
            account.Password = accountService.GetAccountByUserName(account.UserName).Password;
            account.Role = 2;
            var response = accountService.Edit(account);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ChangePass(EditAccountViewModel account)
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


        public JsonResult GetNewOrder(string txtSearch, int? page)
        {
            int id = int.Parse(Session["ID_Account"].ToString());
            var bills = billService.GetDetailBillByStatus(Status.NewOrders).Where(b => b.ID_Account == id);
            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;

                bills = bills.Where(s => s.ReceiverName.ToLower().Contains(txtSearch.ToLower()));
            }

            if (page <= 0)
                page = 1;
            int totalPage = bills.Count();
            float totalNumsize = (totalPage / (float)pageSize);
            int numSize = (int)Math.Ceiling(totalNumsize);
            if (page > numSize)
                page = numSize;

            ViewBag.pageCurrent = page;
            ViewBag.pageSize = pageSize;
            ViewBag.numSize = numSize;
            ViewBag.all = bills;

            int start = (int)(page - 1) * pageSize;
            var dataBill = bills.Skip(start).Take(pageSize);
            return Json(new { all = bills, data = dataBill, pageCurrent = page, numSize = numSize, pageSize = pageSize }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetConfirmOrder(string txtSearch, int? page)
        {
            int id = int.Parse(Session["ID_Account"].ToString());
            var bills = billService.GetDetailBillByStatus(Status.ConfirmOrders).Where(b => b.ID_Account == id);
            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;
                bills = bills.Where(s => s.ReceiverName.ToLower().Contains(txtSearch.ToLower()));
            }

            if (page <= 0)
                page = 1;
            int totalPage = bills.Count();
            float totalNumsize = (totalPage / (float)pageSize);
            int numSize = (int)Math.Ceiling(totalNumsize);
            if (page > numSize)
                page = numSize;

            ViewBag.pageCurrent = page;
            ViewBag.pageSize = pageSize;
            ViewBag.numSize = numSize;
            ViewBag.all = bills;

            int start = (int)(page - 1) * pageSize;
            var dataBill = bills.Skip(start).Take(pageSize);
            return Json(new { all = bills, data = dataBill, pageCurrent = page, numSize = numSize, pageSize = pageSize }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetShippingOrder(string txtSearch, int? page)
        {
            int id = int.Parse(Session["ID_Account"].ToString());
            var bills = billService.GetDetailBillByStatus(Status.ShippingOrders).Where(b => b.ID_Account == id);
            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;
                bills = bills.Where(s => s.ReceiverName.ToLower().Contains(txtSearch.ToLower()));
            }

            if (page <= 0)
                page = 1;
            int totalPage = bills.Count();
            float totalNumsize = (totalPage / (float)pageSize);
            int numSize = (int)Math.Ceiling(totalNumsize);
            if (page > numSize)
                page = numSize;

            ViewBag.pageCurrent = page;
            ViewBag.pageSize = pageSize;
            ViewBag.numSize = numSize;
            ViewBag.all = bills;

            int start = (int)(page - 1) * pageSize;
            var dataBill = bills.Skip(start).Take(pageSize);
            return Json(new { all = bills, data = dataBill, pageCurrent = page, numSize = numSize, pageSize = pageSize }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetSuccessOrder(string txtSearch, int? page)
        {
            int id = int.Parse(Session["ID_Account"].ToString());
            var bills = billService.GetDetailBillByStatus(Status.SuccessOrders).Where(b => b.ID_Account == id);
            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;
                bills = bills.Where(s => s.ReceiverName.ToLower().Contains(txtSearch.ToLower()));
            }

            if (page <= 0)
                page = 1;
            int totalPage = bills.Count();
            float totalNumsize = (totalPage / (float)pageSize);
            int numSize = (int)Math.Ceiling(totalNumsize);
            if (page > numSize)
                page = numSize;

            ViewBag.pageCurrent = page;
            ViewBag.pageSize = pageSize;
            ViewBag.numSize = numSize;
            ViewBag.all = bills;

            int start = (int)(page - 1) * pageSize;
            var dataBill = bills.Skip(start).Take(pageSize);
            return Json(new { all = bills, data = dataBill, pageCurrent = page, numSize = numSize, pageSize = pageSize }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetCancelOrder(string txtSearch, int? page)
        {
            int id = int.Parse(Session["ID_Account"].ToString());
            var bills = billService.GetDetailBillByStatus(Status.CancelOrders).Where(b => b.ID_Account == id);
            if (!String.IsNullOrEmpty(txtSearch))
            {
                ViewBag.txtSearch = txtSearch;
                bills = bills.Where(s => s.ReceiverName.ToLower().Contains(txtSearch.ToLower()));
            }

            if (page <= 0)
                page = 1;
            int totalPage = bills.Count();
            float totalNumsize = (totalPage / (float)pageSize);
            int numSize = (int)Math.Ceiling(totalNumsize);
            if (page > numSize)
                page = numSize;

            ViewBag.pageCurrent = page;
            ViewBag.pageSize = pageSize;
            ViewBag.numSize = numSize;
            ViewBag.all = bills;

            int start = (int)(page - 1) * pageSize;
            var dataBill = bills.Skip(start).Take(pageSize);
            return Json(new { all = bills, data = dataBill, pageCurrent = page, numSize = numSize, pageSize = pageSize }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetBillById(int id)
        {
            var bill = billService.GetEditBillById(id);
            var billDetail = billDetailService.GetDetailBillDetailByBill(bill.ID_Bill);
            var product = new List<ProductDetailViewModel>();
            foreach (var item in billDetail)
            {
                product.Add(productService.GetDetailProductById(item.ID_Product));
            }

            return Json(new { bill = bill, billDetail = billDetail, product = product }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult CancelBill(EditBillViewModel bill)
        {
            var oldBill = billService.GetEditBillById(bill.ID_Bill);
            oldBill.Status = Status.CancelOrders;
            var response = billService.Edit(oldBill);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
    }
}