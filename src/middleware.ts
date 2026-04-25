import { defineMiddleware } from 'astro:middleware';
import db from './lib/db';

export const onRequest = defineMiddleware(async (context, next) => {
  try {
    const siteConfig = await db.query('SELECT clave, valor FROM site_config');
    const config: Record<string, string> = {};
    siteConfig.rows.forEach((row: { clave: string; valor: string }) => { config[row.clave] = row.valor || ''; });
    context.locals.config = config;
  } catch (err) {
    console.error('Middleware error:', err);
    context.locals.config = {};
  }
  
  return next();
});