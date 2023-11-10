import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LayoutsModule } from './layouts/layouts.module';
import { HomeModule } from './home/home.module';
import { OrderModule } from './order/order.module';
import { BasketModule } from './basket/basket.module';
import { LoginModule } from './login/login.module';
import { BankaccountsModule } from './bankaccounts/bankaccounts.module';
import { MessageModule } from './message/message.module';



@NgModule({
  declarations: [
  ],
  imports: [
    CommonModule,
    LayoutsModule,
    HomeModule,
    OrderModule,
    BasketModule,
    LoginModule,
    BankaccountsModule,
    MessageModule
  ],
  exports: [
    LayoutsModule,
    HomeModule,
    OrderModule,
    BasketModule,
    LoginModule,
    BankaccountsModule,
    MessageModule
  ]
})
export class UiModule { }
