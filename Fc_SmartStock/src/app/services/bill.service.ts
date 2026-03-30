import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class BillService {

  private billUrl = 'http://localhost:3000/api/bills';
  private ledgerUrl = 'http://localhost:3000/api/ledger';
  private priceListUrl = 'http://localhost:3000/api/price-lists';

  constructor(private http: HttpClient) {}

  // ================= BILLS =================

  getBills(): Observable<any[]> {
    return this.http.get<any[]>(this.billUrl);
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
      `${this.ledgerUrl}/client/${clientId}/balance`
    );
  }

  addLedgerEntry(entry: any): Observable<any> {
    return this.http.post(this.ledgerUrl, entry);
  }

  // ================= PRICE LIST =================

  getPriceListsByClient(clientId: number): Observable<any[]> {
    return this.http.get<any[]>(
      `${this.priceListUrl}/client/${clientId}`
    );
  }

  getPriceListItems(priceListId: number): Observable<any[]> {
    return this.http.get<any[]>(
      `${this.priceListUrl}/${priceListId}/items`
    );
  }
}