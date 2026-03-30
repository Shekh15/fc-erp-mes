import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, FormArray, Validators } from '@angular/forms';
import { ProductRowComponent } from '../product-row/product-row.component';
import { BillService } from '../../services/bill.service';
import { v4 as uuidv4 } from 'uuid';
import { Product, ProductService } from '../../services/product.service';
import { Client, ClientService } from '../../core/services/client.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-bill-generator',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, ProductRowComponent],
  templateUrl: './bill-generator.component.html',
  styleUrls: ['./bill-generator.component.scss']
})
export class BillGeneratorComponent implements OnInit {

  products: Product[] = [];
  clients: Client[] = [];

  bills: any[] = [];

  isEditMode = false;
  editingBillId: string | null = null;

  totalBillAmount = 0;

  billForm!: FormGroup;

  priceLists: any[] = [];
  selectedClient: Client | null = null;
  clientDueAmount = 0;
  grandTotal = 0;
  remainingBalance = 0;

  constructor(
    private fb: FormBuilder,
    private billService: BillService,
    private productService: ProductService,
    private clientService: ClientService
  ) { }

  ngOnInit() {
    this.initForm();
    this.loadClients();
    this.loadProducts();
    this.loadBillsFromServer();


    // Recalculate total automatically
    this.billForm.valueChanges.subscribe((value) => {
      this.calculateTotal();
      console.log("FORM VALUE:", value);
      console.log("FORM STATE:", this.billForm);
    });
    // this.billForm.get('clientId')?.valueChanges.subscribe(clientId => {
    //   if (!clientId) return;

    //   this.selectedClient = this.clients.find(c => c.id == clientId) || null;

    //   this.fetchClientDues(clientId);
    //   this.loadClientPriceLists(clientId);
    // });

    this.billForm.get('clientId')?.valueChanges.subscribe(clientId => {
      console.log("Inside clientId Valuechanges::", clientId);

      if (!clientId) return;



      if (!this.isEditMode)
        this.fetchClientBalance(clientId);
      this.loadClientPriceList(clientId);
    });


    this.billForm.get('priceListId')?.valueChanges.subscribe(priceListId => {
      if (!priceListId) return;
      this.loadPriceListItems(Number(priceListId));
    });

    this.billForm.get('paidAmount')?.valueChanges.subscribe(() => {
      this.calculateGrandTotal();
    });
  }

  initForm() {
    // this.billForm = this.fb.group({
    //   id: [''],
    //   clientId: [null, Validators.required],
    //   clientName: [''],
    //   createdAt: [''],
    //   inhouse: [true],
    //   payment_status: [''],
    //   total: [0],
    //   items: this.fb.array([])
    // });
    this.billForm = this.fb.group({
      id: [''],
      clientId: [null, Validators.required],
      clientName: [''],
      priceListId: [null],
      inhouse: [true],
      items: this.fb.array([]),
      total: [2],
      paidAmount: [0],
    });

    console.log("FORM STATE inside init:", this.billForm);
  }

  get items(): FormArray {
    return this.billForm.get('items') as FormArray;
  }

  createItem(product: Product): FormGroup {
    return this.fb.group({
      productId: [product.id],
      productName: [product.name],
      qty: [0],
      unitPrice: [product.price],
      total: [0]
    });
  }

  loadProducts() {
    this.items.clear();

    this.productService.getProducts().subscribe({
      next: (data: Product[]) => {
        this.products = data;
        data.forEach(p => this.items.push(this.createItem(p)));
      },
      error: (err) => console.error('Error loading products:', err)
    });
  }

  loadClients() {
    this.clientService.getClients().subscribe({
      next: (data: Client[]) => {
        this.clients = data;
      },
      error: (err) => console.error('Error loading clients:', err)
    });
  }

  // calculateTotal() {
  //   let total = 0;

  //   this.items.controls.forEach(control => {
  //     const qty = control.get('qty')?.value || 0;
  //     const price = control.get('unitPrice')?.value || 0;
  //     const itemTotal = qty * price;
  //     control.get('total')?.setValue(itemTotal, { emitEvent: false });
  //     total += itemTotal;
  //   });

  //   this.totalBillAmount = total;
  //   this.billForm.get('total')?.setValue(total, { emitEvent: false });
  // }

  calculateTotal() {
    console.log("Calculating total");
    let total = 0;

    this.items.controls.forEach(control => {
      const qty = control.get('qty')?.value || 0;
      const price = control.get('unitPrice')?.value || 0;

      const itemTotal = qty * price;
      control.get('total')?.setValue(itemTotal, { emitEvent: false });

      total += itemTotal;
    });

    this.totalBillAmount = total;
    this.calculateGrandTotal();
  }

  calculateGrandTotal() {
    console.log("Calculating grand total");
    const paid = this.billForm.get('paidAmount')?.value || 0;

    this.grandTotal = this.totalBillAmount + this.clientDueAmount;
    this.remainingBalance = this.grandTotal - paid;
  }

  loadBillsFromServer() {
    this.billService.getBills().subscribe({
      next: (data) => {
        this.bills = data.sort((a, b) =>
          new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
        );
      },
      error: (err) => console.error('Error loading bills:', err)
    });
  }

  saveOrUpdateBill() {
    if (this.billForm.invalid) return;

    const formValue = {
      ...this.billForm.value,
      previousAmount: this.clientDueAmount,
      total: Number(this.totalBillAmount)
    }

    console.log("Form value while save and update:::", formValue);


    if (this.isEditMode && this.editingBillId) {
      this.billService.updateBill(this.editingBillId, formValue).subscribe({
        next: () => {
          Swal.fire({
            icon: 'success',
            title: 'Bill Updated!',
            text: 'The bill has been successfully Updated.',
            confirmButtonColor: '#0f2b2e'
          });
          this.resetForm();
          this.loadBillsFromServer();
          console.log("After reset form:::", this.billForm);
        },
        error: () => {
          Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Something went wrong!'
          });
        }
      });
    } else {

      const newBill = {
        ...formValue,
        clientName: this.clients.find(c => c.id == formValue.clientId)?.name,
        items: formValue.items,
        entry_date: new Date(),
      };

      this.billService.saveBill(newBill).subscribe({
        next: (savedBill) => {

          Swal.fire({
            icon: 'success',
            title: 'Bill Generated Successfully!'
          });

          this.resetForm();
          this.loadBillsFromServer();

        }
      });
      // const newBill = {
      //   ...formValue,
      //   id: uuidv4(),
      //   clientName: this.clients.find(c => c.id == formValue.clientId)?.name,
      //   createdAt: new Date().toISOString(),
      //   items: formValue.items.map((it: any, idx: number) => ({
      //     ...it,
      //     id: `i-${idx}-${Date.now()}-${formValue.clientId}`,
      //     total: it.qty * it.unitPrice
      //   }))
      // };

      // this.billService.saveBill(newBill).subscribe({
      //   next: () => {
      //     Swal.fire({
      //       icon: 'success',
      //       title: 'Bill Generated!',
      //       text: 'The bill has been successfully Created.',
      //       confirmButtonColor: '#0f2b2e'
      //     });
      //     this.resetForm();
      //     this.loadBillsFromServer();
      //   },
      //   error: () => {
      //     Swal.fire({
      //       icon: 'error',
      //       title: 'Oops...',
      //       text: 'Something went wrong!'
      //     });
      //   }
      // });
    }
  }

  //   this.billService.addLedgerEntry({
  //   client_id: bill.clientId,
  //   reference_type: "BILL",
  //   reference_id: bill.id,
  //   debit: this.grandTotal,
  //   credit: this.billForm.value.paidAmount,
  //   entry_date: new Date(),
  //   created_by: 1 // logged in user
  // });


  addLedgerEntry(bill: any) {

    const ledgerEntry = {
      client_id: parseInt(bill.clientId, 10),
      reference_type: "BILL",
      reference_id: bill.id,
      debit: this.totalBillAmount,
      credit: bill.paidAmount || 0,
      entry_date: new Date(),
      created_by: 1 // logged-in user id
    };

    this.billService.addLedgerEntry(ledgerEntry).subscribe({
      next: () => {
        Swal.fire({
          icon: 'success',
          title: 'Bill Generated & Ledger Updated!'
        });

        this.resetForm();
        this.loadBillsFromServer();
      }
    });
  }

  editBill(bill: any) {
    this.isEditMode = true;
    this.editingBillId = bill.original_bill_id;

    this.clientDueAmount = bill.previousAmount;

    this.billService.getClientLedgerBalance(bill.clientId).subscribe({
      next: (res) => {

        console.log("Client ledger balance:::", res);
        console.log("Previous amount during edit::", this.clientDueAmount);

        this.billForm.patchValue({
          ...bill,
          paidAmount: Number(bill.paidAmount),
          inhouse: !!bill.inhouse
        });
      }
    });

    // this.items.clear();
    // bill.items.forEach((item: any) => {
    //   this.items.push(this.fb.group(item));
    // });
  }

  fetchClientBalance(clientId: number) {

    console.log("Fetching client balance");
    this.billService.getClientLedgerBalance(clientId).subscribe({
      next: (res) => {
        this.clientDueAmount = this.isEditMode ? this.clientDueAmount : res.balance || 0;
        this.calculateGrandTotal();
      }
    });
  }

  loadClientPriceList(clientId: number) {
    this.billService.getPriceListsByClient(clientId).subscribe({
      next: (lists) => {
        this.priceLists = lists;

        if (lists.length) {
          this.billForm.patchValue({ priceListId: lists[0].id });
          this.loadPriceListItems(lists[0].id);
        }
      }
    });
  }

  loadPriceListItems(priceListId: number) {
    this.billService.getPriceListItems(priceListId).subscribe({
      next: (items) => {
        this.items.clear();

        items.forEach((item: any) => {
          this.items.push(this.fb.group({
            productId: item.product_id,
            productName: item.productName,
            qty: 0,
            unitPrice: item.price,
            total: 0
          }));
        });
      }
    });
  }

  resetForm() {
    this.isEditMode = false;
    this.editingBillId = null;

    this.billForm.reset({
      id: '',
      clientId: null,
      clientName: '',
      priceListId: null,
      inhouse: true,
      total: 0,
      paidAmount: 0
    });
    
    this.items.clear();
    this.loadProducts();
    this.totalBillAmount = 0;
    this.grandTotal = 0;
    this.clientDueAmount = 0;
    this.remainingBalance = 0;
  }

  viewBill(id: string) {
    console.log('Viewing bill:', id);
  }

  get itemControls(): FormGroup[] {
    return this.items.controls as FormGroup[];
  }


}