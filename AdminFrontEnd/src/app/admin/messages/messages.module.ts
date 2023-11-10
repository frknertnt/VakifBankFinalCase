import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MessagesComponent } from './messages.component';
import { MessagePipe } from './pipe/message.pipe';
import { FormsModule } from '@angular/forms';
import { RouterModule, Routes } from '@angular/router';
import { SweetAlert2Module } from '@sweetalert2/ngx-sweetalert2';

const routes: Routes = [
  {
    path:'',
    component:MessagesComponent
  }
]

@NgModule({
  declarations: [
    MessagesComponent,
    MessagePipe
  ],
  imports: [
    CommonModule,
    FormsModule,
    RouterModule.forChild(routes),
    SweetAlert2Module
  ],
  exports:[
    MessagesComponent
  ]
})
export class MessagesModule { }
