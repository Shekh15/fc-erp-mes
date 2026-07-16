import { Injectable } from '@angular/core';

import { HttpClient } from '@angular/common/http';

import { Observable } from 'rxjs';
import { AppConfig } from '../app.config';

@Injectable({
  providedIn: 'root',
})
export class UnitService {
    apiUrl = AppConfig.apiUrl;
  
    private unitUrl = `${this.apiUrl}/units`;

  constructor(private http: HttpClient) {}

  getAll(): Observable<any> {
    return this.http.get(this.unitUrl);
  }

  create(data: any): Observable<any> {
    return this.http.post(this.unitUrl, data);
  }

  update(id: number, data: any): Observable<any> {
    return this.http.put(`${this.unitUrl}/${id}`, data);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.unitUrl}/${id}`);
  }
}
