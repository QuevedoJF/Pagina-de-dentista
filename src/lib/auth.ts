import bcrypt from 'bcryptjs';

const SALT_ROUNDS = 12;

export interface SessionUser {
  id: number;
  nombre: string;
  email: string | null;
  rol: 'admin' | 'user';
}

function oldHashPassword(password: string): string {
  let hash = 0;
  const str = password + 'clinica-salt-2024';
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash;
  }
  return Math.abs(hash).toString(16).padStart(8, '0') + str.length.toString(16);
}

function isOldHashFormat(hashed: string): boolean {
  return /^[a-f0-9]{8}/.test(hashed) && hashed.length > 8;
}

export async function hashPassword(password: string): Promise<string> {
  return bcrypt.hash(password, SALT_ROUNDS);
}

export async function verifyPassword(password: string, hashed: string): Promise<boolean> {
  if (isOldHashFormat(hashed)) {
    return oldHashPassword(password) === hashed;
  }
  return bcrypt.compare(password, hashed);
}

export function needsRehash(hashed: string): boolean {
  return isOldHashFormat(hashed);
}

export async function getSession(context: { cookies: any }): Promise<SessionUser | null> {
  const sessionCookie = context.cookies.get('session')?.value;
  if (!sessionCookie) return null;

  try {
    const [id, nombre, email, rol] = sessionCookie.split('|');
    if (!id || !nombre || !rol) return null;
    return { id: parseInt(id), nombre, email: email || null, rol: rol as 'admin' | 'user' };
  } catch {
    return null;
  }
}

export function createSessionCookie(user: SessionUser): string {
  return `${user.id}|${user.nombre}|${user.email || ''}|${user.rol}`;
}

export function requireAuth(user: SessionUser | null): Response | null {
  if (!user) {
    return new Response(null, { status: 302, headers: { Location: '/login' } });
  }
  return null;
}

export function requireAdmin(user: SessionUser | null): Response | null {
  if (!user || user.rol !== 'admin') {
    return new Response(null, { status: 302, headers: { Location: '/login' } });
  }
  return null;
}