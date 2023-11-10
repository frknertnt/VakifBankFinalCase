using Core.DataAccess;
using Entities.Concrete.Base;
using System.Linq.Expressions;

namespace DataAccess.Repository;

public interface IGenericRepository<TEntity> : IEntityRepository<TEntity> where TEntity : BaseEntity, new()
{
    
}
