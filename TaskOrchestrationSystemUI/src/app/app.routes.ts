import { Routes } from '@angular/router';

export const routes: Routes = [
    {
        path: '', 
        pathMatch:"full",
        redirectTo:'main-page'
    },
    {
        path: 'main-page', 
        loadComponent: () => import('./pages/main-page/main-page.component').then(c => c.MainPageComponent)
    },
    
];
