import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  constructor(
    @Inject('apiUrl') private apiUrl:string,
    private httpClient: HttpClient
  ) { }

  getUserAccounts(){
    let api = this.apiUrl + 'UserAccounts/GetList';
    return this.httpClient.get(api);
  }

  getUsers(){
    let api = this.apiUrl + 'Users/GetList';
    return this.httpClient.get(api);
  }
}
