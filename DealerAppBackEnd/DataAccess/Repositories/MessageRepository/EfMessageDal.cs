using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.DataAccess.EntityFramework;
using Entities.Concrete;
using DataAccess.Repositories.MessageRepository;
using DataAccess.Context.EntityFramework;

namespace DataAccess.Repositories.MessageRepository
{
    public class EfMessageDal : EfEntityRepositoryBase<Message, DealerContextDb>, IMessageDal
    {
        public bool IsAnswered(int senderId, int receiverId)
        {
            using (var context = new DealerContextDb())
            {
                try
                {
                    var result = context.Messages.Where(m => m.ReceiverId == receiverId && m.SenderId == senderId).OrderByDescending(m => m.Id).FirstOrDefault();
                    if (result.IsAdmin)
                    {
                        return false;
                    }
                    return true;
                }
                catch (Exception)
                {

                    return false;
                }
            }

        }
    }
}
