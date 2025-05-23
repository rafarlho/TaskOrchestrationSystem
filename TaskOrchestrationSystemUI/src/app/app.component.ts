import { AsyncPipe } from '@angular/common';
import { Component, inject } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { AuthService } from '@auth0/auth0-angular';
import { OrganizationService } from './services/OrganizationService/organization.service';

@Component({
  selector: 'app-root',
  imports: [AsyncPipe],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  auth = inject(AuthService)
  organizationService = inject(OrganizationService)
  clickedButton() {
    this.auth.user$.subscribe((user)=> {console.log(user)})
  }

  getOrganizations() {
    this.organizationService.getOrganizations().subscribe((organizations)=>{
      console.log("ORGANIZATIONS",organizations)
    })
  }

  getActiveOrganizations() {
    this.organizationService.getActiveOrganizations().subscribe((organizations)=>{
      console.log("ACTIVE ORGANIZATIONS",organizations)
    })
  }
}
