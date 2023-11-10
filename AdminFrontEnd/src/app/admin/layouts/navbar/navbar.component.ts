import { Component } from '@angular/core';
import { AuthService } from '../../login/service/auth.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent {
/**
 *
 */
constructor(
  private authService: AuthService
) { }

  ngOnInit():void{

  }

  logout(){
    this.authService.logout();
  }

}
