import { Component, OnInit } from '@angular/core';
import {
  FormArray,
  FormBuilder,
  FormGroup,
  Validators,
  ReactiveFormsModule,
  AbstractControl,
  ValidationErrors,
  FormsModule,
} from '@angular/forms';

import { DatePipe, DecimalPipe } from '@angular/common';

import Swal from 'sweetalert2';

import { ProductService } from '../../services/product.service';
import { ProductionDashboardService } from '../../services/production-dashboard.service';
import { ProductionService } from '../../services/production.service';

@Component({
  selector: 'app-production-entry',
  standalone: true,
  imports: [ReactiveFormsModule, FormsModule, DatePipe, DecimalPipe],
  templateUrl: './production-entry.component.html',
  styleUrl: './production-entry.component.scss',
})
export class ProductionEntryComponent implements OnInit {
  form!: FormGroup;

  products: any[] = [];

  productions: any[] = [];

  tableProducts: any[] = [];

  pivotData: any[] = [];

  maxDate = '';

  isEditMode = false;

  editingDate = '';

  viewMode: 'entry' | 'dashboard' = 'entry';

  dashboard:any = {
    totalWork: 0,
    totalPackets: 0,
    totalRevenue: 0,
    totalProfit: 0,
    products: []
};

  fromDate = this.getLocalDate();
  toDate = this.getLocalDate();

  constructor(
    private fb: FormBuilder,
    private productService: ProductService,
    private productionService: ProductionService,
    private productionDashboardService: ProductionDashboardService,
  ) {}

  get items(): FormArray {
    return this.form.get('items') as FormArray;
  }

  ngOnInit(): void {
    this.maxDate = this.getLocalDate();

    this.initializeForm();

    this.loadProducts();

    this.loadProductions();
  }

  //-------------------------------------------------
  // FORM
  //-------------------------------------------------

  initializeForm() {
    this.form = this.fb.group({
      production_date: [
        this.getLocalDate(),
        [Validators.required, this.noFutureDateValidator.bind(this)],
      ],

      remarks: [
        '',
        [
          Validators.maxLength(500),
          Validators.pattern(/^[a-zA-Z0-9\s.,()\-]*$/),
        ],
      ],

      items: this.fb.array([]),
    });
  }
  //-------------------------------------------------
  // LOAD PRODUCTS
  //-------------------------------------------------

  loadProducts() {
    this.productService.getProducts().subscribe({
      next: (products: any[]) => {
        this.products = products;

        this.items.clear();

        products.forEach((product) => {
          this.items.push(this.createItem(product));
        });
      },
    });
  }

  loadDashboard() {
    this.productionDashboardService
      .getDashboard(this.fromDate, this.toDate)
      .subscribe({
        next: (res: any) => {
          this.dashboard = res.data;
        },
        error: console.error,
      });
  }

  //-------------------------------------------------
  // SAVE
  //-------------------------------------------------

  save() {
    const rows = this.items.controls
      .filter((control) => {
        const qty = Number(control.get('quantity')?.value || 0);

        const packets = Number(control.get('produced_packets')?.value || 0);

        return qty > 0 || packets > 0;
      })
      .map((control) => control.value); // <-- THIS IS THE IMPORTANT PART

    if (rows.length === 0) {
      Swal.fire({
        icon: 'warning',
        title: 'Nothing to save',
        text: 'Enter production for at least one product.',
      });

      return;
    }

    const invalid = this.items.controls.find((control) => {
      const qty = Number(control.get('quantity')?.value || 0);

      const packets = Number(control.get('produced_packets')?.value || 0);

      return (qty > 0 || packets > 0) && control.invalid;
    });

    if (invalid) {
      invalid.markAllAsTouched();

      Swal.fire({
        icon: 'warning',
        title: 'Incomplete Entry',
        text: 'Enter both Quantity and Packets.',
      });

      return;
    }

    const payload = {
      production_date: this.form.value.production_date,
      remarks: this.form.value.remarks,
      items: rows,
    };

    console.log(payload);

    this.productionService.createBulk(payload).subscribe({
      next: () => {
        Swal.fire({
          icon: 'success',
          title: 'Saved',
          text: 'Production saved successfully.',
        });

        this.loadProductions();

        this.clear();
      },

      error: (err: any) => {
        console.log(err);

        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: err.error?.message || 'Something went wrong',
        });
      },
    });
  }

  private createItem(product: any): FormGroup {
    return this.fb.group(
      {
        product_id: [product.id],

        product_name: [product.name],

        quantity: [
          0,
          [Validators.min(0), Validators.pattern(/^\d+(\.\d{1,3})?$/)],
        ],

        produced_packets: [
          0,
          [Validators.min(0), Validators.pattern(/^[0-9]+$/)],
        ],
      },
      {
        validators: this.productionRowValidator,
      },
    );
  }

  productionRowValidator(control: AbstractControl): ValidationErrors | null {
    const qty = Number(control.get('quantity')?.value || 0);

    const packets = Number(control.get('produced_packets')?.value || 0);

    if (qty === 0 && packets === 0) {
      return null;
    }

    if (qty <= 0) {
      return {
        quantityRequired: true,
      };
    }

    if (packets <= 0) {
      return {
        packetsRequired: true,
      };
    }

    return null;
  }

  clear() {
    this.form.patchValue({
      production_date: this.getLocalDate(),

      remarks: '',
    });

    this.items.controls.forEach((control) => {
      control.patchValue({
        quantity: 0,

        produced_packets: 0,
      });
    });
  }

  //-------------------------------------------------
  // LOAD TABLE
  //-------------------------------------------------

  loadProductions() {
    this.productionService.getAll().subscribe({
      next: (res: any) => {
        this.productions = res.data;

        this.buildPivotTable();
      },

      error: console.error,
    });
  }

  showEntry() {
    this.viewMode = 'entry';
  }

  showDashboard() {
    this.viewMode = 'dashboard';

    this.loadDashboard();
  }

  buildPivotTable() {
    const grouped: any = {};

    this.tableProducts = [];

    this.productions.forEach((item: any) => {
      // Build dynamic product headers

      if (!this.tableProducts.find((p) => p.id === item.product_id)) {
        this.tableProducts.push({
          id: item.product_id,

          name: item.product_name,
        });
      }

      // Group by production date

      if (!grouped[item.production_date]) {
        grouped[item.production_date] = {
          date: item.production_date,

          remarks: item.remarks,

          rows: {},
        };
      }

      grouped[item.production_date].rows[item.product_id] = {
        quantity: item.quantity,

        packets: item.produced_packets,
      };
    });

    this.pivotData = Object.values(grouped);
  }

  editProduction(day: any) {
    // Reset all values first
    this.isEditMode = true;

    this.editingDate = day.date;

    this.clear();

    // Load batch details
    this.form.patchValue({
      production_date: day.date,

      remarks: day.remarks,
    });

    // Fill every product
    day.items.forEach((item: any) => {
      const row = this.items.controls.find(
        (control) => control.get('product_id')?.value === item.product_id,
      );

      if (row) {
        row.patchValue({
          quantity: item.quantity,

          produced_packets: item.produced_packets,
        });
      }
    });

    this.form.markAsDirty();

    window.scrollTo({
      top: 0,
      behavior: 'smooth',
    });
  }

  //-------------------------------------------------
  // VALIDATOR
  //-------------------------------------------------

  noFutureDateValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;

    const selected = new Date(control.value);

    const today = new Date();

    today.setHours(0, 0, 0, 0);

    selected.setHours(0, 0, 0, 0);

    return selected > today ? { futureDate: true } : null;
  }

  //-------------------------------------------------
  // DATE
  //-------------------------------------------------

  getLocalDate(): string {
    const today = new Date();

    return today.toISOString().substring(0, 10);
  }
}
