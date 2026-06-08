import { Routes } from '@angular/router';
import { ViewBillComponent } from './components/view-bill/view-bill.component';

export const appRoutes: Routes = [
  {
    path: 'smartbilling',
    loadComponent: () => import('./components/bill-generator/bill-generator.component').then(m => m.BillGeneratorComponent)
  },
  {
    path: 'daily-production-record',
    loadComponent: () => import('./components/daily-production-record/daily-production-record.component').then(m => m.DailyProductionRecordComponent)
  },
  {
    path: 'bills/view/:id',
    loadComponent: () => import('./components/view-bill/view-bill.component').then(m=>m.ViewBillComponent)
  },
  {
    path: '',
    redirectTo: 'smartbilling',
    pathMatch: 'full'
  }
];

