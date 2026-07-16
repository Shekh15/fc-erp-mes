import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { UnitService } from '../../services/unit.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-unit-master',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './unit-master.component.html',
  styleUrl: './unit-master.component.scss',
})
export class UnitMasterComponent {

  form!: FormGroup;

  units: any[] = [];

  selectedId = 0;

  constructor(
    private fb: FormBuilder,
    private unitService: UnitService,
  ) {}

  ngOnInit() {
    this.initializeForm();
    this.loadUnits();
  }

  initializeForm() {
    this.form = this.fb.group({
      id: [0],

      unit_code: ['', [Validators.required, Validators.maxLength(20)]],

      unit_name: ['', [Validators.required, Validators.maxLength(100)]],
    });
  }

  loadUnits() {
    this.unitService.getAll().subscribe({
      next: (res: any) => {
        this.units = res;
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
      this.unitService.update(data.id, data).subscribe({
        next: () => {
          Swal.fire({
            icon: 'success',
            title: 'Updated',
            text: 'Unit updated successfully',
          });

          this.loadUnits();

          this.clear();
        },

        error: (err: any) => {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: err.error?.message || 'Failed to update unit',
          });
        },
      });
    } else {
      this.unitService.create(data).subscribe({
        next: () => {
          Swal.fire({
            icon: 'success',
            title: 'Saved',
            text: 'Unit created successfully',
          });

          this.loadUnits();

          console.log("After Loading Units::::",this.units)

          this.clear();
        },

        error: (err: any) => {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: err.error?.message || 'Failed to create unit',
          });
        },
      });
    }
  }

  edit(unit: any) {
    this.form.patchValue({
      id: unit.id,

      unit_code: unit.unit_code,

      unit_name: unit.unit_name,
    });

    this.form.markAsDirty();
  }

  delete(id: number) {
    Swal.fire({
      title: 'Delete Unit?',

      text: 'This unit will be deactivated.',

      icon: 'warning',

      showCancelButton: true,

      confirmButtonText: 'Yes, Delete',
    }).then((result) => {
      if (!result.isConfirmed) {
        return;
      }

      this.unitService.delete(id).subscribe({
        next: () => {
          Swal.fire({
            icon: 'success',
            title: 'Deleted',
            text: 'Unit deleted successfully',
          });

          this.loadUnits();

          this.clear();
        },

        error: (err: any) => {
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: err.error?.message || 'Failed to delete unit',
          });
        },
      });
    });
  }

  clear() {
    this.form.reset({
      id: 0,

      unit_code: '',

      unit_name: '',
    });

    this.form.markAsPristine();

    this.form.markAsUntouched();
  }
}
