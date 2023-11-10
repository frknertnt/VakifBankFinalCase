import { Component } from '@angular/core';
import { ProductService } from './service/product.service';
import { ErrorService } from '../service/error.service';
import { ProductModel } from './model/product-model';
import { ToastrService } from 'ngx-toastr';
import { NgForm } from '@angular/forms';
import { HelperService } from '../service/helper.service';
import { ExcelProductModel } from './model/excel-product-model';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent {
  product: ProductModel = new ProductModel();
  products: ProductModel[] = [];
  filterText: string = "";

  excelProduct: ExcelProductModel[]=[];

  constructor(
    private productService: ProductService,
    private errorService: ErrorService,
    private toastr: ToastrService,
    private helperService: HelperService
  ) { }

  ngOnInit() {
    this.getList();
  }

  exportExcel() {
    const filteredData = this.products.map(product => ({
      'Ürün Adı': product.name,
      'Stok': product.stock
    }));
    let title = "Ürünler";
    this.helperService.exportExcel(filteredData, title);
  }

  getList() {
    this.productService.getList().subscribe
      ((res: any) => {
        this.products = res.data;
        this.excelProduct = res.data;
      }, (err) => {
        this.errorService.errorHandler(err);
      })
  }

  delete(product: ProductModel) {
    this.productService.delete(product).subscribe((res: any) => {
      this.toastr.info(res.message);
      this.getList();
    }, (err) => {
      this.errorService.errorHandler(err)
    }
    )
  }

  add(addForm: NgForm) {
    let product: ProductModel = new ProductModel();
    product.name = addForm.value.productName;
    product.stock = addForm.value.productStock;
    product.id = 0;

    this.productService.add(product).subscribe((res: any) => {
      this.toastr.success(res.message);
      this.getList();
      addForm.reset();
    }, (err) => {
      this.errorService.errorHandler(err);
    }
    )
  }

  getProduct(product: ProductModel) {
    this.productService.getById(product.id).subscribe((res: any) => {
      this.product = res.data;
    }, (err) => {
      this.errorService.errorHandler(err);
    });
  }

  update() {
    this.productService.update(this.product).subscribe((res: any) => {
      this.toastr.success(res.message);
      this.getList();
      document.getElementById("updateModelCloseBtn").click();
    }, (err) => {
      this.errorService.errorHandler(err);
    });
  }
}
