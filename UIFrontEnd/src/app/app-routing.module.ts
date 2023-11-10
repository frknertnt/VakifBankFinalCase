import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LayoutsComponent } from './ui/layouts/layouts.component';
import { HomeComponent } from './ui/home/home.component';
import { BasketComponent } from './ui/basket/basket.component';
import { DetailComponent } from './ui/home/detail/detail.component';
import { LoginComponent } from './ui/login/login.component';
import { OrderDetailComponent } from './ui/order/order-detail/order-detail.component';
import { OrderComponent } from './ui/order/order.component';
import { BankaccountsComponent } from './ui/bankaccounts/bankaccounts.component';
import { MessageComponent } from './ui/message/message.component';

const routes: Routes = [
  {
    path: '',
    component: LayoutsComponent,
    children: [
      {
        path: '',
        component: HomeComponent,
        loadChildren: ()=> import("./ui/home/home.module").then(m=> m.HomeModule)
      },
      {
        path: 'detail/:id',
        component: DetailComponent,
        loadChildren: ()=> import("./ui/home/detail/detail.module").then(m=> m.DetailModule)
      },
      {
        path: 'order',
        component: OrderComponent,
        loadChildren: ()=> import("./ui/order/order.module").then(m=> m.OrderModule)
      },
      {
        path: 'order-detail/:id',
        component: OrderDetailComponent,
        loadChildren: ()=> import("./ui/order/order-detail/order-detail.module").then(m=> m.OrderDetailModule)
      },
      {
        path: 'bankaccount',
        component: BankaccountsComponent,
        loadChildren: ()=> import("./ui/bankaccounts/bankaccounts.module").then(m=> m.BankaccountsModule)
      },
      {
        path: 'message',
        component: MessageComponent,
        loadChildren: ()=> import("./ui/message/message.module").then(m=> m.MessageModule)
      },
      {
        path: 'basket',
        component: BasketComponent,
        loadChildren: ()=> import("./ui/basket/basket.module").then(m=> m.BasketModule)
      },
      {
        path: 'login',
        component: LoginComponent,
        loadChildren: ()=> import("./ui/login/login.module").then(m=> m.LoginModule)
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
