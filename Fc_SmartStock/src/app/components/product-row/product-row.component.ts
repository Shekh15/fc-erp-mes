import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormGroup, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-product-row',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './product-row.component.html',
  styleUrl: './product-row.component.scss'
})
export class ProductRowComponent {

  @Input() group!: FormGroup;

  ngOnInit() {

    console.log("Formgroup in child component:::",this.group);
  }

  get qty() {
    return this.group.get('qty')?.value || 0;
  }

  get unitPrice() {
    return this.group.get('unitPrice')?.value || 0;
  }

  get total() {
    return this.group.get('total')?.value || 0;
  }

  incQty() {
    this.group.patchValue({ qty: this.qty + 1 });
  }

  decQty() {
    if (this.qty > 0) {
      this.group.patchValue({ qty: this.qty - 1 });
    }
  }

  incPrice() {
    this.group.patchValue({ unitPrice: this.unitPrice + 1 });
  }

  decPrice() {
    if (this.unitPrice > 0) {
      this.group.patchValue({ unitPrice: this.unitPrice - 1 });
    }
  }
}