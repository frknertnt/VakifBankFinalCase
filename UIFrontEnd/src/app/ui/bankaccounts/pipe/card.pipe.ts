import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'cardPipe'
})
export class CardPipe implements PipeTransform {

  transform(value: string): string {
    return value.replace(/(.{4})/g, '$1-').slice(0,19); // En sondaki fazladan tireyi kaldırır
  }

}
