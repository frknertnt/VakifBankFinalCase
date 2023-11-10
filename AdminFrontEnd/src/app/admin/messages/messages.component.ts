import { Component } from '@angular/core';
import { ViewChild, ElementRef, AfterViewChecked } from '@angular/core';
import { CustomerService } from '../customers/service/customer.service';
import { MessageService } from './service/message.service';
import { ErrorService } from '../service/error.service';
import { CustomerModel } from '../customers/model/customer.model';
import { MessageModel } from './model/message-model';
import { AdminDecodeService } from '../login/service/admin-decode.service';
import { NgForm } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { interval } from 'rxjs';



@Component({
  selector: 'app-messages',
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.scss']
})
export class MessagesComponent {


  @ViewChild('scrollMe') private myScrollContainer: ElementRef;


  scrollToBottom(): void {
    try {
      this.myScrollContainer.nativeElement.scrollTop = this.myScrollContainer.nativeElement.scrollHeight;
    } catch (err) { }
  }

  adminId = 0;

  customers: CustomerModel[] = [];
  customer: CustomerModel = new CustomerModel();

  messages: MessageModel[] = [];

  message: MessageModel = new MessageModel();

  temp:string='';

  filterText: string = "";
  request:any;

  constructor(
    private customerService: CustomerService,
    private messageService: MessageService,
    private errorService: ErrorService,
    private decodeService: AdminDecodeService,
    private toastr: ToastrService
  ) { }

  ngOnInit() {
    this.getCustomers();
    this.getAdminId();

  }

  getCustomers() {
    this.customerService.getList().subscribe((res: any) => {
      this.customers = res.data;

    })
  }

  getAdminId() {
    this.adminId = this.decodeService.getUserId();
  }

  messageLoop(customerId:any){
    this.getMessages(customerId);
    this.request = interval(4000).subscribe(() => {
      this.getMessages(customerId);
    });
  }

  closeLoop(){
    if (this.request) {
      this.request.unsubscribe(); // Abonelemeyi durdur
    }
  }

  getMessages(customerId: any) {
    this.scrollToBottom();
    this.messageService.getList().subscribe((res: any) => {
      this.messages = res.data;
      this.messages = this.messages.filter(p => p.senderId == this.adminId && p.receiverId == customerId)
      this.customer = this.customers.filter(p => p.id == customerId)[0];
    }, (err) => {
      this.errorService.errorHandler(err);
    })

  }

  sendMessage(addForm: NgForm) {
    this.message.content = addForm.value.content;
    this.message.receiverId = this.customer.id;
    this.message.senderId = this.adminId;
    this.message.isAdmin = true;

    this.messageService.add(this.message).subscribe((res: any) => {
      this.toastr.success(res.message);
      addForm.reset();
      this.getMessages(this.message.receiverId);
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  // getLastMessage(receiverId: any){
  //   let status = this.messageService.getLastMessage(this.adminId, receiverId).subscribe(res => {
  //     if (res == true) {
  //       console.log(res);
  //       this.temp = 'Okunmamış mesajınız var';
  //     }
  //     else{
  //       console.log(res);
  //       this.temp = 'Okunmamış mesaj yok';
  //     }
  //   })
  //   console.log(status);
  //   return this.temp
  // }
}
