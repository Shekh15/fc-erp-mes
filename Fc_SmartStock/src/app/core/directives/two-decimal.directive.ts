import {
  Directive,
  HostListener,
  ElementRef,
  Optional,
  Self,
  OnInit,
} from '@angular/core';
import { NgControl } from '@angular/forms';

@Directive({
  selector: '[appTwoDecimal]',
  standalone: true,
  exportAs: 'appTwoDecimal',
})
export class TwoDecimalDirective implements OnInit {
  // Public property that buttons read dynamically
  public currentStep: number = 1;

  // Update this line inside your TwoDecimalDirective class:
  private regex: RegExp = new RegExp(/^\d*\.?\d{0,2}$/); // Removed the global 'g' flag for cleaner validation matches

  private specialKeys: Array<string> = [
    'Backspace',
    'Tab',
    'End',
    'Home',
    'ArrowLeft',
    'ArrowRight',
    'Delete',
  ];

  constructor(
    private el: ElementRef<HTMLInputElement>,
    @Optional() @Self() private ngControl: NgControl,
  ) {}

  ngOnInit(): void {
    setTimeout(() => {
      this.formatAndSetStep();
    });
  }

  @HostListener('change')
  onControlChange() {
    this.updateStepSize();
  }

  @HostListener('keydown', ['$event'])
  onKeyDown(event: KeyboardEvent) {
    // Block negative sign
    if (event.key === '-') {
      event.preventDefault();
      return;
    }

    if (this.specialKeys.indexOf(event.key) !== -1) {
      setTimeout(() => this.updateStepSize());
      return;
    }
  }

  @HostListener('blur')
  onBlur() {
    this.formatAndSetStep();
  }

  @HostListener('paste')
  onPaste() {
    setTimeout(() => {
      const value = parseFloat(this.el.nativeElement.value);

      if (!isNaN(value) && value < 0) {
        this.el.nativeElement.value = '0.00';

        this.ngControl?.control?.setValue(0, {
          emitEvent: true,
        });
      }

      this.updateStepSize();
    });
  }

  private formatAndSetStep(): void {
    const value = this.el.nativeElement.value;
    if (value && !isNaN(parseFloat(value))) {
      let numericValue = parseFloat(value);

      if (numericValue < 0) {
        numericValue = 0;
      }

      this.el.nativeElement.value = numericValue.toFixed(2);

      if (this.ngControl && this.ngControl.control) {
        this.ngControl.control.setValue(numericValue, {
          emitEvent: true,
        });
      }
    }
    this.updateStepSize();
  }

  private updateStepSize(valueString?: string): void {
    const val = valueString ?? this.el.nativeElement.value;

    // Read step safely from the element attribute character reference
    const htmlStep = this.el.nativeElement.getAttribute('step');
    const configuredDecimalStep = htmlStep ? parseFloat(htmlStep) : 0.25;

    if (val.includes('.') || (val && !Number.isInteger(parseFloat(val)))) {
      this.currentStep = configuredDecimalStep;
    } else {
      this.currentStep = 1;
    }
  }
}
