import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MessageComponent } from './message.component';
import { RouterModule, Routes } from '@angular/router';
import { SweetAlert2Module } from '@sweetalert2/ngx-sweetalert2';
import { FormsModule } from '@angular/forms';
import { MessagePipe } from './pipe/message.pipe';
import { OrderModule } from '../order/order.module';

const routes: Routes = [
  {
    path:'',
    component:MessageComponent
  }
]

@NgModule({
  declarations: [
    MessageComponent,
    MessagePipe
  ],
  imports: [
    CommonModule,
    FormsModule,
    RouterModule.forChild(routes),
    SweetAlert2Module,
    
  ],
  exports:[
    MessageComponent,
    
  ]
})
export class MessageModule { }
