import { Component, inject } from '@angular/core';
import { ThemeService } from '../../services/ThemeService/theme.service';
import { MatButtonModule } from '@angular/material/button';
import {MatIconModule} from '@angular/material/icon';
@Component({
  selector: 'tos-toolbar',
  imports: [
    MatButtonModule,
    MatIconModule
  ],
  templateUrl: './toolbar.component.html',
  styleUrl: './toolbar.component.scss'
})
export class ToolbarComponent {
  themeService = inject(ThemeService)

  constructor() {
    this.themeService.setTheme()
  }
}
