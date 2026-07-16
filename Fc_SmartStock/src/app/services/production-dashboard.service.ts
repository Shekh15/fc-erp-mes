import { Injectable } from '@angular/core';

import { HttpClient, HttpParams } from '@angular/common/http';

import { Observable } from 'rxjs';
import { AppConfig } from '../app.config';

@Injectable({
  providedIn: 'root',
})
export class ProductionDashboardService {

  apiUrl = AppConfig.apiUrl;

  private ProductionDashboardUrl = `${this.apiUrl}/production-dashboard`;

  constructor(private http: HttpClient) {}

  getDashboard(fromDate: string, toDate: string): Observable<any> {
    const params = new HttpParams()
      .set('fromDate', fromDate)
      .set('toDate', toDate);

    return this.http.get<any>(this.ProductionDashboardUrl, { params });
  }
}
