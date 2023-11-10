using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities.Concrete;
using Core.Utilities.Result.Abstract;

namespace Business.Repositories.MessageRepository
{
    public interface IMessageService
    {
        Task<IResult> Add(Message message);
        Task<IResult> Update(Message message);
        Task<IResult> Delete(Message message);
        Task<IDataResult<List<Message>>> GetList();
        Task<IDataResult<Message>> GetById(int id);
        bool IsAnswered(int senderId, int receiverId);
    }
}
