import { Component } from '@angular/core';
import { BankAccountModel } from './model/bank-account';
import { BankaccountService } from './service/bankaccount.service';
import { ErrorService } from '../service/error.service';
import { NgForm } from '@angular/forms';
import { AdminDecodeService } from '../login/service/admin-decode.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-bankaccounts',
  templateUrl: './bankaccounts.component.html',
  styleUrls: ['./bankaccounts.component.scss']
})
export class BankaccountsComponent {

  userId:number;

  bankAccount: BankAccountModel = new BankAccountModel();
  bankAccounts: BankAccountModel[] = [];
  constructor(
    private bankAccountService: BankaccountService,
    private errorService: ErrorService,
    private decodeService: AdminDecodeService,
    private toastr: ToastrService
  ) { }

  ngOnInit(){
    this.getAll();
    this.userId = this.decodeService.getUserId();
  }

  getAll() {
    this.bankAccountService.getAll().subscribe((res: any) => {
      this.bankAccounts = res.data;
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  add(addForm:NgForm){
    this.bankAccount.userId = this.userId;
    this.bankAccount.bankName = addForm.value.bankName;
    this.bankAccount.iban = addForm.value.iban;
    this.bankAccount.balance = 0;
    
    this.bankAccountService.add(this.bankAccount).subscribe((res:any)=>{
      this.toastr.success(res.message);
      this.getAll();
      addForm.reset();
    },(err)=>{
      this.errorService.errorHandler(err);
    })
  }

  delete(bankAccount: BankAccountModel) {
    this.bankAccountService.delete(bankAccount).subscribe((res:any)=>{
      this.toastr.info(res.message);
      this.getAll();
    },(err)=>{
      this.errorService.errorHandler(err);
    })
  }
}
