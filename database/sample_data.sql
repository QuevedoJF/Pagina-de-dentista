INSERT INTO carousel (imagen_url, titulo, subtitulo, orden) VALUES
('https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=1200&h=600&fit=crop', 'Sonrisa Perfecta', 'Tratamientos de última generación', 1),
('https://images.unsplash.com/photo-1609840114035-3c9e2e2e9d7c?w=1200&h=600&fit=crop', 'Equipo Experto', 'Profesionales certificados internacionalmente', 2),
('https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=1200&h=600&fit=crop', 'Tecnología Avanzada', 'Equipos de última generación', 3);

INSERT INTO reviews (nombre_autor, comentario, estrellas) VALUES
('Carlos Mendoza', 'Excelente atención y resultados increíbles. Mi sonrisa nunca se vio mejor.', 5),
('Laura Pérez', 'El Dr. López es muy profesional y el tratamiento fue indoloro. 100% recomendado.', 5),
('Miguel Torres', 'La clínica es hermosa y el personal muy amable. Volveré sin duda.', 4),
('Ana Rodríguez', 'Mi tratamiento de blanqueamiento fue excelente. Resultados superiores.', 5),
('Pedro Jiménez', 'Muy satisfecho con mis implantes. Calidad mundial a precios justos.', 5);

INSERT INTO staff (nombre, cargo, foto_url, orden) VALUES
('Dra. María García', 'Directora General / Ortodoncista', 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=400&fit=crop', 1),
('Dr. Carlos López', 'Odontólogo General', 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop', 2),
('Dra. Ana Martínez', 'Periodoncista', 'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400&h=400&fit=crop', 3),
('Dr. Roberto Sánchez', 'Cirujano Maxilofacial', 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=400&h=400&fit=crop', 4);

INSERT INTO services_costs (titulo, descripcion, precio, imagen_url, categoria, orden) VALUES
('Limpieza Dental', 'Limpieza profunda con ultrasonido y pulido profesional', 80.00, 'https://images.unsplash.com/photo-1609840114035-3c9e2e2e9d7c?w=600&h=400&fit=crop', 'Preventivo', 1),
('Blanqueamiento', 'Tratamiento de blanqueamiento dental profesional', 350.00, 'https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=600&h=400&fit=crop', 'Estético', 2),
('Ortodoncia Invisible', 'Tratamiento con aligners transparentes', 4500.00, 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=600&h=400&fit=crop', 'Ortodoncia', 3),
('Implantes Dentales', 'Implantes de titanio con corona de zirconia', 1200.00, 'https://images.unsplash.com/photo-1596704017254-9b121068fb31?w=600&h=400&fit=crop', 'Restauración', 4),
('Radiografías Digitales', 'Panorámica y periapical digital', 45.00, 'https://images.unsplash.com/photo-1517331156700-3c241d2b4d83?w=600&h=400&fit=crop', 'Diagnóstico', 5),
('Carillas de Porcelana', 'Carillas ultrafinas para sonrisa perfecta', 800.00, 'https://images.unsplash.com/photo-1601262822501-336c4c2c0934?w=600&h=400&fit=crop', 'Estético', 6);

INSERT INTO blog_promos (tipo, titulo, contenido, imagen_url, visible) VALUES
('post', '5 Tips para Mantener tus Dientes Sanos', '<p>1. Cepíllate después de cada comida<br>2. Usa hilo dental diariamente<br>3. Visita al dentista cada 6 meses<br>4. Evita alimentos demasiado fríos o calientes<br>5. No uses tus dientes como herramientas</p>', 'https://images.unsplash.com/photo-1609840114035-3c9e2e2e9d7c?w=600&h=400&fit=crop', true),
('post', '¿Qué es la Ortodoncia Invisible?', '<p>La ortodoncia invisible utiliza alineadores transparentes personalizados para corregir la posición de tus dientes de forma gradual y casi imperceptible.</p>', 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?w=600&h=400&fit=crop', true),
('promocion', '20% de Descuento en Limpieza Dental', '<p>Por el mes de la salud dental, obtén un 20% de descuento en limpieza dental profunda. Incluye ultrasonido, pulido y flúor.</p>', 'https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=600&h=400&fit=crop', true);
