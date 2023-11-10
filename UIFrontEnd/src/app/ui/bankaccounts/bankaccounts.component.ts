import { Component } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ErrorService } from '../service/error.service';
import { BankAccountModel } from './model/bankaccount';
import { BankaccountService } from './service/bankaccount.service';
import { DecodeService } from '../login/service/decode.service';
import { CardModel } from './model/card-model';

@Component({
  selector: 'app-bankaccounts',
  templateUrl: './bankaccounts.component.html',
  styleUrls: ['./bankaccounts.component.scss']
})
export class BankaccountsComponent {
  customerId: number;
  isOpen: boolean = false;
  isOpenTwo: boolean = false;

  bankAccount: BankAccountModel = new BankAccountModel();
  card: CardModel = new CardModel();

  bankAccounts: BankAccountModel[] = [];
  cards: CardModel[] = [];


  constructor(
    private bankAccountService: BankaccountService,
    private errorService: ErrorService,
    private decodeService: DecodeService,
    private toastr: ToastrService
  ) { }

  ngOnInit() {
    this.customerId = this.decodeService.getCustomerId();
    this.getAll();
  }

  openAccountModal() {
    this.isOpen=true;
    console.log(this.isOpen);
  }
  openCardModal() {
    this.isOpenTwo=true;
    console.log(this.isOpen);
  }
  closeAccountModal(){
    this.isOpen=false;
  }
  closeCardModal(){
    this.isOpenTwo=false;
  }

  getAll() {
    this.bankAccountService.getAllCardByCustomerId(this.customerId).subscribe((res: any) => {
      this.cards = res.data;
    }, (err) => {
      this.errorService.errorHandler(err);
    })

    this.bankAccountService.getAllAccountsByCustomerId(this.customerId).subscribe((res: any) => {
      this.bankAccounts = res.data;
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  addAccount(addForm: NgForm) {
    this.bankAccount.customerId = this.customerId;
    this.bankAccount.bankName = addForm.value.bankName;
    this.bankAccount.iban = addForm.value.iban;
    this.bankAccount.balance = addForm.value.balance;

    this.bankAccountService.addAccount(this.bankAccount).subscribe((res: any) => {
      this.toastr.success(res.message);
      this.getAll();
      addForm.reset();
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  addCard(addForm: NgForm){
    this.card.customerId = this.customerId;
    this.card.cardHolder = addForm.value.cardHolder;
    this.card.cardNumber = addForm.value.cardNumber;
    this.card.cvv = addForm.value.cvv;
    this.card.limit = addForm.value.limit;

    this.bankAccountService.addCard(this.card).subscribe((res:any)=>{
      this.toastr.success(res.message);
      this.getAll();
      addForm.reset();
    },(err)=>{
      this.errorService.errorHandler(err);
    })
  }

  deleteAccount(bankAccount: BankAccountModel) {
    this.bankAccountService.deleteAccount(bankAccount).subscribe((res: any) => {
      this.toastr.info(res.message);
      this.getAll();
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }
  deleteCard(card: CardModel) {
    this.bankAccountService.deleteCard(card).subscribe((res: any) => {
      this.toastr.info(res.message);
      this.getAll();
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }
}
