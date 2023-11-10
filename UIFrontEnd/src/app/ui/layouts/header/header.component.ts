import { AfterContentChecked, Component, OnInit } from '@angular/core';
import { AuthService } from '../../login/service/auth.service';
import { BasketService } from '../../basket/service/basket.service';
import { DecodeService } from '../../login/service/decode.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit, AfterContentChecked {

  isAuth: boolean = false;
  customerId:number;
  temp:number = 0;

  constructor(
    private authService: AuthService,
    private basketService: BasketService,
    private decodeService:DecodeService
  ) { }

  ngOnInit(): void {
    this.getCustomerId();
    this.productCount();
  }

  getCustomerId(){
    this.customerId = this.decodeService.getCustomerId()
  }

  ngAfterContentChecked(): void { // sayfada değişiklik olduğunda sayfayı kontrol ediyor
    this.isAuth = this.authService.isAuth();
  }

  logout(){
    this.authService.logout()
  }

  productCount(){
    this.basketService.getList(this.customerId).subscribe((res:any)=>{
      console.log(res.data.length)
      this.temp =  res.data.length;
    })
  }

}
