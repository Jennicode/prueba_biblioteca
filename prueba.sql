CREATE DATABASE biblioteca;

CREATE TABLE socios(
    id_socio SERIAL PRIMARY KEY,
    rut VARCHAR(11),
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono INT
);

INSERT INTO socios(rut, nombre, apellido, direccion, telefono) VALUES ('1111111-1', 'Juan', 'Soto', 'Avenida 1, Santiago', 911111111);
INSERT INTO socios(rut, nombre, apellido, direccion, telefono) VALUES ('2222222-2', 'Ana', 'Perez', 'Pasaje 2, Santiago', 922222222);
INSERT INTO socios(rut, nombre, apellido, direccion, telefono) VALUES ('3333333-3', 'Sandra', 'Aguilar', 'Avenida 2, Santiago', 933333333);
INSERT INTO socios(rut, nombre, apellido, direccion, telefono) VALUES ('4444444-4', 'Esteban', 'Jerez', 'Avenida 3, Santiago', 944444444);
INSERT INTO socios(rut, nombre, apellido, direccion, telefono) VALUES ('5555555-5', 'Silvana', 'Muñoz', 'Pasaje 3, Santiago', 955555555);

SELECT * FROM socios;

CREATE TABLE rol(
    id_rol SERIAL PRIMARY KEY,
    descripcion VARCHAR(50)
);

INSERT INTO rol(descripcion) VALUES ('principal');
INSERT INTO rol(descripcion) VALUES ('coautor');

SELECT * FROM rol;

CREATE TABLE autor(
    id_autor INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento INT,
    fecha_muerte INT,
    id_rol INT,
    FOREIGN KEY(id_rol) REFERENCES rol(id_rol)
);


INSERT INTO autor(id_autor, nombre, apellido, fecha_nacimiento, fecha_muerte, id_rol) VALUES (3,'Jose', 'Salgado', 1968, 2020, 1);
INSERT INTO autor(id_autor, nombre, apellido, fecha_nacimiento, fecha_muerte, id_rol) VALUES (4,'Ana', 'Salgado', 1972, null, 2);
INSERT INTO autor(id_autor, nombre, apellido, fecha_nacimiento, fecha_muerte, id_rol) VALUES (1,'Andres', 'Ulloa', 1982, null, 1);
INSERT INTO autor(id_autor, nombre, apellido, fecha_nacimiento, fecha_muerte, id_rol) VALUES (2,'Sergio', 'Mardones', 1950, 2012, 1);
INSERT INTO autor(id_autor, nombre, apellido, fecha_nacimiento, fecha_muerte, id_rol) VALUES (5,'Martin', 'Porta', 1976, null, 1);

SELECT * FROM autor;

CREATE TABLE libro(
    id_libro SERIAL PRIMARY KEY,
    isbn VARCHAR(20),
    titulo VARCHAR(50),
    numero_paginas INT,
    id_autor INT,
    FOREIGN KEY(id_autor) REFERENCES autor(id_autor)
);


INSERT INTO libro(isbn, titulo, numero_paginas, id_autor) VALUES ('111-1111111-111', 'Cuentos de terror', 344, 3);
INSERT INTO libro(isbn, titulo, numero_paginas, id_autor) VALUES ('111-1111111-111', 'Cuentos de terror', 344, 4);
INSERT INTO libro(isbn, titulo, numero_paginas, id_autor) VALUES ('222-2222222-222', 'Poesias Contemporaneas', 167, 1);
INSERT INTO libro(isbn, titulo, numero_paginas, id_autor) VALUES ('333-3333333-333', 'Historia de Asia', 511, 2);
INSERT INTO libro(isbn, titulo, numero_paginas, id_autor) VALUES ('444-4444444-444', 'Manual de mecanica', 298, 5);

SELECT * FROM libro;

CREATE TABLE historial_prestamo(
    codigo_prestamo SERIAL PRIMARY KEY,
    fecha_inicio DATE,
    fecha_esperada_devolucion DATE,
    fecha_real_devolucion DATE,
    dias_de_prestamo INT,
    dias_de_atraso INT,
    id_socio INT,
    FOREIGN KEY(id_socio) REFERENCES socios(id_socio),
    id_libro INT,
    FOREIGN KEY(id_libro) REFERENCES libro(id_libro)
);


INSERT INTO historial_prestamo(fecha_inicio, fecha_esperada_devolucion, fecha_real_devolucion, dias_de_prestamo, dias_de_atraso, id_socio, id_libro) VALUES ('2020-01-20', '2020-01-27', '2020-01-27', 7, 0, 1, 1);
INSERT INTO historial_prestamo(fecha_inicio, fecha_esperada_devolucion, fecha_real_devolucion, dias_de_prestamo, dias_de_atraso, id_socio, id_libro) VALUES ('2020-01-20', '2020-01-27', '2020-01-30', 7, 3, 5, 3);
INSERT INTO historial_prestamo(fecha_inicio, fecha_esperada_devolucion, fecha_real_devolucion, dias_de_prestamo, dias_de_atraso, id_socio, id_libro) VALUES ('2020-01-22', '2020-02-05', '2020-01-30', 14, 0, 3, 4);
INSERT INTO historial_prestamo(fecha_inicio, fecha_esperada_devolucion, fecha_real_devolucion, dias_de_prestamo, dias_de_atraso, id_socio, id_libro) VALUES ('2020-01-23', '2020-02-06', '2020-01-30', 14, 0, 4, 5);
INSERT INTO historial_prestamo(fecha_inicio, fecha_esperada_devolucion, fecha_real_devolucion, dias_de_prestamo, dias_de_atraso, id_socio, id_libro) VALUES ('2020-01-27', '2020-02-03', '2020-02-04', 7, 1, 2, 1);
INSERT INTO historial_prestamo(fecha_inicio, fecha_esperada_devolucion, fecha_real_devolucion, dias_de_prestamo, dias_de_atraso, id_socio, id_libro) VALUES ('2020-01-31', '2020-02-14', '2020-02-12', 14, 0, 1, 5);
INSERT INTO historial_prestamo(fecha_inicio, fecha_esperada_devolucion, fecha_real_devolucion, dias_de_prestamo, dias_de_atraso, id_socio, id_libro) VALUES ('2020-01-31', '2020-02-07', '2020-02-12', 7, 5, 3, 3);

SELECT * FROM historial_prestamo;

-- 3.-
--a. Mostrar todos los libros que posean menos de 300 páginas.
SELECT * FROM libro WHERE numero_paginas < 300;

-- b.- Mostrar todos los autores que hayan nacido después del 01-01-1970.
/**
    Dado que no se entrega el día ni el mes de nacimiento, se realizará la consulta solo con el año
*/
SELECT * FROM autor WHERE fecha_nacimiento > 1970;

-- c.- ¿Cuál es el libro más solicitado?
SELECT COUNT(hp.id_libro), lb.titulo FROM historial_prestamo hp LEFT JOIN libro lb on hp.id_libro = lb.id_libro GROUP BY hp.id_libro, lb.titulo ORDER BY 1 DESC;
/*
    Según query: SELECT COUNT(hp.id_libro), lb.titulo FROM historial_prestamo hp LEFT JOIN libro lb on hp.id_libro = lb.id_libro GROUP BY hp.id_libro, lb.titulo;
    Los libros más solicitados son:
    count  |         titulo
    -------+------------------------
      2    | Manual de mecanica
      2    | Poesias Contemporaneas
      2    | Cuentos de terror
      1    | Historia de Asia
*/

-- d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.
SELECT (dias_de_atraso*100) as multa  FROM historial_prestamo;




