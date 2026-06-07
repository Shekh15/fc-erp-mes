import { Routes } from '@angular/router';

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
    path: '',
    redirectTo: 'smartbilling',
    pathMatch: 'full'
  }
];

