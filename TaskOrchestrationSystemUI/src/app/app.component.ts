// import { AsyncPipe } from '@angular/common';
import { Component } from '@angular/core';
// import { AuthService } from '@auth0/auth0-angular';
// import { OrganizationService } from './services/OrganizationService/organization.service';
// import {MatButtonModule} from '@angular/material/button';
// import { MainPageComponent } from "./pages/main-page/main-page.component";
import { RouterOutlet } from '@angular/router';
@Component({
  selector: 'app-root',
  imports: [
    RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  // auth = inject(AuthService)
  // organizationService = inject(OrganizationService)
  // clickedButton() {
  //   this.auth.user$.subscribe((user)=> {console.log(user)})
  // }

  // getOrganizations() {
  //   this.organizationService.getOrganizations().subscribe((organizations)=>{
  //     console.log("ORGANIZATIONS",organizations)
  //   })
  // }

  // getActiveOrganizations() {
  //   this.organizationService.getActiveOrganizations().subscribe((organizations)=>{
  //     console.log("ACTIVE ORGANIZATIONS",organizations)
  //   })
  // }
}
