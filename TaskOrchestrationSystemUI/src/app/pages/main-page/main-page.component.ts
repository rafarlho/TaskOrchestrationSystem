import { Component } from '@angular/core';
import { ToolbarComponent } from "../../common/toolbar/toolbar.component";
import { SidenavComponent } from "../../common/sidenav/sidenav.component";

@Component({
  selector: 'tos-main-page',
  imports: [ToolbarComponent, SidenavComponent],
  templateUrl: './main-page.component.html',
  styleUrl: './main-page.component.scss'
})
export class MainPageComponent {

}
