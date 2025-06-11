import { Component, inject, output } from '@angular/core';
import { ThemeService } from '../../services/ThemeService/theme.service';
import { MatButtonModule } from '@angular/material/button';
import {MatIconModule} from '@angular/material/icon';
import {MatToolbarModule} from '@angular/material/toolbar';
import { TranslocoPipe } from '@jsverse/transloco';
@Component({
  selector: 'tos-toolbar',
  imports: [
    MatButtonModule,
    MatIconModule,
    MatToolbarModule,
    TranslocoPipe
  ],
  templateUrl: './toolbar.component.html',
  styleUrl: './toolbar.component.scss'
})
export class ToolbarComponent {
  emitNavClick = output()
  themeService = inject(ThemeService)

  constructor() {
    this.themeService.setTheme()
  }
}
