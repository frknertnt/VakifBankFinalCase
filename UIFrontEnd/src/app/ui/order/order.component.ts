import { Component, OnInit } from '@angular/core';
import { OrderService } from './service/order.service';
import { DecodeService } from '../login/service/decode.service';
import { ErrorService } from '../service/error.service';
import { OrderModel } from './model/order-model';
import { NgFor } from '@angular/common';
import { NgForm } from '@angular/forms';
import { BankaccountService } from '../bankaccounts/service/bankaccount.service';
import { BankAccountModel } from '../bankaccounts/model/bankaccount';
import { AdminService } from './service/admin.service';
import { AdminAccountModel } from './model/admin-model';
import { AccounttransactionService } from './service/accounttransaction.service';
import { TransferModel } from './model/transfer-model';
import { ToastrService } from 'ngx-toastr';
import { CardModel } from '../bankaccounts/model/card-model';
import { PayCardModel } from './model/pay-card-model';
@Component({
  selector: 'app-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.scss']
})
export class OrderComponent implements OnInit {

  customerId: number = 0;
  filterText: string = "";

  orders: OrderModel[] = [];
  bankAccounts: BankAccountModel[] = []
  adminAccounts: AdminAccountModel[] = []
  customerCards: CardModel[] = []
  transfer: TransferModel = new TransferModel();
  card: CardModel = new CardModel();
  payCardModel: PayCardModel = new PayCardModel();

  accountId: number = -1;
  adminAccountId: number = -1;
  moneyTransfer: number = 0;
  orderId: number = 0;
  customerCardId: number = -1;

  isOpen: boolean = false;

  constructor(
    private orderService: OrderService,
    private decoderService: DecodeService,
    private errorService: ErrorService,
    private bankAccountService: BankaccountService,
    private adminService: AdminService,
    private transferService: AccounttransactionService,
    private toastr: ToastrService
  ) { }

  ngOnInit(): void {
    this.getCustomerId();
    this.getCustomerAccounts();
    this.getCustomerCards();
    this.getAdminAccounts();//havale için iban bilgisi 
  }

  openOrCloseModal(orderId: number, orderTotal: number) { // Ödeme model sayfasını butonla açıp kapamak için
    this.moneyTransfer = orderTotal;
    this.orderId = orderId
    if (this.isOpen) {
      this.isOpen = false;
    }
    else {
      this.isOpen = true;
    }
  }

  getCustomerId() {
    this.customerId = this.decoderService.getCustomerId();
    this.getList();
  }

  getCustomerAccounts() { // müşterinin ödeme yapacağı hesaplar otomatik gelmesi için
    this.bankAccountService.getAllAccountsByCustomerId(this.customerId).subscribe((res: any) => {
      this.bankAccounts = res.data;
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  getCustomerCard(customerCardId:number) {
    let cardNumberInputElement = <HTMLInputElement>document.getElementById('cardNumber');
    let cardHolderNameInputElement = <HTMLInputElement>document.getElementById('cardHolder');
    let cardCvvInputElement = <HTMLInputElement>document.getElementById('cvv');

    let customerCards = this.customerCards.filter(f => f.id == customerCardId);
    this.card = customerCards[0];

    cardHolderNameInputElement.value = customerCards[0].cardHolder;
    cardNumberInputElement.value = customerCards[0].cardNumber;
    cardCvvInputElement.value = customerCards[0].cvv.toString();
  }

  getCustomerCards(){
    this.bankAccountService.getAllCardByCustomerId(this.customerId).subscribe((res:any)=>{
      this.customerCards = res.data;
    })
  }

  getAdminAccounts() { // hangi hesaba transfer yapılacağı bilgisi otomatik gelmesi için
    this.adminService.getUserAccounts().subscribe((res: any) => {
      this.adminAccounts = res.data;
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  getIban(accountId: number) { // sayfada müşteri hesap seçildiğinde seçilen hesaba ait ibanın otomatik gelmesi için
    let ibanInputElement = <HTMLInputElement>document.getElementById('iban');
    let account = this.bankAccounts.filter(f => f.id == accountId);
    ibanInputElement.value = account[0].iban;
  }

  getAdminIban(accountId: number) {// sayfada adminin hangi hesabı seçilmişse ibanı otomaik gelmesi için
    let ibanInputElement = <HTMLInputElement>document.getElementById('receiveriban');
    let account = this.adminAccounts.filter(f => f.id == this.adminAccountId);
    ibanInputElement.value = account[0].iban;
  }

  getList() {
    this.orderService.getListByCustomerIdDto(this.customerId).subscribe((res: any) => {
      this.orders = res.data;
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  

  delete(order: OrderModel) {
    this.orderService.delete(order).subscribe((res: any) => {
      this.getList();
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  payWithAccount() {
    this.transfer.senderAccountId = this.accountId;
    this.transfer.receiverAccountId = this.adminAccountId;
    this.transfer.amount = this.moneyTransfer;
    this.transfer.orderId = this.orderId;
    this.transferService.transfer(this.transfer).subscribe((res: any) => {
      this.toastr.success('Transfer Başarılı');
      this.getList();
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  payWithCard() {
    this.payCardModel.customerCardId = this.card.id;
    this.payCardModel.receiverAccountId = this.adminAccounts[0].id;
    this.payCardModel.amount = this.moneyTransfer;
    this.payCardModel.orderId = this.orderId;
    this.transferService.payWithCard(this.payCardModel).subscribe((res: any) => {
      this.toastr.success('Ödeme başarılı');
      this.getList();
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }
}
