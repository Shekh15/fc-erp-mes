import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  Validators,
  ReactiveFormsModule,
  AbstractControl,
  ValidationErrors,
} from '@angular/forms';
import { ProductService } from '../../services/product.service';
import { ProductionService } from '../../services/production.service';
import Swal from 'sweetalert2';
import { DatePipe, DecimalPipe } from '@angular/common';

@Component({
  selector: 'app-production-entry',
  standalone: true,
  imports: [ReactiveFormsModule, DatePipe, DecimalPipe],
  templateUrl: './production-entry.component.html',
  styleUrl: './production-entry.component.scss',
})
export class ProductionEntryComponent implements OnInit {
  form!: FormGroup;

  products: any[] = [];
  productions: any[] = [];

  maxDate: any;

  constructor(
    private fb: FormBuilder,
    private productionService: ProductionService,
    private productService: ProductService,
  ) {}

  ngOnInit(): void {
    this.maxDate = this.getLocalDate();

    this.initializeForm();

    this.loadProducts();

    this.loadProductions();
  }

  initializeForm() {
    this.form = this.fb.group({
      id: [0],

      production_date: ['', Validators.required],

      product_id: ['', Validators.required],

      quantity: [
        null,
        [
          Validators.required,
          Validators.min(0.001),
          Validators.pattern(/^\d+(\.\d{1,3})?$/),
        ],
      ],

      produced_packets: [
        null,
        [
          Validators.required,
          Validators.min(1),
          Validators.pattern(/^[0-9]+$/),
        ],
      ],

      remarks: [
        '',
        [
          Validators.maxLength(500),
          Validators.pattern(/^[a-zA-Z0-9\s.,()\-]*$/),
        ],
      ],
    });
  }

  //This method will load all products and push to form array
  loadProducts() {
    this.productService.getProducts().subscribe({
      next: (res: any) => {
        this.products = res;
      },

      error: (err: any) => {
        console.error(err);
      },
    });
  }

  loadProductions() {
    this.productionService.getAll().subscribe({
      next: (res: any) => {
        this.productions = res.data;
      },

      error: (err) => {
        console.error(err);
      },
    });
  }

  save() {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    const data = this.form.value;

    if (data.id && data.id > 0) {
      this.productionService.update(data.id, data).subscribe({
        next: () => {
          Swal.fire({
            icon: 'success',
            title: 'Updated',
            text: 'Production updated successfully',
          });

          this.loadProductions();

          this.clear();
        },

        error: (err) => {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: err.error.message,
          });
        },
      });
    } else {
      this.productionService.create(data).subscribe({
        next: () => {
          Swal.fire({
            icon: 'success',
            title: 'Saved',
            text: 'Production saved successfully',
          });

          this.loadProductions();

          this.clear();
        },

        error: (err) => {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: err.error.message,
          });
        },
      });
    }
  }

  edit(row: any) {
    console.log('Edited row:::', row);

    this.form.patchValue({
      id: row.id,

      production_date: row.production_date,

      product_id: row.product_id,

      quantity: row.quantity,

      produced_packets: row.produced_packets,

      remarks: row.remarks,
    });
  }

  clear() {
    this.form.reset({
      id: 0,

      production_date: this.getLocalDate(),

      product_id: '',

      quantity: 0,

      produced_packets: 0,

      remarks: '',
    });
  }

  noFutureDateValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) {
      return null;
    }

    const [year, month, day] = control.value.split('-').map(Number);

    const selectedDate = new Date(year, month - 1, day);

    const today = new Date();

    today.setHours(0, 0, 0, 0);

    return selectedDate > today ? { futureDate: true } : null;
  }

  getLocalDate(): string {
    const today = new Date();

    const year = today.getFullYear();

    const month = String(today.getMonth() + 1).padStart(2, '0');

    const day = String(today.getDate()).padStart(2, '0');

    return `${year}-${month}-${day}`;
  }
}
