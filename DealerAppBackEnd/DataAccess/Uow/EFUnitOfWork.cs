using Core.DataAccess;
using Core.DataAccess.EntityFramework;
using Core.Uow;
using DataAccess.Context.EntityFramework;
using DataAccess.Repository;
using Entities.Concrete;


namespace DataAccess.Uow;

public class EFUnitOfWork : IEFUnitOfWork
{
    private readonly DealerContextDb dbContext;

    public EFUnitOfWork(DealerContextDb dbContext)
    {
        this.dbContext = dbContext;

    }

    public void Complete()
    {
        dbContext.SaveChanges();
    }

    public void CompleteTransaction()
    {
        using (var transaction = dbContext.Database.BeginTransaction())
        {
            try
            {
                dbContext.SaveChanges();
                transaction.Commit();
            }
            catch (Exception ex)
            {
                transaction.Rollback();
            }
        }
    }
}