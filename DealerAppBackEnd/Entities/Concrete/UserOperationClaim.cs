using Entities.Concrete.Base;

namespace Entities.Concrete
{
    public class UserOperationClaim : BaseEntity
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int OperationClaimId { get; set; }
    }
}
