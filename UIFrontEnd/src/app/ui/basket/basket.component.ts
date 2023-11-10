import { Component, OnInit } from '@angular/core';
import { BasketService } from './service/basket.service';
import { ErrorService } from '../service/error.service';
import { ToastrService } from 'ngx-toastr';
import { DecodeService } from '../login/service/decode.service';
import { BasketModel } from './model/basket-model';
import { OrderService } from '../order/service/order.service';

@Component({
  selector: 'app-basket',
  templateUrl: './basket.component.html',
  styleUrls: ['./basket.component.scss']
})
export class BasketComponent implements OnInit {

  baskets: BasketModel[] = [];

  customerId: number = 0;
  total: number = 0;

  constructor(
    private basketService: BasketService,
    private errorService: ErrorService,
    private toastr: ToastrService,
    private decodeService: DecodeService,
    private orderService:OrderService
  ) { }

  ngOnInit(): void {
    this.getCustomerId();
  }

  getCustomerId() {
    this.customerId = this.decodeService.getCustomerId();
    this.getList();
  }

  getList() {
    this.basketService.getList(this.customerId).subscribe((res: any) => {
      this.baskets = res.data;
      this.getTotal();
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

  delete(basket:BasketModel){
    this.basketService.delete(basket).subscribe((res) => {
      this.toastr.success("Ürün sepetten kaldırıldı");
      this.getList();
      location.reload();
    }, (err) => {
      this.errorService.errorHandler(err);
    })
  }

 updateQuantity(basketId:any,isIncrease:boolean){
    this.basketService.updateQuantity(basketId,isIncrease).subscribe((res:any)=>{
      this.getList();
    },(err)=>{
      this.errorService.errorHandler(err);
    });
    
 }

  getTotal(){
    this.total = 0;
    this.baskets.forEach(p => {
      this.total = this.total + p.total;
    });
  }

  createOrder(){
    this.orderService.add(this.customerId).subscribe((res:any)=>{
      this.toastr.success("Sipariş oluşturuldu");
      this.getList();
      location.reload();
    },(err)=>{
      this.errorService.errorHandler(err);
    })
  }

}
