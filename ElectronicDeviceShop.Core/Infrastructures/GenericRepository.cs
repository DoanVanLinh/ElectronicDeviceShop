using ElectronicDeviceShop.Models.EntityBase;
using ElectronicDeviceShop.Models.Enums;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ElectronicDeviceShop.Core.Infrastructures
{
    public abstract class GenericRepository<T> : IGenericRepository<T> where T : class, IBaseEntity
    {
        protected readonly ElectronicDeviceShopContext context;
        protected DbSet<T> dbSet;

        protected GenericRepository(ElectronicDeviceShopContext context)
        {
            this.context = context;
            this.dbSet = context.Set<T>();
        }

        public void Add(T entity)
        {
            this.dbSet.Add(entity);
        }

        public void Delete(T entity, bool isHardDelete = false)
        {
            if (!isHardDelete)
            {
                this.context.Entry<T>(entity).State = EntityState.Modified;
                entity.Status = Status.IsDeleted;
                return;

            }
            this.dbSet.Remove(entity);
        }

        public void Delete(int key, bool isHardDelete = false)
        {
            Delete(GetById(key), isHardDelete);
        }

        public IEnumerable<T> Find(Func<T, bool> condition)
        {
            return this.dbSet.AsNoTracking().Where(condition);
        }

        public IEnumerable<T> GetAll()
        {
            return this.dbSet.AsNoTracking().ToList();
        }

        public T GetById(int key)
        {
            return this.dbSet.Find(key);
        }

        public void Update(T entity)
        {
            context.Entry(entity).State = EntityState.Modified;
        }
    }
}
