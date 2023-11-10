using Core.DataAccess;
using DataAccess.Repository;
using Entities.Concrete;

namespace Core.Uow;

public interface IEFUnitOfWork
{
    void Complete();
    void CompleteTransaction();

}