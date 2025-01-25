USE master
GO

--=======================================================================
-- Creación de la base de datos -----------------------------------------
--=======================================================================
IF EXISTS(SELECT * FROM SysDataBases WHERE name='Blog_EF01')
BEGIN
	DROP DATABASE Blog_EF01
END
GO

CREATE DATABASE Blog_EF01
GO

USE Blog_EF01
GO

--=======================================================================
-- Creación de Tablas ---------------------------------------------------
--=======================================================================

CREATE TABLE Categoria(
    CodigoCat VARCHAR(6) PRIMARY KEY CHECK(LEN(CodigoCat)=6),
    Nombre VARCHAR(40) NOT NULL	
)
GO

CREATE TABLE Articulo(
    CodigoArt VARCHAR(10) PRIMARY KEY CHECK(LEN(CodigoArt)=10),
    Descripcion VARCHAR(40) NOT NULL,
	Precio MONEY NOT NULL CHECK(Precio > 0),
	FchIngreso DATE NOT NULL,
	CodigoCat VARCHAR(6) NOT NULL

	CONSTRAINT FK_Articulo_Categoria FOREIGN KEY (CodigoCat) REFERENCES Categoria(CodigoCat)
)
GO

CREATE TABLE Cliente(
    Documento VARCHAR(10) PRIMARY KEY CHECK(Documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    NombreCli VARCHAR(60) NOT NULL CHECK (NombreCli NOT LIKE '%[^a-zA-ZáÁéÉíÍóÓúÚñ ]%'),
    NroTarjeta VARCHAR(16) NOT NULL CHECK(NroTarjeta LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	NroTelefono VARCHAR(9) NOT NULL CHECK(NroTelefono LIKE '%[0-9]%'),
	Domicilio VARCHAR(40) NOT NULL
)
GO

--=======================================================================
-- DATOS DE PRUEBA: Categorías ------------------------------------------
--======================================================================= 
INSERT INTO Categoria (CodigoCat, Nombre) VALUES
('ESC123','Útiles Escolares');
INSERT INTO Categoria (CodigoCat, Nombre) VALUES
('CCI456','Cocina');
INSERT INTO Categoria (CodigoCat, Nombre) VALUES
('MIS789','Miscelánea');

--=======================================================================
-- DATOS DE PRUEBA: Artículos -------------------------------------------
--======================================================================= 
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('A000000001', 'Lápiz HB', 15.50, '2025-12-31', 'ESC123');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('B000000002', 'Cuaderno A4', 120.75, '2025-11-15', 'ESC123');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('C000000003', 'Mochila Escolar', 850.00, '2026-01-30', 'ESC123');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('D000000004', 'Resma de Papel', 340.90, '2025-10-10', 'MIS789');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('E000000005', 'Tijera', 45.00, '2025-09-01', 'MIS789');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('F000000006', 'Destornillador', 12.99, '2025-08-20', 'MIS789');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('G000000007', 'Licuadora', 25.50, '2025-07-15', 'CCI456');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('H000000008', 'Set Cuchillos', 8.75, '2025-06-10', 'CCI456');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('I000000009', 'Batidora', 60.00, '2025-05-05', 'CCI456');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('J000000010', 'Juguera', 20.00, '2025-04-01', 'CCI456');
INSERT INTO Articulo (CodigoArt, Descripcion, Precio, FchIngreso, CodigoCat) VALUES
('K000000011', 'Smartphone', 8000.00, '2025-01-09', 'CCI456');

--=======================================================================
-- DATOS DE PRUEBA: Clientes --------------------------------------------
--=======================================================================
INSERT INTO Cliente (Documento, NombreCli, NroTarjeta, NroTelefono, Domicilio) VALUES
('1111122222', 'Laura Díaz', '4422442244224422', '099111222', '18 de Julio 0001');
INSERT INTO Cliente (Documento, NombreCli, NroTarjeta, NroTelefono, Domicilio) VALUES
('3333344444', 'Andrés Pérez', '4433443344334433', '098333444', 'Ramón Anador 0002');
INSERT INTO Cliente (Documento, NombreCli, NroTarjeta, NroTelefono, Domicilio) VALUES
('5555566666', 'María Aguilar', '4455445544554455', '097555666', 'París 0003');
INSERT INTO Cliente (Documento, NombreCli, NroTarjeta, NroTelefono, Domicilio) VALUES
('7777788888', 'Ernesto González', '4466446644664466', '096777888', 'Colón 0004');
INSERT INTO Cliente (Documento, NombreCli, NroTarjeta, NroTelefono, Domicilio) VALUES
('9999900000', 'Soraya De León', '4477447744774477', '095999000', 'Alfonzo Ruíz 0005');