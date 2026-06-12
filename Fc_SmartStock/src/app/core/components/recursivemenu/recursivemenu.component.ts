import { Component, Input, signal } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-recursivemenu',
  imports: [RouterModule, RecursivemenuComponent],
  templateUrl: './recursivemenu.component.html',
  styleUrl: './recursivemenu.component.scss',
})
export class RecursivemenuComponent {
  @Input() menu: any;
  @Input() level = 0;

  expanded = signal(false);

  toggle() {
    this.expanded.update((v) => !v);
  }
}
