import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { BillGeneratorComponent } from './components/bill-generator/bill-generator.component';
import { SalesRecordComponent } from './components/sales-record/sales-record.component';
import { NgxSpinnerModule } from 'ngx-spinner';
  import { NgxSpinnerService } from 'ngx-spinner';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [BillGeneratorComponent, SalesRecordComponent, NgxSpinnerModule,],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'Fc_SmartStock';


constructor(private spinner: NgxSpinnerService) {}


  testSpinner() {
  this.spinner.show();

  setTimeout(() => {
    this.spinner.hide();
  }, 30000);
}
}

