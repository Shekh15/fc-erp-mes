import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NgxSpinnerModule } from 'ngx-spinner';
  import { NgxSpinnerService } from 'ngx-spinner';
import { environment } from '../environments/environment.development';
import { HeaderComponent } from "./core/components/header/header.component";
import { FooterComponent } from './core/components/footer/footer.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NgxSpinnerModule, HeaderComponent,FooterComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'Fc_SmartStock';

  isAuthenticated = true; // Placeholder for authentication status, replace with actual logic


constructor(private spinner: NgxSpinnerService) {

  console.log("Environment config used:",environment);
}

  testSpinner() {
  this.spinner.show();

  setTimeout(() => {
    this.spinner.hide();
  }, 30000);
}
}

