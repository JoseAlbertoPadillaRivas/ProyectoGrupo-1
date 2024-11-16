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

--CREATE TABLE Empleado (
	--ConsecutivoEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    --Identificacion VARCHAR(50) NOT NULL,
    --Contrasena VARCHAR(255) NOT NULL,
    --Nombre_Empleado VARCHAR(100) NOT NULL,
    --Correo_Empleado VARCHAR(100) NOT NULL,
    --Salario DECIMAL(10, 2),
    --ConsecutivoPuesto INT,
    --FOREIGN KEY (ConsecutivoPuesto) REFERENCES Puesto(ConsecutivoPuesto)
	--FOREIGN KEY (ConsecutivoRol) REFERENCES Roles(ConsecutivoRol)--nueva fk de roles

--);

--nueva tabla
CREATE TABLE Roles(
ConsecutivoRol INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
NombreRol VARCHAR(50) NOT NULL
)

--Otra tabla nueva
CREATE TABLE Usuarios(
idUsuario INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
Cedula VARCHAR(100) NOT NULL,
NombreUsuario VARCHAR(100) NOT NULL,
Correo VARCHAR(100) NOT NULL,
Contrasenna VARCHAR(100) NOT NULL,
Salario DECIMAL(10, 2),
ConsecutivoPuesto INT,
ConsecutivoRol INT NOT NULL,
Estado bit,
FOREIGN KEY (ConsecutivoPuesto) REFERENCES Puesto(ConsecutivoPuesto),
FOREIGN KEY (ConsecutivoRol) REFERENCES Roles(ConsecutivoRol)--nueva fk de roles
)




CREATE TABLE Plato (
    ConsecutivoPlato INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    RutaImagen VARCHAR(255)
);


--CREATE TABLE Cliente (
    --ConsecutivoCliente INT IDENTITY(1,1) PRIMARY KEY,
    --Identificacion VARCHAR(50) NOT NULL,
    --NombreCliente VARCHAR(100) NOT NULL,
    --CorreoCliente VARCHAR(100) NOT NULL,
    --Telefono VARCHAR(20),
    --Contrasena VARCHAR(100) NOT NULL
--);

CREATE TABLE Carrito (
    ConsecutivoCarrito INT IDENTITY(1,1) PRIMARY KEY,
    idUsuario INT, --cambio de clientes a usuarios
    ConsecutivoPlato INT,
    Cantidad INT NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),--cambio de clientes a usuarios
    FOREIGN KEY (ConsecutivoPlato) REFERENCES Plato(ConsecutivoPlato)
);

CREATE TABLE Tipo_Factura (
    ConsecutivoTipo INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Factura (
    ConsecutivoFactura INT IDENTITY(1,1) PRIMARY KEY,
    ConsecutivoTipo INT,

    --ConsecutivoCliente INT,
    --ConsecutivoEmpleado INT,

	idUsuario INT, --cambio de clientes a usuarios
    FechaCompra DATE,
    Subtotal DECIMAL(10, 2),
    Impuesto DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    FOREIGN KEY (ConsecutivoTipo) REFERENCES Tipo_Factura(ConsecutivoTipo),
	FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)--cambio de clientes a usuarios

    --FOREIGN KEY (ConsecutivoCliente) REFERENCES Cliente(ConsecutivoCliente),
    --FOREIGN KEY (ConsecutivoEmpleado) REFERENCES Empleado(ConsecutivoEmpleado)
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


--ESTE NO LO EJECUTEN
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


--inserts de roles
		INSERT INTO dbo.Roles (NombreRol)
		VALUES ('Administrados')
		INSERT INTO dbo.Roles (NombreRol)
		VALUES ('Empleado')
		INSERT INTO dbo.Roles (NombreRol)
		VALUES ('Usuario')

--NUEVO SP PARA REGISTRAR USUARIOS
CREATE PROCEDURE [dbo].RegistroUsuarios
	@Cedula varchar(100),
	@NombreUsuario varchar(100),
	@Correo			varchar(100),
	@Contrasenna varchar(100)
AS
BEGIN

	IF NOT EXISTS(SELECT 1 FROM dbo.Usuarios
			      WHERE Cedula = @Cedula
					OR	Correo = @Correo)
	BEGIN
		INSERT INTO dbo.Usuarios (Cedula,NombreUsuario,Correo,Contrasenna,ConsecutivoRol,Estado)
		VALUES (@Cedula,@NombreUsuario,@Correo,@Contrasenna,3,1)
	END

END
GO

CREATE PROCEDURE [dbo].[IniciarSesion]
	@Correo			varchar(80),
	@Contrasenna	varchar(255)
AS
BEGIN
	
	SELECT	U.idUsuario,
			Cedula,
			NombreUsuario,
			Correo,
			Estado,
			U.ConsecutivoRol,
			R.NombreRol
	  FROM	dbo.Usuarios U
	  INNER JOIN dbo.Roles R ON U.ConsecutivoRol = R.ConsecutivoRol
	  WHERE	Correo = @Correo
		AND Contrasenna = @Contrasenna
		AND Estado = 1

END
GO


SELECT * FROM Usuarios


//Procedimientos Almacenados de Empleado//






CREATE PROCEDURE [dbo].[MostrarEmpleados]
	
AS
BEGIN
    SELECT 
        Emp.ConsecutivoEmpleado,
        Emp.Identificacion,
        Emp.Contrasena,
        Emp.Nombre_Empleado,
        Emp.Correo_Empleado,
        Emp.Salario,
        Emp.ConsecutivoPuesto      
    FROM 
        dbo.Empleado Emp
    INNER JOIN 
        dbo.Puesto P ON Emp.ConsecutivoPuesto = P.ConsecutivoPuesto;
END



CREATE PROCEDURE [dbo].[ActualizarEmpleado]
    @ConsecutivoEmpleado INT,
    @Identificacion VARCHAR(50),
    @Nombre_Empleado VARCHAR(100),
    @Correo_Empleado VARCHAR(100),
    @ConsecutivoPuesto INT
AS
BEGIN
    -- Verificar si existe algún registro con la misma Identificacion o Correo
    -- y que no sea el registro que estamos actualizando
    IF NOT EXISTS (SELECT 1 
                   FROM dbo.Empleado
                   WHERE (Identificacion = @Identificacion OR Correo_Empleado = @Correo_Empleado)
                     AND ConsecutivoEmpleado != @ConsecutivoEmpleado)
    BEGIN
        -- Actualizar el registro
        UPDATE dbo.Empleado
        SET Identificacion = @Identificacion,
            Nombre_Empleado = @Nombre_Empleado,
            Correo_Empleado = @Correo_Empleado,
            ConsecutivoPuesto = CASE 
                                   WHEN @ConsecutivoPuesto != 0 THEN @ConsecutivoPuesto 
                                   ELSE ConsecutivoPuesto 
                                END
        WHERE ConsecutivoEmpleado = @ConsecutivoEmpleado;
    END
END

CREATE PROCEDURE EliminarEmpleado
    @ConsecutivoEmpleado INT
AS
BEGIN
    -- Iniciar transacción para asegurar la integridad de los datos
    BEGIN TRANSACTION;

    -- Verificar si el empleado existe
    IF EXISTS (SELECT 1 FROM Empleado WHERE ConsecutivoEmpleado = @ConsecutivoEmpleado)
    BEGIN
        -- Eliminar el empleado
        DELETE FROM Empleado WHERE ConsecutivoEmpleado = @ConsecutivoEmpleado;

        -- Confirmar la eliminación si todo está bien
        COMMIT TRANSACTION;
        PRINT 'Empleado eliminado correctamente.';
    END
    ELSE
    BEGIN
        -- Si no se encuentra el empleado, se hace rollback
        ROLLBACK TRANSACTION;
        PRINT 'Empleado no encontrado. No se pudo eliminar.';
    END
END;














