using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.Services.Accounts;
using ElectronicDeviceShop.Services.BillDetails;
using ElectronicDeviceShop.Services.Bills;
using ElectronicDeviceShop.Services.Carts;
using ElectronicDeviceShop.Services.Products;
using ElectronicDeviceShop.ViewModels.BillDetails;
using ElectronicDeviceShop.ViewModels.Bills;
using ElectronicDeviceShop.ViewModels.Carts;
using ElectronicDeviceShop.ViewModels.Products;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDeviceShop.Web.Controllers
{
    public class BillController : Controller
    {
        private readonly IProductService productService;
        private readonly ICartService cartService;
        private readonly IBillService billService;
        private readonly IBillDetailService billDetailService;
        private readonly IAccountService accountService;
        static IEnumerable<CartViewModel> cart;
        static List<ProductDetailViewModel> product = new List<ProductDetailViewModel>(); 

        public BillController(IProductService productService, ICartService cartService, IBillService billService, IAccountService accountService, IBillDetailService billDetailService)
        {
            this.productService = productService;
            this.cartService = cartService;
            this.billService = billService;
            this.accountService = accountService;
            this.billDetailService = billDetailService;
        }
        public ActionResult Index()
        {
            if (Session["ID_Account"] != null)
            {
                if (int.Parse(Session["ID_Account"].ToString()) > 0)
                {
                    cart = cartService.GetCartByAccount(int.Parse(Session["ID_Account"].ToString()));
                    return View();
                }
                else
                    return RedirectToAction("Index", "Account");
            }
            else
                return RedirectToAction("Index", "Account");
        }
        public JsonResult GetAllProductInCart()
        {
            product.Clear();
            int id = int.Parse(Session["ID_Account"].ToString());
            cart = cartService.GetCartByAccount(id);
            foreach (var item in cart)
            {
                product.Add(productService.GetAllDetail().Where(p => p.ID_Product == item.ID_Product).FirstOrDefault());
            }
            var account = accountService.GetDetailAccountById(id);
            return Json(new { cart = cart, product = product, account = account }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Create(CreateBillViewModel bill)
        {
            var response = billService.Create(bill);
            foreach (var item in cart)
            {
                var billNewest = billService.GetBillNewest();
                CreateBillDetailViewModel billDetail = new CreateBillDetailViewModel();
                billDetail.ID_Bill = billNewest.ID_Bill;
                billDetail.ID_Product = item.ID_Product;
                billDetail.Amount = item.Amount;
                var product = productService.GetDetailProductById(item.ID_Product);
                billDetail.CurrentlyPrice = item.Amount * product.Price*(100- product.Discount)/100;
                billDetail.Status = Status.Active;
                if (!billDetailService.Create(billDetail).IsSuccessed)
                {
                    response = new ResponseResult("Lỗi!");
                    billNewest.Status = 0;
                    billService.Edit(billNewest);
                    break;
                }
            }
            foreach (var item in cart)
            {
                var oldCart = cartService.GetEditCartById(item.ID_Cart);
                oldCart.Amount = 0;
                cartService.Edit(oldCart);
            }

            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Edit(EditCartViewModel cart)
        {
            var response = cartService.Edit(cart);
            return Json(response.IsSuccessed, JsonRequestBehavior.AllowGet);
        }

    }
}