import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AppConfig } from '../app.config';

@Injectable({ providedIn: 'root' })
export class BillService {
  apiUrl = AppConfig.apiUrl;

  private billUrl = `${this.apiUrl}/bills`;
  private ledgerUrl = `${this.apiUrl}/ledger`;
  private priceListUrl = `${this.apiUrl}/price-lists`;

  constructor(private http: HttpClient) {}

  // ================= BILLS =================

  getBills(): Observable<any[]> {
    return this.http.get<any[]>(this.billUrl);
  }

  getBillById(id:string): Observable<any> {
    return this.http.get(`${this.billUrl}/${id}`);
  }

  saveBill(bill: any): Observable<any> {
    return this.http.post(this.billUrl, bill);
  }

  updateBill(id: string, data: any): Observable<any> {
    return this.http.patch(`${this.billUrl}/${id}`, data);
  }

  // ================= LEDGER =================

  getClientLedgerBalance(clientId: number): Observable<{ balance: number }> {
    return this.http.get<{ balance: number }>(
      `${this.ledgerUrl}/client/${clientId}/balance`,
    );
  }

  addLedgerEntry(entry: any): Observable<any> {
    return this.http.post(this.ledgerUrl, entry);
  }

  // ================= PRICE LIST =================

  getAllPriceLists(): Observable<any[]> {
    return this.http.get<any[]>(`${this.priceListUrl}`);
  }

  getPriceListsByClient(clientId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.priceListUrl}/client/${clientId}`);
  }

  getPriceListItems(priceListId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.priceListUrl}/${priceListId}/products`);
  }
}
