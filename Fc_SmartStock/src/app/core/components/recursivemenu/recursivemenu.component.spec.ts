import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecursivemenuComponent } from './recursivemenu.component';

describe('RecursivemenuComponent', () => {
  let component: RecursivemenuComponent;
  let fixture: ComponentFixture<RecursivemenuComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RecursivemenuComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RecursivemenuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
