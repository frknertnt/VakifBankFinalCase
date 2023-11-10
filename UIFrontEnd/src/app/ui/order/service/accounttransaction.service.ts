import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { TransferModel } from '../model/transfer-model';
import { PayCardModel } from '../model/pay-card-model';

@Injectable({
  providedIn: 'root'
})
export class AccounttransactionService {

  constructor(
    @Inject('apiUrl') private apiUrl: string,
    private httpClient: HttpClient
  ) { }

  transfer(tranferModel:TransferModel){
    let api = this.apiUrl + 'AccountTransactions/Transfer';
    return this.httpClient.post(api,tranferModel);
  }
  payWithCard(payCardModel:PayCardModel){
    let api = this.apiUrl + 'CustomerCardTransactions/PayWithCard';
    return this.httpClient.post(api,payCardModel);
  }
}
