using ElectronicDeviceShop.ViewModels.Results;
using ElectronicDeviceShop.ViewModels.Products;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Services.Products
{
    public interface IProductService
    {
        ResponseResult Create(CreateProductViewModel request);
        ResponseResult Edit(EditProductViewModel request);
        ResponseResult Delete(DeleteProductViewModel request);

        IEnumerable<ProductViewModel> GetAll();
        IEnumerable<ProductDetailViewModel> GetAllDetail();
        EditProductViewModel GetEditProductById(int id);
        DeleteProductViewModel GetDeleteProductById(int id);
        ProductDetailViewModel GetDetailProductById(int id);
    }
}
