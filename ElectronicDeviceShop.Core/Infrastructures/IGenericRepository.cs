using ElectronicDeviceShop.Models.EntityBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Core.Infrastructures
{
    public interface IGenericRepository<T> where T : class , IBaseEntity
    {
        void Add(T entity);
        void Update(T entity);
        void Delete(T entity, bool isHardDelete = false);
        void Delete(int key, bool isHardDelete = false);
        IEnumerable<T> GetAll();
        T GetById(int key);
        IEnumerable<T> Find(Func<T, bool> condition);

    }
}
