import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { ConfigService } from '../ConfigService/config.service';

@Injectable({
  providedIn: 'root'
})
export class ApiBaseRequestService {

  protected httpClient = inject(HttpClient)
  protected configService = inject(ConfigService)

  protected get baseUrl(): string {
    return this.configService.getAPIs().tosAPI;
  }
}
