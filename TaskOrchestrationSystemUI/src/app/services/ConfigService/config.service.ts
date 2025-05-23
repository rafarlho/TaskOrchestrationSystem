import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { finalize, Observable, tap } from 'rxjs';
import { API, Auth0, ConfigSettings } from '../../models/ConfigSettings.model';
import { AuthClientConfig } from '@auth0/auth0-angular';

@Injectable({
  providedIn: 'root'
})
export class ConfigService {

    private readonly http = inject(HttpClient)
    private configSettings! : ConfigSettings  
    // private authClientConfig = inject(AuthClientConfig)

    loadConfig():Observable<ConfigSettings> {
      return this.http.get<ConfigSettings>('configs/config.json').pipe(
        tap(settings => this.configSettings = settings),
        // finalize(()=>this.setAuth0())
      )
    }

    getAPIs() : API  {
      return this.configSettings.api
    }

    getAuth0() : Auth0  {
      return this.configSettings.auth0
    }

    // setAuth0(): void {
    //   let authConfig: Auth0 = this.getAuth0() 
    //   this.authClientConfig.set({
    //     domain: authConfig.domain,
    //     clientId: authConfig.clientId,
    //     authorizationParams: {
    //       redirect_uri: window.location.origin,
    //       audience: 'https://dev-8d83f63muen50v2p.us.auth0.com/api/v2/',
    //     },
    //     httpInterceptor: {
    //     allowedList: [
    //     {
    //       uri: 'https://dev-8d83f63muen50v2p.us.auth0.com/api/v2/*',
    //       tokenOptions: {
    //         authorizationParams: {
    //           audience: 'https://dev-8d83f63muen50v2p.us.auth0.com/api/v2/',
    //         }
    //       }
    //           }
    //         ]
    //     }
    //   })
    // }
}

