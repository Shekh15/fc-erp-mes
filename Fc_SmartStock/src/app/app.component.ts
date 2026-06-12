import { Component, HostListener, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NgxSpinnerModule } from 'ngx-spinner';
import { NgxSpinnerService } from 'ngx-spinner';
import { environment } from '../environments/environment.development';
import { HeaderComponent } from './core/components/header/header.component';
import { FooterComponent } from './core/components/footer/footer.component';
import { MenuComponent } from './core/components/menu/menu.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    RouterOutlet,
    MenuComponent,
    NgxSpinnerModule,
    HeaderComponent,
    FooterComponent,
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent {
  title = 'Fc_SmartStock';

  sidebarOpen = signal(window.innerWidth >= 992);

  isMobile = signal(window.innerWidth < 992);

  isAuthenticated = true; // Placeholder for authentication status, replace with actual logic

  constructor(private spinner: NgxSpinnerService) {
    console.log('Environment config used:', environment);
  }

  @HostListener('window:resize')
  onResize() {
    this.isMobile.set(window.innerWidth < 992);
  }
  @HostListener('window:scroll')
  onScroll() {
    if (this.isMobile() && this.sidebarOpen() && window.scrollY > 20) {
      this.sidebarOpen.set(false);
    }
  }

  toggleSidebar() {
    this.sidebarOpen.update((v) => !v);
    console.log('Toggleing Sidebar');
  }

  // testSpinner() {
  //   console.log('SHOW');
  //   this.spinner.show();

  //   setTimeout(() => {
  //     console.log('HIDE');
  //     this.spinner.hide();
  //   }, 30000);
  // }
}
