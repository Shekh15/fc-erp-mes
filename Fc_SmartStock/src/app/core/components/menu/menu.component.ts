import { Component, HostListener, Input, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { RecursivemenuComponent } from '../recursivemenu/recursivemenu.component';

@Component({
  selector: 'app-menu',
  standalone: true,
  imports: [CommonModule, RouterModule,RecursivemenuComponent],
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss'],
})
export class MenuComponent {

  menuItems = [
    {
      label: 'Dashboard',
      icon: 'bi bi-speedometer2',
      route: '/dashboard',
    },
    {
      label: 'Masters',
      icon: 'bi bi-database',
      children: [
        {
          label: 'Products',
          route: '/products',
        },
        {
          label: 'Customers',
          route: '/customers',
        },
        {
          label: 'Production',
          children: [
            {
              label: 'Daily Entry',
              route: '/production/daily',
            },
            {
              label: 'Reports',
              children: [
                {
                  label: 'Monthly',
                  route: '/production/reports/monthly',
                },
                {
                  label: 'Yearly',
                  route: '/production/reports/yearly',
                },
              ],
            },
          ],
        },
      ],
    },
  ];
}
