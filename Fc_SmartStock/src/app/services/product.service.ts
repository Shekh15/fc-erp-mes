import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { AppConfig } from '../app.config';

export interface Product {
  id: string;
  name: string;
  price: number;
}

@Injectable({
  providedIn: 'root',
})
export class ProductService {
  apiUrl = AppConfig.apiUrl;

  private ProductsUrl = `${this.apiUrl}/products`;

  constructor(private http: HttpClient) {}

  getProducts(): Observable<Product[]> {
    return this.http.get<Product[]>(this.ProductsUrl);
  }

  addProduct(data: any): Observable<any> {
    return this.http.post(this.ProductsUrl, data);
  }

  getAvailableProducts():Observable<any>{
    return this.http.get(`${this.ProductsUrl}/available`);
  }

  adjustStock(data: any) {
    return this.http.put(`${this.ProductsUrl}/adjust-stock`, data);
  }

  getStockList() {
    return this.http.get(`${this.ProductsUrl}/stock`);
  }
}
