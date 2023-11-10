import { Injectable } from '@angular/core';
import * as XLSX from 'xlsx';
@Injectable({
  providedIn: 'root'
})
export class HelperService {

  constructor() { }

  exportExcel(element: any, title: string) {
    const ws: XLSX.WorkSheet = XLSX.utils.json_to_sheet(element);//gönderilen elementi sayfaya dönüştür
    const wb: XLSX.WorkBook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'Sheet1');

    title = title + ".xlsx";
    XLSX.writeFile(wb, title);
  }
}
