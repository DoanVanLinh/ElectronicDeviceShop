using ElectronicDeviceShop.ViewModels.Accounts;
using ElectronicDeviceShop.ViewModels.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.Accounts
{
    public interface IAccountService
    {
        ResponseResult Create(CreateAccountViewModel request);
        ResponseResult Edit(EditAccountViewModel request);
        ResponseResult Delete(DeleteAccountViewModel request);
        ResponseResult Login(LoginViewModel request);
        ResponseResult CheckUserName(CreateAccountViewModel request);
        ResponseResult CheckPassword(EditAccountViewModel request);


        IEnumerable<AccountViewModel> GetAll();
        EditAccountViewModel GetEditAccountById(int id);
        DeleteAccountViewModel GetDeleteAccountById(int id);
        AccountDetailViewModel GetDetailAccountById(int id);
        LoginViewModel GetAccountByUserName(string userName);
        AccountDetailViewModel GetNewestAccount();
    }
}
