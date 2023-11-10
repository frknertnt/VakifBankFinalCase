using System.Linq.Expressions;
using DataAccess.Context.EntityFramework;
using Entities.Concrete.Base;
using Microsoft.EntityFrameworkCore;


namespace DataAccess.Repository;

public class GenericRepository<TEntity> : IGenericRepository<TEntity> where TEntity : BaseEntity, new()
{
    private readonly DealerContextDb context;

    public GenericRepository(DealerContextDb dbContext)
    {
        this.context = dbContext;
    }

    public async Task Add(TEntity entity)
    {
        var addedEntity = context.Entry(entity);
        addedEntity.State = EntityState.Added;
        await context.SaveChangesAsync();
    }

    public async Task Delete(TEntity entity)
    {
        var addedEntity = context.Entry(entity);
        addedEntity.State = EntityState.Deleted;
        await context.SaveChangesAsync();
    }

    public async Task<TEntity> Get(Expression<Func<TEntity, bool>> filter)
    {
        return await context.Set<TEntity>().SingleOrDefaultAsync(filter);
    }

    public async Task<TEntity> GetFirst()
    {
        return await context.Set<TEntity>().FirstOrDefaultAsync();
    }

    public async Task<List<TEntity>> GetAll(Expression<Func<TEntity, bool>> filter = null)
    {
        return filter == null
            ? await context.Set<TEntity>().ToListAsync()
            : await context.Set<TEntity>().Where(filter).ToListAsync();
    }

    public async Task Update(TEntity entity)
    {
        var addedEntity = context.Entry(entity);
        addedEntity.State = EntityState.Modified;
        await context.SaveChangesAsync();
    }
}