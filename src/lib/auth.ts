export interface SessionUser {
  id: number;
  nombre: string;
  email: string | null;
  rol: 'admin' | 'user';
}

export function hashPassword(password: string): string {
  let hash = 0;
  const str = password + 'clinica-salt-2024';
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash;
  }
  return Math.abs(hash).toString(16).padStart(8, '0') + str.length.toString(16);
}

export function verifyPassword(password: string, hashed: string): boolean {
  return hashPassword(password) === hashed;
}

export async function verifyPasswordAsync(password: string, hashed: string): Promise<boolean> {
  return hashPassword(password) === hashed;
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