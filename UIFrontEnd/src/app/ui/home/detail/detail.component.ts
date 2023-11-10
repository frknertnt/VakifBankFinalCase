import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../login/service/auth.service';
import { ActivatedRoute } from '@angular/router';
import { ProductimageService } from './service/productimage.service';
import { ProductImageModel } from './model/product-image-model';
import { ErrorService } from '../../service/error.service';
import { ProductModel } from '../model/product-model';
import { ProductService } from '../service/product.service';
import { DecodeService } from '../../login/service/decode.service';
import { BasketModel } from '../../basket/model/basket-model';
import { BasketService } from '../../basket/service/basket.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-detail',
  templateUrl: './detail.component.html',
  styleUrls: ['./detail.component.scss']
})
export class DetailComponent implements OnInit {

  productImages: ProductImageModel[] = [];
  product: ProductModel = new ProductModel();
  products: ProductModel[] = []
  

  isAuth: boolean = false;

  productId: number = 0;
  customerId:number =  0;
  quantity: number  = 1;

  constructor(
    private authService: AuthService,
    private activatedRoute: ActivatedRoute,
    private productImageService: ProductimageService,
    private errorService: ErrorService,
    private productService: ProductService,
    private decodeService: DecodeService,
    private basketService: BasketService,
    private toastr: ToastrService
  ) { }

  ngOnInit(): void {
    this.activatedRoute.params.subscribe((res: any) => {
      this.productId = res.id
      this.getCustomerId();
      this.getProduct();
      this.productImageService.getList(this.productId).subscribe((res:any)=>{
        this.productImages = res.data;
      },(err)=>{
        this.errorService.errorHandler(err);
      });
    })
    this.isAuth = this.authService.isAuth();
  }

  getCustomerId(){
    this.customerId =this.decodeService.getCustomerId();
  }

  getProduct(){
    this.productService.getList(this.customerId).subscribe((res:any)=>{
      this.products = res.data;
      this.product = this.products.filter(p=>p.id == this.productId)[0];
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

  addBasket(){
    let model: BasketModel = new BasketModel();
    model.customerId = this.customerId;
    model.id =  0;
    model.price  = (this.product.discount > 0 ? (this.product.price * (100-this.product.discount))/100 : this.product.price);
    model.quantity = this.quantity;
    model.productId = this.product.id;

    this.quantity = 1;

    this.basketService.add(model).subscribe((res)=>{
      this.toastr.success("Ürün eklemesi başarılı");
      location.reload();
    },(err)=>{
      this.errorService.errorHandler(err);
    })
  }
}
