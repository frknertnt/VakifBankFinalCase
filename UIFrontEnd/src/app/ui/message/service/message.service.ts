import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { MessageModel } from '../model/message-model';

@Injectable({
  providedIn: 'root'
})
export class MessageService {

  constructor(
    @Inject('apiUrl') private apiUrl:string,
    private httpClient: HttpClient
  ) { }


  add(messages:MessageModel){
    let api = this.apiUrl + 'Messages/Add';
    return this.httpClient.post(api, messages);
  }

  getList(){
    let api = this.apiUrl + 'Messages/GetList';
    return this.httpClient.get(api);
  }
}
