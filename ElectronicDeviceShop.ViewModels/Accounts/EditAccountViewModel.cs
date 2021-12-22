using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.ViewModels.Accounts
{
    public class EditAccountViewModel
    {
        public int ID_Account { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(30)]
        [Display(Name = "Tên tài khoản")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(30)]
        [Display(Name = "Mật khẩu")]
        public string Password { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(255)]
        [Display(Name = "Họ và tên")]
        public string FullName { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(10)]
        [Display(Name = "Số điện thoại")]
        public string Phone { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(255)]
        [Display(Name = "Địa chỉ")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(255)]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [StringLength(255)]
        [Display(Name = "Ảnh đại diện")]
        public string Avatar { get; set; }

        [Required(ErrorMessage = "Không được để trống")]
        [Display(Name = "Vai trò")]
        public int Role { get; set; }
    }
}
