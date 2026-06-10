import { Component, inject, Input } from '@angular/core';
import { BillService } from '../../services/bill.service';
import Swal from 'sweetalert2';
import { DatePipe } from '@angular/common';
import { Router } from '@angular/router';
import jsPDF from 'jspdf';
import html2canvas from 'html2canvas';

@Component({
  selector: 'app-view-bill',
  imports: [DatePipe],
  templateUrl: './view-bill.component.html',
  styleUrl: './view-bill.component.scss',
})
export class ViewBillComponent {
  @Input() id!: string;

  private router = inject(Router);

  bill: any;
  history: any[] = [];

  constructor(private billService: BillService) {}

  ngOnInit() {
    if (this.id) {
      this.loadBillById(this.id);
      this.getBillHistory();
    }
  }

  loadBillById(id: string) {
    console.log('Type of Id:::', typeof id);
    console.log(id);

    this.billService.getBillById(id).subscribe({
      next: (res: any) => {
        this.bill = Array.isArray(res) ? res[0] : res;
        console.log('Bill Data:::', this.bill);
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

  loadBillVersion(id: string) {
    console.log('Version Id:::', id);

    this.billService.getBillVersion(id).subscribe({
      next: (res: any) => {
        this.bill = res;
        console.log('Bill Version Data:::', this.bill);
      },
      error: () => {
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: 'Failed to load bill version!',
        });
      },
    });
  }

  getBillHistory() {
    this.billService.getBillHistory(this.id).subscribe({
      next: (res: any) => {
        this.history = res;
        console.log('Bill History:::', this.history);
      },
      error: () => {
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: 'Failed to load bill history!',
        });
      },
    });
  }

  goBack(): void {
    this.router.navigate(['/smartbilling']);
  }

  downloadPdf() {
    const invoice = document.getElementById('invoice-content');

    if (!invoice) return;

    html2canvas(invoice, {
      scale: 4,
    }).then((canvas) => {
      const imgData = canvas.toDataURL('image/png');

      const pdf = new jsPDF('p', 'mm', 'a4');

      const pageWidth = pdf.internal.pageSize.getWidth();

      const pageHeight = (canvas.height * pageWidth) / canvas.width;

      pdf.addImage(imgData, 'PNG', 0, 0, pageWidth, pageHeight);

      pdf.save(`Invoice-${this.bill.id}.pdf`);
    });
  }

  get billItems() {
    return this.bill?.items?.filter((x: any) => x.qty > 0) || [];
  }
}
