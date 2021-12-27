using AutoMapper;
using ElectronicDeviceShop.Core.Infrastructures;
using ElectronicDeviceShop.Models;
using ElectronicDeviceShop.Models.Enums;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ElectronicDeviceShop.ViewModels.Carts;
using System.Data.Entity;

namespace ElectronicDeviceShop.Services.Carts
{
    public class CartService : ICartService
    {
        private readonly IUnitOfWork unitOfWork;
        public CartService(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }
        public ResponseResult Edit(EditCartViewModel request)
        {
            try
            {
                var cart = Mapper.Map<Cart>(request);
                var oldProduct = this.unitOfWork.ProductRepository.GetAll().Where(p => p.ID_Product == cart.ID_Product).FirstOrDefault();
                if (oldProduct.Amount < cart.Amount)
                    return new ResponseResult("Vượt quá số lượng hàng hiện có!");
                this.unitOfWork.CartRepository.Update(cart);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public EditCartViewModel GetEditCartById(int id)
        {
            var cart = unitOfWork.CartRepository.GetAll().Where(c=>c.ID_Cart == id).FirstOrDefault();
            return Mapper.Map<EditCartViewModel>(cart);
        }
        public CartDetailViewModel GetDetailCartById(int id)
        {
            var cart = unitOfWork.CartRepository.GetById(id);
            return Mapper.Map<CartDetailViewModel>(cart);
        }

        public ResponseResult Create(CreateCartViewModel request)
        {
            try
            {
                var cart = Mapper.Map<Cart>(request);
                var oldCart = GetCartByAccount(cart.ID_Account).Where(c => c.ID_Product == cart.ID_Product).FirstOrDefault();
                
                var checkCart = Mapper.Map<Cart>(oldCart);

                if (checkCart != null)//da ton tai
                {
                    checkCart.Amount += cart.Amount;
                    var oldProduct = this.unitOfWork.ProductRepository.GetAll().Where(p => p.ID_Product == checkCart.ID_Product).FirstOrDefault();
                    if(oldProduct.Amount<checkCart.Amount)
                        return new ResponseResult("Vượt quá số lượng hàng hiện có!");
                    this.unitOfWork.CartRepository.Update(checkCart);
                }
                else
                {
                    this.unitOfWork.CartRepository.Add(cart);
                }
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }
        public IEnumerable<CartViewModel> GetCartByAccount(int id)
        {
            var cart = unitOfWork.CartRepository.GetAll().Where(c => c.ID_Account == id && c.Amount!=0 && c.Status != 0);
            return Mapper.Map<IEnumerable<CartViewModel>>(cart);
        }

        public ResponseResult Delete(DeleteCartViewModel request)
        {
            try
            {
                var cart = Mapper.Map<Cart>(request);
                this.unitOfWork.CartRepository.Delete(cart);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public DeleteCartViewModel GetDeleteCartById(int id)
        {
            var cart = unitOfWork.CartRepository.GetAll().Where(c => c.ID_Cart == id).FirstOrDefault();
            return Mapper.Map<DeleteCartViewModel>(cart);
        }
    }
}
