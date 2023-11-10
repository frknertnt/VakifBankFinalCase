import { Component, ElementRef, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { CustomerModel } from '../home/model/customer-model';
import { CustomerService } from '../home/service/customer.service';
import { ErrorService } from '../service/error.service';
import { MessageModel } from './model/message-model';
import { MessageService } from './service/message.service';
import { DecodeService } from '../login/service/decode.service';
import { AdminService } from '../order/service/admin.service';
import { AdminModel } from './model/admin-model';
import { interval } from 'rxjs';

@Component({
  selector: 'app-message',
  templateUrl: './message.component.html',
  styleUrls: ['./message.component.scss']
})
export class MessageComponent {

  @ViewChild('scrollMe') private myScrollContainer: ElementRef;


  scrollToBottom(): void {
    try {
      this.myScrollContainer.nativeElement.scrollTop = this.myScrollContainer.nativeElement.scrollHeight;
    } catch (err) { }
  }


  customerId = 0;

  customers: CustomerModel[] = [];
  admins: AdminModel[] = [];
  customer: CustomerModel = new CustomerModel();

  messages: MessageModel[] = [];

  message: MessageModel = new MessageModel();
  istekAbone: any;

  temp: string = '';

  filterText: string = "";
  isOpen: boolean = false;
  adminId = 0;
  adminName: string;

  constructor(
    private messageService: MessageService,
    private errorService: ErrorService,
    private decodeService: DecodeService,
    private toastr: ToastrService,
    private adminService: AdminService
  ) { }

  ngOnInit() {
    this.getCustomerId();
    this.getAdmins();
  }

  openModal(adminId: any, name: string) {
    this.getMessages(adminId, name);
    this.isOpen = true;
    this.istekAbone = interval(4000).subscribe(() => {
      this.getMessages(adminId, name)
      console.log("tetikleme")
    });

  }
  closeModal() {
    this.isOpen = false;
    this.adminId = 0;
    if (this.istekAbone) {
      this.istekAbone.unsubscribe(); // Abonelemeyi durdur
    }
  }


  getCustomerId() {
    this.customerId = this.decodeService.getCustomerId();
  }

  getAdmins() {
    this.adminService.getUsers().subscribe((res: any) => {
      this.admins = res.data;
    })
  }

  getMessages(adminId: any, name: string) {
    this.adminId = adminId;
    this.adminName = name;

    this.scrollToBottom();
    this.messageService.getList().subscribe((res: any) => {
      this.messages = res.data;
      this.messages = this.messages.filter(p => p.senderId == adminId && p.receiverId == this.customerId)
      this.customer = this.customers.filter(p => p.id == this.customerId)[0];
      console.log(this.messages);
    }, (err) => {
      this.errorService.errorHandler(err);
    })

  }

  sendMessage(addForm: NgForm) {
    this.message.content = addForm.value.content;
    this.message.receiverId = this.customerId;
    this.message.senderId = this.adminId;
    this.message.isAdmin = false;

    this.messageService.add(this.message).subscribe((res: any) => {
      this.toastr.success(res.message);
      addForm.reset();
      this.getMessages(this.message.senderId, '');
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }
}
