using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDeviceShop.Web.Areas.Admin.Filters
{
    public class CustomAuthorize : AuthorizeAttribute
    {
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            var user = HttpContext.Current.Session["USER"];
            if (user != null)
            {
                var role = HttpContext.Current.Session["ROLE"];
                if (role != null || role.ToString() != "User")
                {
                    if (!Roles.Split(',').Contains(role.ToString()))
                    {
                        filterContext.Result = new RedirectResult("/Admin/");
                    }

                }
            }
            else
            {
                filterContext.Result = new RedirectResult("/Admin/");
            }

        }
    }
}