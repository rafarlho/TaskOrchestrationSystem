import { isPlatformBrowser } from '@angular/common';
import { inject, Injectable, PLATFORM_ID, signal, WritableSignal } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ThemeService {

  isDarkTheme : WritableSignal<boolean> = signal(false)
  private enableLocalStorage : WritableSignal<boolean> = signal(false) 
  private platformId : Object = inject(PLATFORM_ID);

  toggleBrowserTheme() {
    if(isPlatformBrowser(this.platformId)) 
        this.toggleTheme(!window.matchMedia("(prefers-color-scheme:dark)").matches)
  }

  toggleTheme(isDarkTheme : boolean) {
    this.isDarkTheme.set(!isDarkTheme)

    if(!isDarkTheme) 
      document.body.className = "dark-theme mat-app-background"
    else
      document.body.className = "light-theme mat-app-background" 

    localStorage.setItem("theme",!isDarkTheme ? 'dark': 'light')
  }

  setTheme() {
    if(!localStorage.getItem('theme'))
      this.toggleBrowserTheme()
    else
      this.toggleTheme(localStorage.getItem('theme') == 'dark' ? false : true)
  }
}
