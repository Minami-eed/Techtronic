USE DB_TECTRONIC
GO

-- Insertar usuario
INSERT INTO USUARIO (Nombres, Apellidos, Correo, Contrasena, EsAdministrador)
VALUES ('test', 'user', 'admin@example.com', 'admin123', 1)
GO

-- Insertar categor�as
INSERT INTO CATEGORIA (Descripcion)
VALUES
    ('Computo'),
    ('Celulares'),
    ('Videojuegos'),
    ('Smartwatches'),
    ('Camaras'),
    ('Audio'),
    ('Smarthome y Dom�tica'),
    ('Mundo Gamer')
GO

-- Insertar marcas
INSERT INTO MARCA (Descripcion)
VALUES
    ('SONY'),
    ('HP'),
    ('LG'),
    ('HYUNDAI'),
    ('CANON'),
    ('HUAWEI'),
    ('APPLE'),
    ('SAMSUNG'),
    ('XIAOMI'),
    ('AOC'),
    ('LOGITECH'),
    ('LENOVO'),
    ('NINTENDO'),
    ('MICROSOFT'),
    ('NIKON'),
    ('AMAZON'),
    ('BUYPAL'),
    ('TPLINK'),
    ('HIKVISION'),
    ('GOOGLE'),
    ('ASUS'),
    ('EPSON'),
    ('TEROS'),
    ('MOTOROLA')
GO

-- Insertar 40 productos adicionales
insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('HP Laptop 15-EF1019LA','Procesador: AMD RYZEN R5, 
Modelo tarjeta de video: Gr�ficos AMD Radeon, 
Tama�o de la pantalla: 15.6 pulgadas, 
Disco duro s�lido: 512GB, 
N�cleos del procesador: Hexa Core', 2, 1,2500,10,'~/Imagenes/Productos/1.jpeg', 1)

insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('Laptop Lenovo IdeaPad 3i','Procesador: Core I3, 
Modelo tarjeta de video: Gr�ficos intel, 
Tama�o de la pantalla: 15.6 pulgadas, 
Disco duro s�lido: 1TB, 
N�cleos del procesador: Hexa Core',12,1,'2000','20','~/Imagenes/Productos/2.jpeg', 1)
GO

insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('CPU Lenovo ThinkCentre M720s','Procesador: Core I7, 
Modelo tarjeta de video: Gr�ficos intel, 
Condici�n del producto: Reacondicionado, 
Disco duro s�lido: 1TB, 
N�cleos del procesador: Hexa Core',12,1,'1479','30','~/Imagenes/Productos/3.jpeg', 1)
GO

insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('MONITOR LED LG 26WQ500-B','Tama�o de pantalla: 22", 
Condici�n del producto: Nuevo, 
Pais de origen: China',
3,1,'650','40','~/Imagenes/Productos/4.jpeg', 1)
GO

insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('Apple MacBook Air','Procesador: Chip M1, 
Modelo tarjeta de video: Apple, 
Tama�o de la pantalla: 13 pulgadas, 
Disco duro s�lido: 256GB, 
N�cleos del procesador: Octa Core',7,1,'5199','20','~/Imagenes/Productos/5.jpeg', 1)
GO

insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('Impresora multifuncional L3250',
'Condici�n del producto: Nuevo, 
Conexion Bluetooth: No, 
Pais de origen: China',
22,1,'699','40','~/Imagenes/Productos/6.jpeg', 1)
GO
------------------------------------------------------
insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('Celular Galaxy A14','Tama�o de pantalla: 5.5", 
Procesador: Mediatek, 
Almacenamiento: 128 GB, 
Color: black, 
Memoria RAM: 4 GB',8,2,'999','60','~/Imagenes/Productos/7.jpeg', 1)
GO

insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('Celular Xiaomi Redmi 12','Tama�o de pantalla: 6.5", 
Procesador: Mediatek Helio G88, 
Almacenamiento: 128 GB, 
Color: black, 
Memoria RAM: 2 GB',9,2,'599','60','~/Imagenes/Productos/8.jpeg', 1)
GO

insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('Celular Apple iPhone 13 ','Tama�o de pantalla: 6.5", 
Procesador: A15, 
Almacenamiento: 128 GB, 
Color: black, 
Memoria RAM: 4 GB',8,2,'3399','60','~/Imagenes/Productos/9.jpeg', 1)
GO

insert into PRODUCTO(Nombre,Descripcion,IdMarca,IdCategoria,Precio,Stock,RutaImagen,Activo) 
values('Smartphone Moto G23 4G','Tama�o de pantalla: 5.5", 
Procesador: MTK G85, 
Almacenamiento: 128 GB, 
Color: Gris, 
Memoria RAM: 3 GB',24,2,'489','60','~/Imagenes/Productos/10.jpeg', 1)
GO