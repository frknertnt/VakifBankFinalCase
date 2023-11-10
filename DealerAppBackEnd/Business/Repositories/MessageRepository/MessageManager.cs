using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Business.Repositories.MessageRepository;
using Entities.Concrete;
using Business.Aspects.Secured;
using Core.Aspects.Validation;
using Core.Aspects.Caching;
using Core.Aspects.Performance;
using Business.Repositories.MessageRepository.Validation;
using Business.Repositories.MessageRepository.Constants;
using Core.Utilities.Result.Abstract;
using Core.Utilities.Result.Concrete;
using DataAccess.Repositories.MessageRepository;

namespace Business.Repositories.MessageRepository
{
    public class MessageManager : IMessageService
    {
        private readonly IMessageDal _messageDal;

        public MessageManager(IMessageDal messageDal)
        {
            _messageDal = messageDal;
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(MessageValidator))]
        [RemoveCacheAspect("IMessageService.Get")]

        public async Task<IResult> Add(Message message)
        {
            await _messageDal.Add(message);
            return new SuccessResult(MessageMessages.Added);
        }

        [SecuredAspect()]
        [ValidationAspect(typeof(MessageValidator))]
        [RemoveCacheAspect("IMessageService.Get")]

        public async Task<IResult> Update(Message message)
        {
            await _messageDal.Update(message);
            return new SuccessResult(MessageMessages.Updated);
        }

        [SecuredAspect()]
        [RemoveCacheAspect("IMessageService.Get")]

        public async Task<IResult> Delete(Message message)
        {
            await _messageDal.Delete(message);
            return new SuccessResult(MessageMessages.Deleted);
        }

        [SecuredAspect()]
        [CacheAspect()]
        [PerformanceAspect()]
        public async Task<IDataResult<List<Message>>> GetList()
        {
            return new SuccessDataResult<List<Message>>(await _messageDal.GetAll());
        }

        [SecuredAspect()]
        public async Task<IDataResult<Message>> GetById(int id)
        {
            return new SuccessDataResult<Message>(await _messageDal.Get(p => p.Id == id));
        }

        public bool IsAnswered(int senderId, int receiverId)
        {
            return _messageDal.IsAnswered(senderId,receiverId);
        }
    }
}
