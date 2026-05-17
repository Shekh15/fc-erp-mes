import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AppConfig } from '../../app.config';

export interface Client {
  id: string;
  name: string;
  price: number;
}

@Injectable({
  providedIn: 'root'
})
export class ClientService {

  apiUrl = AppConfig.apiUrl;

  private clientUrl = `${this.apiUrl}/clients`;

  constructor(private http: HttpClient) { }

  getClients(): Observable<Client[]> {
    return this.http.get<Client[]>(this.clientUrl);
  }
}
