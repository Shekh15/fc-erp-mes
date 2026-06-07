import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DailyProductionRecordComponent } from './daily-production-record.component';

describe('DailyProductionRecordComponent', () => {
  let component: DailyProductionRecordComponent;
  let fixture: ComponentFixture<DailyProductionRecordComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DailyProductionRecordComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DailyProductionRecordComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
