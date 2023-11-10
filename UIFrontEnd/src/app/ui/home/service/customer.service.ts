import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {

  constructor(
    @Inject('apiUrl') private apiUrl: string,
    private httpClient: HttpClient
  ) { }

  getDtoById(customerId: number) {
    let api = this.apiUrl + 'Customers/GetDtoById/' + customerId;
    return this.httpClient.get(api);
  }
}
