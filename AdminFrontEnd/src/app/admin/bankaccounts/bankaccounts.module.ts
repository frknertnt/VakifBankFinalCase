import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BankaccountsComponent } from './bankaccounts.component';
import { BankaccountPipe } from './pipe/bankaccount.pipe';
import { FormsModule } from '@angular/forms';
import { SweetAlert2Module } from '@sweetalert2/ngx-sweetalert2';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    component: BankaccountsComponent
  }
]

@NgModule({
  declarations: [
    BankaccountsComponent,
    BankaccountPipe
  ],
  imports: [
    CommonModule,
    FormsModule,
    SweetAlert2Module,
    RouterModule.forChild(routes)
  ],
  exports: [
    BankaccountsComponent
  ]
})
export class BankaccountsModule { }
