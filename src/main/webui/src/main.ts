import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { MenuLayout } from './app/layout/menu.layout';

bootstrapApplication(MenuLayout, appConfig).catch((err) => console.error(err));
