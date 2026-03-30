import { Injectable } from '@angular/core';
import { AppConfig } from '../app.config';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  // prepared for future integration
  apiUrl = AppConfig.apiUrl;

  constructor() { }
}


