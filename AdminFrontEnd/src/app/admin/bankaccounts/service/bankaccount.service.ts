import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { BankAccountModel } from '../model/bank-account';

@Injectable({
  providedIn: 'root'
})
export class BankaccountService {

  constructor(
    @Inject('apiUrl') private apiUrl: string,
    private httpClient: HttpClient
  ) { }


  getAll() {
    let api = this.apiUrl + 'UserAccounts/GetList';
    return this.httpClient.get(api);
  }

  add(bankAccount: BankAccountModel) {
    let api = this.apiUrl + 'UserAccounts/Add';
    return this.httpClient.post(api, bankAccount);
  }

  delete(bankAccount: BankAccountModel) {
    let api = this.apiUrl + 'UserAccounts/Delete';
    return this.httpClient.post(api, bankAccount);
  }
}
