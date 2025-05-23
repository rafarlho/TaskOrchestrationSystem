import { Injectable } from '@angular/core';
import { ApiBaseRequestService } from '../ApiRequestBaseService/api-base-request.service';

@Injectable({
  providedIn: 'root'
})
export class OrganizationService extends ApiBaseRequestService {

  readonly organizationController : string = "organization/"

  getOrganizations(){
    return this.httpClient.get(this.baseUrl + this.organizationController)
  }

  getActiveOrganizations(){
    return this.httpClient.get(this.baseUrl + this.organizationController + "active")
  }
}
