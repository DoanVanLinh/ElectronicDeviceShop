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
using ElectronicDeviceShop.ViewModels.Accounts;

namespace ElectronicDeviceShop.Services.Accounts
{
    public class AccountService : IAccountService
    {
        private readonly IUnitOfWork unitOfWork;
        public AccountService(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }
        public ResponseResult Create(CreateAccountViewModel request)
        {
            try
            {
                var oldAccount = unitOfWork.AccountRepository.GetAll().Where(a => a.UserName == request.UserName).FirstOrDefault();
                if (oldAccount != null)
                    throw new Exception("Tài khoản đã tồn tại!");
                var account = Mapper.Map<Account>(request);
                account.Status = Status.Active;
                this.unitOfWork.AccountRepository.Add(account);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public ResponseResult Delete(DeleteAccountViewModel request)
        {
            try
            {
                var account = Mapper.Map<Account>(request);
                this.unitOfWork.AccountRepository.Delete(account.ID_Account);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public ResponseResult Edit(EditAccountViewModel request)
        {
            try
            {
                var account = Mapper.Map<Account>(request);
                account.Status = Status.Active;
                this.unitOfWork.AccountRepository.Update(account);
                this.unitOfWork.SaveChange();
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public IEnumerable<AccountViewModel> GetAll()
        {
            var accounts = this.unitOfWork.AccountRepository.GetAll().Where(p => p.Status != Status.IsDeleted);
            return Mapper.Map<IEnumerable<AccountViewModel>>(accounts);
        }

        public EditAccountViewModel GetEditAccountById(int id)
        {
            var account = this.unitOfWork.AccountRepository.GetAll().Where(p => p.Status != Status.IsDeleted&& p.ID_Account == id).FirstOrDefault();
            return Mapper.Map<EditAccountViewModel>(account);
        }
        public DeleteAccountViewModel GetDeleteAccountById(int id)
        {
            var account = unitOfWork.AccountRepository.GetById(id);
            return Mapper.Map<DeleteAccountViewModel>(account);
        }
        public AccountDetailViewModel GetDetailAccountById(int id)
        {
            var account = unitOfWork.AccountRepository.GetById(id);
            return Mapper.Map<AccountDetailViewModel>(account);
        }
        public ResponseResult Login(LoginViewModel request)
        {
            try
            {
                var account = GetAccountByUserName(request.UserName);
                if (account == null || account.Password != request.Password)
                    throw new Exception("Sai TK!");
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public LoginViewModel GetAccountByUserName(string userName)
        {
            var account = unitOfWork.AccountRepository.GetAll().Where(a => a.UserName == userName && a.Status != Status.IsDeleted).FirstOrDefault();
            return Mapper.Map<LoginViewModel>(account);
        }

        public ResponseResult CheckUserName(CreateAccountViewModel request)
        {
            try
            {
                var account = Mapper.Map<Account>(GetAll().Where(a=>a.UserName == request.UserName).FirstOrDefault());
                if (account != null)
                    throw new Exception("Tài khoản đã tồn tại!");
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }
        public ResponseResult CheckPassword(EditAccountViewModel request)
        {
            try
            {
                var account = Mapper.Map<Account>(GetDetailAccountById(request.ID_Account));
                if (account.Password != request.Password)
                    throw new Exception("Mật khẩu không đúng!");
                return new ResponseResult();
            }
            catch (Exception ex)
            {
                return new ResponseResult(ex.Message);
            }
        }

        public AccountDetailViewModel GetNewestAccount()
        {
            var account = this.unitOfWork.AccountRepository.GetAll().Where(p => p.Status != Status.IsDeleted && p.ID_Account == GetAll().Max(a => a.ID_Account)).FirstOrDefault();
            return Mapper.Map<AccountDetailViewModel>(account);
        }
    }
}
