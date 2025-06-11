import { Routes } from '@angular/router';
import { provideTranslocoScope } from '@jsverse/transloco';

export const routes: Routes = [
    {
        path: '', 
        pathMatch:"full",
        redirectTo:'main-page'
    },
    {
        path: 'main-page', 
        loadComponent: () => import('./pages/main-page/main-page.component').then(c => c.MainPageComponent),
        providers : [
            provideTranslocoScope({scope:'main-page', alias: 'MAIN_PAGE'})
        ]
    },
    
];
