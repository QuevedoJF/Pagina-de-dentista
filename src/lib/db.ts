import pg from 'pg';

const { Pool } = pg;

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'dentista',
  user: 'postgres',
  password: '1234',
});

export const queries = {
  users: {
    findByNombre: async (nombre: string) => {
      const result = await pool.query('SELECT * FROM users WHERE nombre = $1', [nombre]);
      return result.rows[0] || null;
    },
    getAll: async () => {
      const result = await pool.query('SELECT id, nombre, email, rol, fecha_creacion FROM users ORDER BY fecha_creacion DESC');
      return result.rows;
    },
    updatePassword: async (id: number, hashedPassword: string) => {
      await pool.query('UPDATE users SET password = $1 WHERE id = $2', [hashedPassword, id]);
    },
  },
  reviews: {
    getActive: async () => {
      const result = await pool.query("SELECT r.*, u.nombre as usuario_nombre FROM reviews r LEFT JOIN users u ON r.user_id = u.id WHERE r.activo = true ORDER BY r.fecha_creacion DESC");
      return result.rows;
    },
    getAll: async () => {
      const result = await pool.query("SELECT r.*, u.nombre as usuario_nombre FROM reviews r LEFT JOIN users u ON r.user_id = u.id ORDER BY r.fecha_creacion DESC");
      return result.rows;
    },
    create: async (userId: any, nombreAutor: string, comentario: string, estrellas: number) => {
      await pool.query('INSERT INTO reviews (user_id, nombre_autor, comentario, estrellas) VALUES ($1, $2, $3, $4)', [userId, nombreAutor, comentario, estrellas]);
    },
    delete: async (id: number) => {
      await pool.query('UPDATE reviews SET activo = false WHERE id = $1', [id]);
    },
    approve: async (id: number) => {
      await pool.query('UPDATE reviews SET activo = true WHERE id = $1', [id]);
    },
    getStats: async () => {
      const result = await pool.query("SELECT COUNT(*) as total, AVG(estrellas) as promedio FROM reviews");
      return result.rows[0] || { total: 0, promedio: 0 };
    },
  },
  staff: {
    getActive: async () => {
      const result = await pool.query('SELECT * FROM staff WHERE activo = true ORDER BY orden ASC');
      return result.rows;
    },
    getAll: async () => {
      const result = await pool.query('SELECT * FROM staff ORDER BY orden ASC');
      return result.rows;
    },
    create: async (nombre: string, cargo: string, fotoUrl: string, orden: number) => {
      await pool.query('INSERT INTO staff (nombre, cargo, foto_url, orden) VALUES ($1, $2, $3, $4)', [nombre, cargo, fotoUrl, orden]);
    },
    delete: async (id: number) => {
      await pool.query('DELETE FROM staff WHERE id = $1', [id]);
    },
  },
  services: {
    getActive: async () => {
      const result = await pool.query('SELECT * FROM services_costs WHERE activo = true ORDER BY orden ASC');
      return result.rows;
    },
    getAll: async () => {
      const result = await pool.query('SELECT * FROM services_costs ORDER BY orden ASC');
      return result.rows;
    },
    create: async (titulo: string, descripcion: string, precio: number, imagenUrl: string, categoria: string, orden: number) => {
      await pool.query('INSERT INTO services_costs (titulo, descripcion, precio, imagen_url, categoria, orden) VALUES ($1, $2, $3, $4, $5, $6)', [titulo, descripcion, precio, imagenUrl, categoria, orden]);
    },
    delete: async (id: number) => {
      await pool.query('DELETE FROM services_costs WHERE id = $1', [id]);
    },
  },
  carousel: {
    getActive: async () => {
      const result = await pool.query('SELECT * FROM carousel WHERE activo = true ORDER BY orden ASC LIMIT 5');
      return result.rows;
    },
    getAll: async () => {
      const result = await pool.query('SELECT * FROM carousel ORDER BY orden ASC');
      return result.rows;
    },
    create: async (imagenUrl: string, titulo: string, subtitulo: string, orden: number) => {
      await pool.query('INSERT INTO carousel (imagen_url, titulo, subtitulo, orden) VALUES ($1, $2, $3, $4)', [imagenUrl, titulo, subtitulo, orden]);
    },
    delete: async (id: number) => {
      await pool.query('DELETE FROM carousel WHERE id = $1', [id]);
    },
  },
  blogPromos: {
    getByType: async (tipo: string) => {
      const result = await pool.query('SELECT * FROM blog_promos WHERE tipo = $1 AND visible = true ORDER BY fecha_publicacion DESC', [tipo]);
      return result.rows;
    },
    getAll: async () => {
      const result = await pool.query('SELECT * FROM blog_promos ORDER BY fecha_publicacion DESC');
      return result.rows;
    },
    create: async (tipo: string, titulo: string, contenido: string, imagenUrl: string, visible: number) => {
      await pool.query('INSERT INTO blog_promos (tipo, titulo, contenido, imagen_url, visible) VALUES ($1, $2, $3, $4, $5)', [tipo, titulo, contenido, imagenUrl, visible]);
    },
    delete: async (id: number) => {
      await pool.query('DELETE FROM blog_promos WHERE id = $1', [id]);
    },
  },
  siteConfig: {
    getAll: async () => {
      const result = await pool.query('SELECT * FROM site_config ORDER BY categoria, clave');
      return result.rows;
    },
    upsert: async (clave: string, valor: string, tipo: string, categoria: string) => {
      await pool.query('INSERT INTO site_config (clave, valor, tipo, categoria) VALUES ($1, $2, $3, $4) ON CONFLICT (clave) DO UPDATE SET valor = $2, tipo = $3, categoria = $4', [clave, valor, tipo, categoria]);
    },
  },
};

export default pool;