import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'bankaccountPipe'
})
export class BankaccountPipe implements PipeTransform {

  transform(value: string): string {
    return 'TR' + value.replace(/(.{4})/g, '$1-'); // En sondaki fazladan tireyi kaldırır
  }

}
