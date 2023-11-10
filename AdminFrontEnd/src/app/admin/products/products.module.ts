import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProductsComponent } from './products.component';
import { RouterModule, Routes } from '@angular/router';
import { SweetAlert2Module } from '@sweetalert2/ngx-sweetalert2';
import { FormsModule } from '@angular/forms';
import { ProductPipe } from './pipe/product.pipe';
import { ProductImagesModule } from './product-images/product-images.module';

const routes: Routes = [
  {
    path:'',//kök bir yolda talep edildiğinde göster
    component:ProductsComponent
  }
]

@NgModule({
  declarations: [
    ProductsComponent,
    ProductPipe
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),//lazy loading
    FormsModule,
    SweetAlert2Module.forRoot(),
    ProductImagesModule
  ],
  exports:[
    ProductsComponent,
    ProductImagesModule
  ]
})
export class ProductsModule { }
