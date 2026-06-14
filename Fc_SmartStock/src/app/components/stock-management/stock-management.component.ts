import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';

import Swal from 'sweetalert2';

import { ProductService } from '../../services/product.service';

@Component({
  selector: 'app-stock-management',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './stock-management.component.html',
  styleUrl: './stock-management.component.scss',
})
export class StockManagementComponent implements OnInit {
  stocks: any[] = [];
  filteredStocks: any[] = [];

  searchText = '';

  stockForm!: FormGroup;

  showEditScreen = false;

  selectedProduct: any = null;

  constructor(
    private productService: ProductService,
    private fb: FormBuilder,
  ) {}

  ngOnInit(): void {
    this.stockForm = this.fb.group({
      productId: [''],

      currentStock: [0],

      newStock: [
        null,
        [
          Validators.required,
          Validators.min(0),
          Validators.pattern(/^[0-9]+$/),
        ],
      ],

      reason: ['', [Validators.maxLength(250)]],
    });

    this.loadStocks();
  }

  loadStocks() {
    this.productService.getStockList().subscribe({
      next: (res: any) => {
        this.stocks = res;
        this.filteredStocks = [...res];
      },

      error: (err: any) => {
        console.error(err);
      },
    });
  }

  search() {
    const text = this.searchText.toLowerCase();

    this.filteredStocks = this.stocks.filter((x) =>
      x.name.toLowerCase().includes(text),
    );
  }

  editStock(stock: any) {
    this.selectedProduct = stock;

    this.stockForm.patchValue({
      productId: stock.id,
      currentStock: stock.current_stock,
      newStock: stock.current_stock,
      reason: '',
    });

    this.showEditScreen = true;
  }

  goBack() {
    this.showEditScreen = false;

    this.selectedProduct = null;

    this.stockForm.reset({
      productId: '',
      currentStock: 0,
      newStock: 0,
      reason: '',
    });
  }

  saveStockAdjustment() {
    if (this.stockForm.invalid) {
      return;
    }

    const payload = this.stockForm.value;

    this.productService.adjustStock(payload).subscribe({
      next: () => {
        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: 'Stock updated successfully',
        });

        this.goBack();

        this.loadStocks();
      },

      error: (err: { error: { message: any } }) => {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: err.error?.message || 'Failed',
        });
      },
    });
  }
}
