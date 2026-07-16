import { Routes } from '@angular/router';
import { ViewBillComponent } from './components/view-bill/view-bill.component';

export const appRoutes: Routes = [
  {
    path: 'smartbilling',
    loadComponent: () => import('./components/bill-generator/bill-generator.component').then(m => m.BillGeneratorComponent)
  },
  {
    path: 'production-entry',
    loadComponent: () => import('./components/production-entry/production-entry.component').then(m => m.ProductionEntryComponent)
  },
  {
    path: 'bills/view/:id',
    loadComponent: () => import('./components/view-bill/view-bill.component').then(m=>m.ViewBillComponent)
  },
    {
    path: 'product-stock',
    loadComponent: () => import('./components/stock-management/stock-management.component').then(m=>m.StockManagementComponent)
  },
  {
    path: 'units',
    loadComponent: () => import('./master/unit-master/unit-master.component').then(m=>m.UnitMasterComponent)
  },
  {
    path: '',
    redirectTo: 'smartbilling',
    pathMatch: 'full'
  }
];

