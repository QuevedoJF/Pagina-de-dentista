-- =====================================================
-- CLÍNICA DENTAL DE LUJO - ESQUEMA POSTGRESQL
-- Creado para Navicat Premium
-- =====================================================

-- -----------------------------------------------------
-- CREAR BASE DE DATOS
-- -----------------------------------------------------
CREATE DATABASE clinica_dental
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

-- -----------------------------------------------------
-- CONECTAR A LA BASE DE DATOS Y CREAR TABLAS
-- -----------------------------------------------------

-- Extensión para generar IDs automáticos
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- -----------------------------------------------------
-- TABLA: users
-- -----------------------------------------------------
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(20) DEFAULT 'user' CHECK (rol IN ('admin', 'user')),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_nombre ON users(nombre);
CREATE INDEX idx_users_email ON users(email);

-- -----------------------------------------------------
-- TABLA: staff
-- -----------------------------------------------------
CREATE TABLE staff (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    foto_url VARCHAR(500),
    orden INTEGER DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_staff_orden ON staff(orden);

-- -----------------------------------------------------
-- TABLA: services_costs
-- -----------------------------------------------------
CREATE TABLE services_costs (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2),
    imagen_url VARCHAR(500),
    categoria VARCHAR(100),
    orden INTEGER DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_services_categoria ON services_costs(categoria);
CREATE INDEX idx_services_orden ON services_costs(orden);

-- -----------------------------------------------------
-- TABLA: carousel
-- -----------------------------------------------------
CREATE TABLE carousel (
    id SERIAL PRIMARY KEY,
    imagen_url VARCHAR(500) NOT NULL,
    titulo VARCHAR(200),
    subtitulo VARCHAR(300),
    orden INTEGER DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_carousel_orden ON carousel(orden);

-- -----------------------------------------------------
-- TABLA: reviews
-- -----------------------------------------------------
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    nombre_autor VARCHAR(150),
    comentario TEXT NOT NULL,
    estrellas INTEGER CHECK (estrellas BETWEEN 1 AND 5),
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_reviews_activo ON reviews(activo);
CREATE INDEX idx_reviews_fecha ON reviews(fecha_creacion DESC);

-- -----------------------------------------------------
-- TABLA: blog_promos
-- -----------------------------------------------------
CREATE TABLE blog_promos (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('post', 'promocion')),
    titulo VARCHAR(250) NOT NULL,
    contenido TEXT,
    imagen_url VARCHAR(500),
    visible BOOLEAN DEFAULT TRUE,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_blog_tipo ON blog_promos(tipo);
CREATE INDEX idx_blog_fecha ON blog_promos(fecha_publicacion DESC);

-- -----------------------------------------------------
-- TABLA: site_config (clave-valor)
-- -----------------------------------------------------
CREATE TABLE site_config (
    clave VARCHAR(100) PRIMARY KEY,
    valor TEXT,
    tipo VARCHAR(20) DEFAULT 'text' CHECK (tipo IN ('text', 'image', 'html')),
    categoria VARCHAR(50),
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_config_categoria ON site_config(categoria);

-- -----------------------------------------------------
-- DATOS INICIALES: Admin por defecto
-- -----------------------------------------------------
INSERT INTO users (nombre, email, password, rol)
VALUES ('admin', NULL, 'admin173', 'admin');

-- -----------------------------------------------------
-- DATOS INICIALES: Configuración del sitio
-- -----------------------------------------------------
INSERT INTO site_config (clave, valor, tipo, categoria) VALUES
-- Home
('hero_titulo', 'Sonrisa Perfecta, Vida Perfecta', 'text', 'home'),
('hero_subtitulo', 'Experimenta el cuidado dental de clase mundial', 'text', 'home'),
('hero_cta', 'Agenda tu Cita', 'text', 'home'),

-- Sobre Nosotros
('sobre_nosotros_titulo', 'Sobre Nosotros', 'text', 'sobre_nosotros'),
('sobre_nosotros_contenido', '<p>Somos una clínica dental de lujo con más de 15 años de experiencia en el cuidado de tu sonrisa. Nuestro equipo de profesionales altamente capacitados combina tecnología de vanguardia con un trato cálido y personalizado para brindarte la mejor experiencia odontológica.</p>', 'html', 'sobre_nosotros'),
('sobre_nosotros_imagen', '/images/clinica.jpg', 'image', 'sobre_nosotros'),

-- Misión
('mision_titulo', 'Nuestra Misión', 'text', 'mision'),
('mision_contenido', '<p>Brindar servicios odontológicos de excelencia con un enfoque humano y personalizado, utilizando las técnicas más modernas y materiales de primera calidad para garantizar resultados óptimos y duraderos.</p>', 'html', 'mision'),

-- Visión
('vision_titulo', 'Nuestra Visión', 'text', 'vision'),
('vision_contenido', '<p>Ser la clínica dental de referencia en Latinoamérica, reconocidos por nuestra excelencia profesional, innovación tecnológica y compromiso inquebrantable con la satisfacción de nuestros pacientes.</p>', 'html', 'vision'),

-- Ubicación
('ubicacion_titulo', 'Nuestra Ubicación', 'text', 'ubicacion'),
('ubicacion_direccion', 'Av. Libertadores 1234, San Isidro, Lima, Perú', 'text', 'ubicacion'),
('ubicacion_telefono', '+51 987 654 321', 'text', 'ubicacion'),
('ubicacion_email', 'contacto@clinica-dental.lux', 'text', 'ubicacion'),
('ubicacion_mapa', 'https://maps.google.com/?q=-12.0925,-77.0425', 'text', 'ubicacion'),

-- FAQ
('faq_titulo', 'Preguntas Frecuentes', 'text', 'faq'),
('faq_contenido', '<p>Contenido de preguntas frecuentes...</p>', 'html', 'faq'),

-- Footer
('footer_texto', '© 2024 Clínica Dental de Lujo. Todos los derechos reservados.', 'text', 'footer'),
('footer_facebook', 'https://facebook.com/clinica', 'text', 'footer'),
('footer_instagram', 'https://instagram.com/clinica', 'text', 'footer');

-- -----------------------------------------------------
-- DATOS DE EJEMPLO: Staff
-- -----------------------------------------------------
INSERT INTO staff (nombre, cargo, foto_url, orden) VALUES
('Dra. María García', 'Directora General / Ortodoncista', 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=400&fit=crop', 1),
('Dr. Carlos López', 'Odontólogo General', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop', 2),
('Dra. Ana Martínez', 'Periodoncista', 'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400&h=400&fit=crop', 3),
('Dr. Roberto Sánchez', 'Cirujano Maxilofacial', 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=400&h=400&fit=crop', 4);

-- -----------------------------------------------------
-- DATOS DE EJEMPLO: Servicios
-- -----------------------------------------------------
INSERT INTO services_costs (titulo, descripcion, precio, imagen_url, categoria, orden) VALUES
('Limpieza Dental', 'Limpieza profunda con ultrasonido y pulido profesional', 80.00, 'https://images.unsplash.com/photo-1609840114035-3c9e2e2e9d7c?w=600&h=400&fit=crop', 'Preventivo', 1),
('Blanqueamiento', 'Tratamiento de blanqueamiento dental profesional', 350.00, 'https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=600&h=400&fit=crop', 'Estético', 2),
('Ortodoncia Invisible', 'Tratamiento con aligners transparentes', 4500.00, 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=600&h=400&fit=crop', 'Ortodoncia', 3),
('Implantes Dentales', 'Implantes de titanio con corona de zirconia', 1200.00, 'https://images.unsplash.com/photo-1596704017254-9b121068fb31?w=600&h=400&fit=crop', 'Restauración', 4),
('Radiografías Digitales', 'Panorámica y periapical digital', 45.00, 'https://images.unsplash.com/photo-1517331156700-3c241d2b4d83?w=600&h=400&fit=crop', 'Diagnóstico', 5),
('Carillas de Porcelana', 'Carillas ultrafinas para sonrisa perfecta', 800.00, 'https://images.unsplash.com/photo-1601262822501-336c4c2c0934?w=600&h=400&fit=crop', 'Estético', 6);

-- -----------------------------------------------------
-- DATOS DE EJEMPLO: Carrusel
-- -----------------------------------------------------
INSERT INTO carousel (imagen_url, titulo, subtitulo, orden) VALUES
('https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=1200&h=600&fit=crop', 'Sonrisa Perfecta', 'Tratamientos de última generación', 1),
('https://images.unsplash.com/photo-1609840114035-3c9e2e2e9d7c?w=1200&h=600&fit=crop', 'Equipo Experto', 'Profesionales certificados internacionalmente', 2),
('https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=1200&h=600&fit=crop', 'Tecnología Avanzada', 'Equipos de última generación', 3);

-- -----------------------------------------------------
-- DATOS DE EJEMPLO: Reviews
-- -----------------------------------------------------
INSERT INTO reviews (nombre_autor, comentario, estrellas) VALUES
('Carlos Mendoza', 'Excelente atención y resultados increíbles. Mi sonrisa nunca se vio mejor.', 5),
('Laura Pérez', 'El dr. López es muy profesional y el tratamiento fue indoloro. 100% recomendado.', 5),
('Miguel Torres', 'La clínica es hermosa y el personal muy amable. Volveré sin duda.', 4),
('Ana Rodríguez', 'Mi tratamiento de blanqueamiento fue excelente. Resultados superiores.', 5),
('Pedro Jiménez', 'Muy satisfecho con mis implantes. Calidad mundial a precios justos.', 5);

-- -----------------------------------------------------
-- DATOS DE EJEMPLO: Blog
-- -----------------------------------------------------
INSERT INTO blog_promos (tipo, titulo, contenido, imagen_url) VALUES
('post', '5 Tips para Mantener tus Dientes Sanos', '<p>1. Cepíllate después de cada comida<br>2. Usa hilo dental diariamente<br>3. Visita al dentista cada 6 meses<br>4. Evita alimentos demasiado fríos o calientes<br>5. No uses tus dientes como herramientas</p>', 'https://images.unsplash.com/photo-1609840114035-3c9e2e2e9d7c?w=600&h=400&fit=crop'),
('post', '¿Qué es la Ortodoncia Invisible?', '<p>La ortodoncia invisible utiliza alineadores transparentes personalizados para corregir la posición de tus dientes de forma gradual y casi imperceptible. Es la opción ideal para adultos que buscan una sonrisa perfecta sin comprometer su apariencia.</p>', 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=600&h=400&fit=crop'),
('promocion', '20% de Descuento en Limpieza Dental', '<p>Por el mes de la salud dental, obtén un 20% de descuento en limpieza dental profunda. Incluye ultrasonido, pulido y flúor. Válido solo para nuevas citas durante todo el mes.</p>', 'https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=600&h=400&fit=crop'),
('promocion', 'Pack Sonrisa Perfecta - 30% OFF', '<p>Pack completo que incluye limpieza, blanqueamiento y carillas. Ahorra 30% cuando adquieras los tres tratamientos. Pago en cuotas sin intereses.</p>', 'https://images.unsplash.com/photo-1601262822501-336c4c2c0934?w=600&h=400&fit=crop');

-- -----------------------------------------------------
-- VERIFICACIÓN
-- -----------------------------------------------------
SELECT 'Base de datos creada exitosamente' AS estado;
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';