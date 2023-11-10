import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { ProductImageModel } from '../model/product-images-model';

@Injectable({
  providedIn: 'root'
})
export class ProductImagesService {

  constructor(
    @Inject("apiUrl") private apiUrl: string,
    private httpClient: HttpClient
  ) { }

  getList(productId: number){
    let api = this.apiUrl + "ProductImages/GetListByProductId/" + productId;
    return this.httpClient.get(api);
  }

  add(formData:any){
    let api = this.apiUrl + "ProductImages/Add";
    return this.httpClient.post(api,formData);
  }
  delete(productImage:ProductImageModel){
    let api = this.apiUrl + "ProductImages/Delete";
    return this.httpClient.post(api,productImage);
  }

  setMainImage(id: number){
    let api = this.apiUrl + "ProductImages/SetMainImage/" + id;
    return this.httpClient.get(api);
  }
}
