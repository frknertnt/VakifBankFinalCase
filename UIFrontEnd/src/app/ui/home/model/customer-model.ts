export class CustomerModel{
    id:number;
    email:string;
    name:string;
    discount:number;
    priceListId:number;
    priceListName:string;
}




// Id = customer.Id,
// Email = customer.Email,
// Name = customer.Name,
// PasswordHash = customer.PasswordHash,
// PasswordSalt = customer.PasswordSalt,
// Discount =
// (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id) != null
// ? context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id).Select(s => s.Discount).FirstOrDefault()
// : 0),
// PriceListId =
// (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id) != null
// ? context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id).Select(s => s.PriceListId).FirstOrDefault()
// : 0),
// PriceListName =
// (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id) != null
// ? context.PriceLists.Where(p => p.Id == (context.CustomerRelationShips.Where(p => p.CustomerId == customer.Id).Select(s => s.PriceListId).FirstOrDefault())).Select(s => s.Name).FirstOrDefault()
// : "")