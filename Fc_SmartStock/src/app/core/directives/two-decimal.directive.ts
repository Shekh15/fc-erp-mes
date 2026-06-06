import { Directive, HostListener, ElementRef, Optional, Self, OnInit } from '@angular/core';
import { NgControl } from '@angular/forms';

@Directive({
  selector: '[appTwoDecimal]',
  standalone: true,
  exportAs: 'appTwoDecimal'
})
export class TwoDecimalDirective implements OnInit {
  // Public property that buttons read dynamically
  public currentStep: number = 1;

  private regex: RegExp = new RegExp(/^\d*\.?\d{0,2}$/g);
  private specialKeys: Array<string> = ['Backspace', 'Tab', 'End', 'Home', 'ArrowLeft', 'ArrowRight', 'Delete'];

  constructor(
    private el: ElementRef<HTMLInputElement>,
    @Optional() @Self() private ngControl: NgControl
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
    if (this.specialKeys.indexOf(event.key) !== -1) {
      setTimeout(() => this.updateStepSize());
      return;
    }
    const current: string = this.el.nativeElement.value;
    const position = this.el.nativeElement.selectionStart ?? 0;
    const next: string = [current.slice(0, position), event.key, current.slice(position)].join('');
    
    if (next && !String(next).match(this.regex)) {
      event.preventDefault();
    } else {
      this.updateStepSize(next);
    }
  }

  @HostListener('blur')
  onBlur() {
    this.formatAndSetStep();
  }

  @HostListener('paste')
  onPaste() {
    setTimeout(() => this.updateStepSize());
  }

  private formatAndSetStep(): void {
    const value = this.el.nativeElement.value;
    if (value && !isNaN(parseFloat(value))) {
      const numericValue = parseFloat(value);
      this.el.nativeElement.value = numericValue.toFixed(2);
      
      if (this.ngControl && this.ngControl.control) {
        this.ngControl.control.setValue(numericValue, { emitEvent: false });
      }
    }
    this.updateStepSize();
  }

  private updateStepSize(valueString?: string): void {
    const val = valueString ?? this.el.nativeElement.value;
    
    // Read the configured HTML step value dynamically, fallback to 0.25 if not provided
    const configuredDecimalStep = parseFloat(this.el.nativeElement.step) || 0.25;

    if (val.includes('.') || (val && !Number.isInteger(parseFloat(val)))) {
      this.currentStep = configuredDecimalStep; // 👈 Dynamic step allocation!
    } else {
      this.currentStep = 1;
    }
  }
}
