import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormGroup, ReactiveFormsModule } from '@angular/forms';
import { TwoDecimalDirective } from '../../core/directives/two-decimal.directive';

@Component({
  selector: 'app-product-row',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, TwoDecimalDirective],
  templateUrl: './product-row.component.html',
  styleUrl: './product-row.component.scss',
})
export class ProductRowComponent implements OnInit {
  @Input() group!: FormGroup;
  @Input() index!: any;

  ngOnInit() {
    console.log('Formgroup in child component:::', this.group);
  }

  get qty(): number {
    return this.group.get('qty')?.value || 0;
  }
  get unitPrice(): number {
    return this.group.get('unitPrice')?.value || 0;
  }
  get total(): number {
    return this.group.get('total')?.value || 0;
  }

  incQty() {
    const control = this.group.get('qty');
    control?.markAsTouched();
    this.group.patchValue({ qty: this.qty + 1 });
  }
  decQty() {
    const control = this.group.get('qty');
    control?.markAsTouched();
    if (this.qty > 0) this.group.patchValue({ qty: this.qty - 1 });
  }

  // 🔄 Completely Dynamic Math functions
  incPrice(step: number) {
    const currentPrice = this.unitPrice;
    const precision = this.getPrecisionMultiplier(step);

    const newPrice =
      (Math.round(currentPrice * precision) + Math.round(step * precision)) /
      precision;
    this.group.patchValue({ unitPrice: newPrice });
  }

  decPrice(step: number) {
    const currentPrice = this.unitPrice;
    if (currentPrice > 0) {
      const precision = this.getPrecisionMultiplier(step);
      let newPrice =
        (Math.round(currentPrice * precision) - Math.round(step * precision)) /
        precision;

      if (newPrice < 0) newPrice = 0;
      this.group.patchValue({ unitPrice: newPrice });
    }
  }

  // Helper logic to find out whether to multiply by 10, 100, or 1 based on the step configuration
  private getPrecisionMultiplier(step: number): number {
    if (Number.isInteger(step)) return 1;
    const decimalPlaces = step.toString().split('.')[1]?.length || 0;
    return Math.pow(10, decimalPlaces); // e.g., 0.25 -> 2 decimal places -> 10^2 = 100
  }
}
