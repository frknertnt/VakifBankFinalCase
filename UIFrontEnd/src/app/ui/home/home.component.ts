import { AfterContentChecked, Component, OnInit } from '@angular/core';
import { AuthService } from '../login/service/auth.service';
import { ProductService } from './service/product.service';
import { ErrorService } from '../service/error.service';
import { ProductModel } from './model/product-model';
import { DecodeService } from '../login/service/decode.service';
import { CustomerModel } from './model/customer-model';
import { CustomerService } from './service/customer.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit, AfterContentChecked {

  products: ProductModel[] = [];
  customers: CustomerModel = new CustomerModel();

  customerId: number = 0;
  filterText: string = "";

  isAuth: boolean = false;

  constructor(
    private productService: ProductService,
    private errorService: ErrorService,
    private decodeService: DecodeService,
    private authService:AuthService,
    private customerService: CustomerService
  ) { }

  ngOnInit(): void {
    this.getCustomerId();
    this.getCustomer();
  }

  ngAfterContentChecked(): void { // sayfada değişiklik olduğunda sayfayı kontrol ediyor
    this.isAuth = this.authService.isAuth();
  }

  getCustomerId(){
    this.customerId = this.decodeService.getCustomerId();
    this.getList();
  }

  getList() {
    this.productService.getList(this.customerId).subscribe((res:any)=>{
      this.products = res.data;
    },(err)=>{
      this.errorService.errorHandler(err);
    }
  )}

  getCustomer(){
    this.customerService.getDtoById(this.customerId).subscribe((res:any)=>{
      this.customers = res.data
    })
  }

}
