import {
  AbstractControl,
  ValidationErrors,
  ValidatorFn,
  FormArray
} from '@angular/forms';

export function atLeastOneQtyValidator(): ValidatorFn {
  return (control: AbstractControl): ValidationErrors | null => {

    const items = control as FormArray;

    const hasQty = items.controls.some(item => {
      const qty = Number(item.get('qty')?.value || 0);
      return qty > 0;
    });

    return hasQty ? null : { noQuantityEntered: true };
  };
}