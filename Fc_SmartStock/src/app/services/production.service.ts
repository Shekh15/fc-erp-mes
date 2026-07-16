import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AppConfig } from '../app.config';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ProductionService {
  apiUrl = AppConfig.apiUrl;

  private productionUrl = `${this.apiUrl}/production`;

  constructor(private http: HttpClient) {}

  getAll(): Observable<any> {
    return this.http.get(this.productionUrl);
  }

  create(data: any): Observable<any> {
    return this.http.post(this.productionUrl, data);
  }

  createBulk(data: any) {
    return this.http.post(`${this.productionUrl}/production/bulk`, data);
  }

  update(id: number, data: any) {
    return this.http.put(`${this.productionUrl}/${id}`, data);
  }
}
