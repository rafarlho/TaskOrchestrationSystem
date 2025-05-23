import { ApplicationConfig, provideAppInitializer, provideZoneChangeDetection, inject } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideAuth0, AuthClientConfig, authHttpInterceptorFn } from '@auth0/auth0-angular';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { ConfigService } from './services/ConfigService/config.service';
import { routes } from './app.routes';
import { tap } from 'rxjs';

export function configInitializerFactory() {
  const configService = inject(ConfigService);
  const authClientConfig = inject(AuthClientConfig);

  return configService.loadConfig()
}

export const appConfig: ApplicationConfig = {
  providers: [
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes),
    ConfigService,
    provideAuth0({
      domain: 'dev-8d83f63muen50v2p.us.auth0.com',
      clientId: 'GWn4IlA7r1RXaErWaiyeWyJZNT9BfCGS',
      authorizationParams: {
        redirect_uri: window.location.origin,
        audience: 'https://tos/api'  
      },
      httpInterceptor: {
        allowedList: [
          {
            uri: 'https://localhost:44354/*',
            tokenOptions: {
              authorizationParams: {
                audience: 'https://tos/api' 
              }
            }
          }
        ]
      }
    }),
    provideAppInitializer(configInitializerFactory),
    provideHttpClient(withInterceptors([authHttpInterceptorFn])),
  ],
};
