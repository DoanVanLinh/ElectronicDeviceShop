using ElectronicDeviceShop.Common;
using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.Services.BillDetails;
using ElectronicDeviceShop.Services.Bills;
using ElectronicDeviceShop.Services.PermissionDetails;
using ElectronicDeviceShop.Services.Permissions;
using ElectronicDeviceShop.Services.Products;
using ElectronicDeviceShop.ViewModels.Bills;
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
    public class BillController : Controller
    {
        private readonly IBillService billService;
        private readonly IProductService productService;
        private readonly IBillDetailService billDetailService;
        private readonly IPermissionService permissionService;
        private readonly IPermissionDetailService permissionDetailService;
        private readonly PermissionHelper permissionHelper;
        private readonly int pageSize = 4;
        public BillController(IBillService billService, IProductService productService, IBillDetailService billDetailService, IPermissionService permissionService, IPermissionDetailService permissionDetailService)
        {
            this.billService = billService;
            this.billDetailService = billDetailService;
            this.productService = productService;
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
            return permissionHelper.CheckPermission(id, "BILLS");
        }
        public JsonResult GetNewOrder(string txtSearch, int? page)
        {
            var bills = billService.GetDetailBillByStatus(Status.NewOrders);
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
            var bills = billService.GetDetailBillByStatus(Status.ConfirmOrders);
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
            var bills = billService.GetDetailBillByStatus(Status.ShippingOrders);
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
            var bills = billService.GetDetailBillByStatus(Status.SuccessOrders);
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
            var bills = billService.GetDetailBillByStatus(Status.CancelOrders);
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
        public JsonResult GetById(int id)
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
        [CustomAuthorize(Roles = "Admin,Staff")]
        public ActionResult Edit(EditBillViewModel bill)
        {
            var response = billService.Edit(bill);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
    }
}