import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProductImagesComponent } from './product-images.component';
import { RouterModule, Routes } from '@angular/router';
import { SweetAlert2Module } from '@sweetalert2/ngx-sweetalert2';
import { FormsModule } from '@angular/forms';



const routes: Routes = [
  {
    path:'',
    component: ProductImagesComponent
  }
]

@NgModule({
  declarations: [
    ProductImagesComponent
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
    SweetAlert2Module,
    FormsModule
  ],
  exports:[
    ProductImagesComponent
  ]
})
export class ProductImagesModule { }
