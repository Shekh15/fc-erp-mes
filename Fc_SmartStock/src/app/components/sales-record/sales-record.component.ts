import { Component, OnInit } from '@angular/core';
import { Product, ProductService } from '../../services/product.service';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-sales-record',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './sales-record.component.html',
  styleUrl: './sales-record.component.scss'
})
export class SalesRecordComponent implements OnInit {

  products: any[] = [];
  selectedProductId: string | null = null;

  stockRecordForm: any = {
    id: '',
    date: '',
    productName: '',
    producedPackets: '',
    salesPacket: '',
    currentStock: ''
  };

  constructor(private productService: ProductService) { }

  ngOnInit() {

    this.loadProducts();
  }


  loadProducts() {

    this.products = [];

    this.productService.getProducts().subscribe({
      next: (data: Product[]) => {
        console.log("products:::", data);
        this.products = data;

        for (let i = 0; i < this.products.length; i++) {
          this.products.push({
            productId: this.products[i].id,
            productName: this.products[i].name,
            qty: 0,
            unitPrice: this.products[i].price,
            total: +(0 * this.products[i].price)
          });
        }
      },
      error: (err: unknown) => {
        console.error('Error loading products:', err);
      }
    });


    console.log("items:::", this.products);
    console.log("selected option:::", this.selectedProductId);
  }

  onSelectOption() {
    console.log("selectedClien:::", this.selectedProductId);
    if (!this.selectedProductId) return;

    // const p = this.products.find(x => x.id === this.selectedProductId);
    // if (!p) return;
    // reset selection
  }

}
