import { Component } from '@angular/core';
import { CustomerService } from './service/customer.service';
import { CustomerModel } from './model/customer.model';
import { PriceListModel } from '../price-lists/model/price-list-model';
import { ErrorService } from '../service/error.service';
import { HelperService } from '../service/helper.service';
import { ToastrService } from 'ngx-toastr';
import { PriceListService } from '../price-lists/service/price-list.service';
import { NgForm } from '@angular/forms';
import { CustomerRelationshipModel } from './model/customer-relationship-model';

@Component({
  selector: 'app-customers',
  templateUrl: './customers.component.html',
  styleUrls: ['./customers.component.scss']
})
export class CustomersComponent {

  customers: CustomerModel[] = [];
  customer: CustomerModel = new CustomerModel();
  priceLists: PriceListModel[] = [];

  filterText: string = "";
  newPassword: string = "";

  constructor(
    private customerService: CustomerService,
    private errorService: ErrorService,
    private toastr: ToastrService,
    private helperService: HelperService,
    private priceListService: PriceListService
  ) { }

  ngOnInit(): void {
    this.getList();
    this.getPriceList();
  }

//Bayi Adı	Mail Adresi	Fiyat Listesi	İskonto Oranı
  exportExcel(){
     const filteredData = this.customers.map(customer => ({
      'Bayi Adı': customer.name,
      'Bayi Mail': customer.email,
      'Bayi Fiyat Listesi': customer.priceListName,
      'İskonto':`${customer.discount} %`,
    }));
    let title = "Ürünler";
    this.helperService.exportExcel(filteredData, title);
  }

  getList(){
    this.customerService.getList().subscribe((res: any)=>{
      this.customers = res.data;
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

  getPriceList(){
    this.priceListService.getList().subscribe((res: any)=>{
      this.priceLists = res.data;
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

  delete(customer: CustomerModel){
    this.customerService.delete(customer).subscribe((res: any)=>{
      this.toastr.info(res.message)
      this.getList();
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

  add(addForm: NgForm){
    let customer: CustomerModel = new CustomerModel();
    customer.name = addForm.value.name;
    customer.email = addForm.value.email;
    customer.password = addForm.value.password;

    this.customerService.add(customer).subscribe((res: any)=>{
      this.toastr.success(res.message);
      this.getList();
      addForm.reset();
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }


  getCustomer(customer: CustomerModel){
    this.customerService.getDtoById(customer.id).subscribe((res: any)=>{
      this.customer = res.data;
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

  update(){
    this.customerService.update(this.customer).subscribe((res: any)=>{
      this.toastr.success(res.message);
      this.getList();
      document.getElementById("updateModelCloseBtn").click();
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

  updateRelationship(){
    let model: CustomerRelationshipModel = new CustomerRelationshipModel();
    model.customerId = this.customer.id;
    model.priceListId = this.customer.priceListId;
    model.discount = this.customer.discount;

    this.customerService.updateRelationship(model).subscribe((res: any)=>{
      this.toastr.info(res.message);
      this.getList();
      document.getElementById("updateRelationshipModelCloseBtn").click();
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

  changePassword(){
    let model: CustomerModel = new CustomerModel();
    model.id = this.customer.id;
    model.password = this.newPassword;

    this.customerService.changePasswordByAdminPanel(model).subscribe((res: any)=>{
      this.toastr.info(res.message);
      this.getList();
      document.getElementById("updatePasswordModelCloseBtn").click();
    },(err)=>{
      this.errorService.errorHandler(err);
    });
  }

}
