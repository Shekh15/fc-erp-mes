import { Component, Input } from '@angular/core';
import { BillService } from '../../services/bill.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-view-bill',
  imports: [],
  templateUrl: './view-bill.component.html',
  styleUrl: './view-bill.component.scss'
})
export class ViewBillComponent {

  @Input() id!: string;

    constructor(
    private billService: BillService,

  ) {}

ngOnInit() {


  if(this.id){

    console.log("Type of Id:::",typeof this.id);
    console.log(this.id);

      this.billService.getBillById(this.id).subscribe({
          next: (res) => {
           console.log('Bill Details of Given Id::', res);
          },
          error: () => {
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'Something went wrong!',
            });
          },
        });

  }


  }
}
