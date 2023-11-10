import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BankaccountsComponent } from './bankaccounts.component';
import { RouterModule, Routes } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { SweetAlert2Module } from '@sweetalert2/ngx-sweetalert2';
import { BankaccountPipe } from './pipe/bankaccount.pipe';
import { CardPipe } from './pipe/card.pipe';

const routes: Routes= [
  {
    path: '',
    component: BankaccountsComponent
  }
]

@NgModule({
  declarations: [
    BankaccountsComponent,
    BankaccountPipe,
    CardPipe
  ],
  imports: [
    CommonModule,
    FormsModule,
    SweetAlert2Module,
    RouterModule.forChild(routes),
  ],
  exports:[
    BankaccountsComponent
  ]
})
export class BankaccountsModule { }
