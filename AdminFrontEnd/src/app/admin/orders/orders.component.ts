import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';

import { OrderModel } from './model/order-model';
import { OrderService } from './service/order.service';
import { ErrorService } from '../service/error.service';
import { HelperService } from '../service/helper.service';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.scss']
})
export class OrdersComponent implements OnInit {

  orders: OrderModel[] = [];
  order: OrderModel = new OrderModel();

  statusText: string = "Tümü";
  filterText: string = "";

  constructor(
    private orderService: OrderService,
    private errorService: ErrorService,
    private toastr: ToastrService,
    private helperService: HelperService
  ) { }

  ngOnInit(): void {
    this.getList();
  }
//Sipariş Durumu	Tarih	Sipariş Numarası	Müşteri Adı	Sipariş Adedi	Toplam Tutar	Ödeme Durumu	İşlemler
//2023-11-10T20:12:26.617

  exportExcel(){
    const filteredData = this.orders.map(order => ({
      'Sipariş Durumu':order.status,
      'Tarih':order.date.substring(0,10) +' '+order.date.substring(11,19),
      'Sipariş Numarası':order.orderNumber,
      'Müşteri Adı': order.customerName,
      'Sipariş Adedi':order.quantity,
      'Toplam Tutar': `${order.total} ₺`,
      'Ödeme Durumu': order.isPaid ? 'Ödendi' : 'Ödenmedi',
    }));
    let title = "Ürünler";
    this.helperService.exportExcel(filteredData, title);
  }

  getList(){
    this.orderService.getList().subscribe((res: any)=>{
      this.orders = res.data;
      console.log(this.orders);
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

  update(order: OrderModel, status: string){
    order.status = status;

    this.orderService.update(order).subscribe((res: any)=>{
      this.toastr.info(res.message);
      this.getList();
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

  getStatus(event: any){
    console.log(this.statusText)
  }

}
