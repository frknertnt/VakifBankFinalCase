import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { BankAccountModel } from '../model/bankaccount';
import { CardModel } from '../model/card-model';

@Injectable({
  providedIn: 'root'
})
export class BankaccountService {

  constructor(
    @Inject('apiUrl') private apiUrl: string,
    private httpClient: HttpClient
  ) { }

  getAllAccountsByCustomerId(id: number) {
    let api = this.apiUrl + 'CustomerAccounts/GetListByCustomerId/' + id;
    return this.httpClient.get(api);
  }

  addAccount(bankAccount: BankAccountModel) {
    let api = this.apiUrl + 'CustomerAccounts/Add';
    return this.httpClient.post(api, bankAccount);
  }

  deleteAccount(bankAccount: BankAccountModel) {
    let api = this.apiUrl + 'CustomerAccounts/Delete';
    return this.httpClient.post(api, bankAccount);
  }

  getAllCardByCustomerId(id: number) {
    let api = this.apiUrl + 'CustomerCards/GetListByCustomerId/' + id;
    return this.httpClient.get(api);
  }

  addCard(card: CardModel) {
    let api = this.apiUrl + 'CustomerCards/Add';
    return this.httpClient.post(api, card);
  }

  deleteCard(card:CardModel){
    let api = this.apiUrl + 'CustomerCards/Delete';
    return this.httpClient.post(api, card);
  }

}
