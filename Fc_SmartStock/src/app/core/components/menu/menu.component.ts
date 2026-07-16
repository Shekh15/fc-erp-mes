import { Component, HostListener, Input, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { RecursivemenuComponent } from '../recursivemenu/recursivemenu.component';

@Component({
  selector: 'app-menu',
  standalone: true,
  imports: [CommonModule, RouterModule, RecursivemenuComponent],
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss'],
})
export class MenuComponent {
  menuItems = [
    {
      label: 'Billing',
      icon: 'bi bi-receipt-cutoff',
      route: '/smartbilling',
    },
    {
      label: 'Products',
      icon: 'bi bi-database',
      children: [
        {
          label: 'Production Record',
          route: '/production-entry',
        },
        {
          label: 'Product Stock',
          route: '/product-stock',
        },
      ],
    },
    {
      label: 'Masters',
      icon: 'bi bi-database',
      children: [
        {
          label: 'Unit Master',
          route: '/units',
        }
      ],
    },
  ];
}
