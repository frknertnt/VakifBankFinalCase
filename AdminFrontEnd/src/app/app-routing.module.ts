import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LayoutsComponent } from './admin/layouts/layouts.component';
import { LoginComponent } from './admin/login/login.component';
import { AuthGuard } from './admin/login/guard/auth.guard';
import { ProductsComponent } from './admin/products/products.component';
import { ProductImagesComponent } from './admin/products/product-images/product-images.component';
import { PriceListsComponent } from './admin/price-lists/price-lists.component';
import { PriceListDetailComponent } from './admin/price-lists/price-list-detail/price-list-detail.component';
import { CustomersComponent } from './admin/customers/customers.component';
import { OrdersComponent } from './admin/orders/orders.component';
import { OrderDetailComponent } from './admin/orders/order-detail/order-detail.component';
import { ProfileComponent } from './admin/profile/profile.component';
import { MessagesComponent } from './admin/messages/messages.component';
import { BankaccountsComponent } from './admin/bankaccounts/bankaccounts.component';

//Ana routing yeri
//Uygulamanın ana adresine (kök yol '')gidildiğinde LayoutsComponent bileşenini göster ve bu bileşenin içerisindeki 
//<router-outlet> için HomeComponent bileşenini göster. Ayrıca, HomeComponent ilk defa talep edildiğinde, 
//bu bileşeni içeren HomeModule'ü tembel yükleme yöntemiyle yükle
const routes: Routes = [
  {
    path: 'admin-login',
    component: LoginComponent,
    loadChildren: () => import("./admin/login/login.module").then(m => m.LoginModule)
  },
  {
    path: '',
    component: LayoutsComponent,
    canActivateChild: [AuthGuard],
    children: [
      {
        path: '',
        children: [
          {
            path: '',
            component: OrdersComponent,
            loadChildren: () => import('./admin/orders/orders.module').then(m => m.OrdersModule)
          },
          {
            path: 'order-detail/:id',
            component: OrderDetailComponent,
            loadChildren: () => import('./admin/orders/order-detail/order-detail.module').then(m => m.OrderDetailModule)
          }
        ]
      },
      {
        path: 'products',
        children: [
          {
            path: '',
            component: ProductsComponent,
            loadChildren: () => import('./admin/products/products.module').then(m => m.ProductsModule)
          },
          {
            path: ':id/images',//products/1/images
            component: ProductImagesComponent,
            loadChildren: () => import('./admin/products/product-images/product-images.module').then(m => m.ProductImagesModule)
          }
        ]
      },
      {
        path: 'price-lists',
        children: [
          {
            path: '',
            component: PriceListsComponent,
            loadChildren: () => import("./admin/price-lists/price-lists.module").then(m => m.PriceListsModule)
          },
          {
            path: ':id',
            component: PriceListDetailComponent,
            loadChildren: () => import("./admin/price-lists/price-list-detail/price-list-detail.module").then(m => m.PriceListDetailModule)
          }
        ]
      },
      {
        path: 'customers',
        children: [
          {
            path: '',
            component: CustomersComponent,
            loadChildren: () => import('./admin/customers/customers.module').then(m => m.CustomersModule)
          }
        ]
      },
      {
        path:'messages',
        children:[
          {
            path:'',
            component:MessagesComponent,
            loadChildren: () => import('./admin/messages/messages.module').then(m=>m.MessagesModule)
          }
        ]
      },
      {
        path:'bankaccounts',
        children:[
          {
            path:'',
            component:BankaccountsComponent,
            loadChildren: () => import('./admin/bankaccounts/bankaccounts.module').then(m=>m.BankaccountsModule)
          }
        ]
      },
      {
        path: 'profile',
        component: ProfileComponent,
        loadChildren: () => import('./admin/profile/profile.module').then(m => m.ProfileModule)
      }

    ]
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
