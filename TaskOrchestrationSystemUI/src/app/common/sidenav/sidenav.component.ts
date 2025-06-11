import { Component } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatDividerModule } from '@angular/material/divider';
import { ToolbarComponent } from "../toolbar/toolbar.component";
import { TranslocoPipe } from '@jsverse/transloco';

@Component({
  selector: 'tos-sidenav',
  imports: [
    MatSidenavModule,
    MatButtonModule,
    MatIconModule,
    ToolbarComponent,
    MatDividerModule,
    TranslocoPipe
],
  templateUrl: './sidenav.component.html',
  styleUrl: './sidenav.component.scss'
})
export class SidenavComponent {
  isCollapsed = false;

  navItems = [
    { icon: 'home', label: 'Início' },
    { icon: 'person', label: 'Perfil' },
    { icon: 'settings', label: 'Definições' },
    { icon: 'logout', label: 'Sair' }
  ];

  toggleSidebar() {
    this.isCollapsed = !this.isCollapsed;
  }
} 
