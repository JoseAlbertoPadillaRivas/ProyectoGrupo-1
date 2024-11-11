USE [master]
GO

CREATE DATABASE [PizzeriaJumbo]
GO

USE [PizzeriaJumbo]
GO

CREATE TABLE Puesto (
    ConsecutivoPuesto INT IDENTITY(1,1) PRIMARY KEY,
    NombrePuesto VARCHAR(100) NOT NULL
);

CREATE TABLE Empleado (
    ConsecutivoEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    Identificacion VARCHAR(50) NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    Nombre_Empleado VARCHAR(100) NOT NULL,
    Correo_Empleado VARCHAR(100) NOT NULL,
    Salario DECIMAL(10, 2),
    ConsecutivoPuesto INT,
    FOREIGN KEY (ConsecutivoPuesto) REFERENCES Puesto(ConsecutivoPuesto)
);


CREATE TABLE Plato (
    ConsecutivoPlato INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    RutaImagen VARCHAR(255)
);


CREATE TABLE Cliente (
    ConsecutivoCliente INT IDENTITY(1,1) PRIMARY KEY,
    Identificacion VARCHAR(50) NOT NULL,
    NombreCliente VARCHAR(100) NOT NULL,
    CorreoCliente VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Contrasena VARCHAR(100) NOT NULL
);

CREATE TABLE Carrito (
    ConsecutivoCarrito INT IDENTITY(1,1) PRIMARY KEY,
    ConsecutivoCliente INT,
    ConsecutivoPlato INT,
    Cantidad INT NOT NULL,
    FOREIGN KEY (ConsecutivoCliente) REFERENCES Cliente(ConsecutivoCliente),
    FOREIGN KEY (ConsecutivoPlato) REFERENCES Plato(ConsecutivoPlato)
);

CREATE TABLE Tipo_Factura (
    ConsecutivoTipo INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Factura (
    ConsecutivoFactura INT IDENTITY(1,1) PRIMARY KEY,
    ConsecutivoTipo INT,
    ConsecutivoCliente INT,
    ConsecutivoEmpleado INT,
    FechaCompra DATE,
    Subtotal DECIMAL(10, 2),
    Impuesto DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    FOREIGN KEY (ConsecutivoTipo) REFERENCES Tipo_Factura(ConsecutivoTipo),
    FOREIGN KEY (ConsecutivoCliente) REFERENCES Cliente(ConsecutivoCliente),
    FOREIGN KEY (ConsecutivoEmpleado) REFERENCES Empleado(ConsecutivoEmpleado)
);

CREATE TABLE DetalleFactura (
    ConsecutivoDetalleFactura INT IDENTITY(1,1) PRIMARY KEY,
    ConsecutivoFactura INT,
    ConsecutivoPlato INT,
    Cantidad INT NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    Subtotal DECIMAL(10, 2),
    Impuesto DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    FOREIGN KEY (ConsecutivoFactura) REFERENCES Factura(ConsecutivoFactura),
    FOREIGN KEY (ConsecutivoPlato) REFERENCES Plato(ConsecutivoPlato)
);



CREATE PROCEDURE [dbo].[RegistroEmpleado]
	@Identificacion varchar(50),
	@Contrasena varchar(255),
	@Nombre			varchar(255),
	@Correo			varchar(100),
	@Salario	DECIMAL(10, 2),
	@ConsecutivoPuesto INT
AS
BEGIN

	IF NOT EXISTS(SELECT 1 FROM dbo.Empleado
			      WHERE Identificacion = @Identificacion
					OR	Correo_Empleado = @Correo)
	BEGIN
		INSERT INTO dbo.Empleado (Identificacion,Contrasena,Nombre_Empleado,Correo_Empleado,Salario,ConsecutivoPuesto)
		VALUES (@Identificacion,@Contrasena,@Nombre,@Correo,@Salario,@ConsecutivoPuesto)
	END

END
GO

CREATE PROCEDURE [dbo].[IniciarSesion]
	@ConsecutivoEmpleado INT,
	@Contrasena	varchar(255)
AS
BEGIN
	
	SELECT	E.ConsecutivoEmpleado,
			Identificacion,
			Nombre_Empleado,
			Correo_Empleado,
			E.ConsecutivoPuesto,
			P.NombrePuesto,
			Salario
	  FROM	dbo.Empleado E
	  INNER JOIN dbo.Puesto P ON E.ConsecutivoPuesto = P.ConsecutivoPuesto
	  WHERE	ConsecutivoEmpleado = @ConsecutivoEmpleado
		AND Contrasena = @Contrasena

END