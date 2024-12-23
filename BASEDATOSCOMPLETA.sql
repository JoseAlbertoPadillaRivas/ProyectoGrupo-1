USE [master]
GO
/****** Object:  Database [PizzeriaJumbo]    Script Date: 19/12/2024 13:39:57 ******/
CREATE DATABASE [PizzeriaJumbo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PizzeriaJumbo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PizzeriaJumbo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PizzeriaJumbo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PizzeriaJumbo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PizzeriaJumbo] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PizzeriaJumbo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PizzeriaJumbo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET ARITHABORT OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PizzeriaJumbo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PizzeriaJumbo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PizzeriaJumbo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PizzeriaJumbo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PizzeriaJumbo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PizzeriaJumbo] SET  MULTI_USER 
GO
ALTER DATABASE [PizzeriaJumbo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PizzeriaJumbo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PizzeriaJumbo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PizzeriaJumbo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PizzeriaJumbo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PizzeriaJumbo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PizzeriaJumbo] SET QUERY_STORE = ON
GO
ALTER DATABASE [PizzeriaJumbo] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PizzeriaJumbo]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrito](
	[ConsecutivoCarrito] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[ConsecutivoPlato] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_Carrito] PRIMARY KEY CLUSTERED 
(
	[ConsecutivoCarrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalle]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle](
	[ConsecutivoDetalle] [int] IDENTITY(1,1) NOT NULL,
	[ConsecutivoFactura] [int] NOT NULL,
	[ConsecutivoPlato] [int] NOT NULL,
	[Precio] [decimal](18, 2) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Detalle] PRIMARY KEY CLUSTERED 
(
	[ConsecutivoDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Error]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Error](
	[Consecutivo] [bigint] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[Mensaje] [varchar](max) NOT NULL,
	[Origen] [varchar](50) NOT NULL,
	[FechaHora] [datetime] NOT NULL,
 CONSTRAINT [PK_tError] PRIMARY KEY CLUSTERED 
(
	[Consecutivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Factura]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[ConsecutivoFactura] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[ConsecutivoFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plato]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plato](
	[ConsecutivoPlato] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[RutaImagen] [varchar](255) NULL,
	[Descripcion] [varchar](200) NOT NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ConsecutivoPlato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ConsecutivoRol] [int] IDENTITY(1,1) NOT NULL,
	[NombreRol] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ConsecutivoRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Cedula] [varchar](100) NOT NULL,
	[NombreUsuario] [varchar](100) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[Contrasenna] [varchar](100) NOT NULL,
	[Salario] [decimal](10, 2) NULL,
	[ConsecutivoRol] [int] NOT NULL,
	[Estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD  CONSTRAINT [FK_Carrito_ConsecutivoPlato] FOREIGN KEY([ConsecutivoPlato])
REFERENCES [dbo].[Plato] ([ConsecutivoPlato])
GO
ALTER TABLE [dbo].[Carrito] CHECK CONSTRAINT [FK_Carrito_ConsecutivoPlato]
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD  CONSTRAINT [FK_Carrito_idUsuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[Carrito] CHECK CONSTRAINT [FK_Carrito_idUsuario]
GO
ALTER TABLE [dbo].[Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Factura] FOREIGN KEY([ConsecutivoFactura])
REFERENCES [dbo].[Factura] ([ConsecutivoFactura])
GO
ALTER TABLE [dbo].[Detalle] CHECK CONSTRAINT [FK_Detalle_Factura]
GO
ALTER TABLE [dbo].[Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Plato] FOREIGN KEY([ConsecutivoPlato])
REFERENCES [dbo].[Plato] ([ConsecutivoPlato])
GO
ALTER TABLE [dbo].[Detalle] CHECK CONSTRAINT [FK_Detalle_Plato]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_idUsuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura_idUsuario]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([ConsecutivoRol])
REFERENCES [dbo].[Roles] ([ConsecutivoRol])
GO
/****** Object:  StoredProcedure [dbo].[ActualizarEstado]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarEstado]
	@idUsuario	int
AS
BEGIN

	UPDATE dbo.Usuarios
    SET Estado =	CASE WHEN Estado = 1 
	   				     THEN 0
						 ELSE 1 END
	WHERE idUsuario	 = @idUsuario	
	
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarEstadoPlato]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[ActualizarEstadoPlato]
	@ConsecutivoPlato		bigint
AS
BEGIN

	UPDATE dbo.Plato
    SET Activo =	CASE WHEN Activo = 1 
	   				     THEN 0
						 ELSE 1 END
	WHERE ConsecutivoPlato = @ConsecutivoPlato
	
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarPerfil]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarPerfil]
    @idUsuario INT,
    @NombreUsuario VARCHAR(100),
    @Correo VARCHAR(100),
	@Cedula VARCHAR(100)
AS
BEGIN
    UPDATE Usuarios
    SET NombreUsuario = @NombreUsuario,
        Correo = @Correo,
        Cedula = @Cedula
    WHERE idUsuario = @idUsuario AND ConsecutivoRol = 3; 
END;
GO
/****** Object:  StoredProcedure [dbo].[ActualizarPlato]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarPlato]
	@ConsecutivoPlato	INT,
	@Nombre			varchar(50),
	@Precio			decimal(18,2),
	@Descripcion	varchar(500)
AS
BEGIN

	UPDATE dbo.Plato
	SET Nombre = @Nombre,
        Precio = @Precio,
		Descripcion = @Descripcion
		
	WHERE ConsecutivoPlato = @ConsecutivoPlato

END
GO
/****** Object:  StoredProcedure [dbo].[AgregarCarrito]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarCarrito]
@idUsuario			int,
@ConsecutivoPlato	int,
@Cantidad			int
AS
BEGIN

IF (SELECT COUNT(*) FROM Carrito
WHERE idUsuario = @idUsuario
AND ConsecutivoPlato = @ConsecutivoPlato) = 0
BEGIN

INSERT INTO [dbo].[Carrito]
		(idUsuario
		,ConsecutivoPlato
		,Cantidad)
	VALUES
		(@idUsuario
		,@ConsecutivoPlato
		,@Cantidad)
END
ELSE
BEGIN
UPDATE dbo.Carrito
SET Cantidad = @Cantidad
WHERE idUsuario = @idUsuario
AND ConsecutivoPlato = @ConsecutivoPlato

END
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCarrito]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarCarrito]
    @idUsuario INT
AS
BEGIN
    SELECT  
    C.ConsecutivoCarrito,
    C.ConsecutivoPlato,
    P.Nombre,
    C.Cantidad,
    P.Precio,
    C.Cantidad * P.Precio AS 'Total',
    P.RutaImagen + CONVERT(VARCHAR,P.ConsecutivoPlato) + '.png' 'RutaImagen'
FROM dbo.Carrito C
INNER JOIN dbo.Plato P ON C.ConsecutivoPlato = P.ConsecutivoPlato
WHERE C.idUsuario = @idUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarFacturas]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarFacturas]
	@idUsuario INT
AS
BEGIN
	
	SELECT	F.idUsuario,
			U.NombreUsuario,
			F.Total
	FROM	Factura F
	INNER JOIN Usuarios U ON F.idUsuario = U.idUsuario
	WHERE	U.idUsuario = @idUsuario
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarPlato]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarPlato]
	@ConsecutivoPlato INT
AS
BEGIN
	
	SELECT	ConsecutivoPlato,
			Nombre,
			Precio,
			Descripcion,
			RutaImagen + CONVERT(VARCHAR,ConsecutivoPlato) + '.png' 'RutaImagen',
			Activo
	  FROM	dbo.Plato
	  WHERE ConsecutivoPlato = @ConsecutivoPlato

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarRoles]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarRoles]
	
AS
BEGIN
	
	SELECT	ConsecutivoRol,NombreRol
	FROM	dbo.Roles
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarUsuario]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarUsuario]
	@idUsuario INT
AS
BEGIN
	
	SELECT	U.idUsuario,
			Cedula,
			NombreUsuario,
			Correo,
			Estado,
			U.ConsecutivoRol,
			R.NombreRol
	  FROM	Usuarios U
	  INNER JOIN dbo.Roles R ON U.ConsecutivoRol = R.ConsecutivoRol
	  WHERE U.idUsuario = @idUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarios]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarUsuarios]
	
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
	  WHERE U.ConsecutivoRol = 2

END
GO
/****** Object:  StoredProcedure [dbo].[CrearPlato]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearPlato]	
	@Nombre			varchar(100),
	@Precio			decimal,
	@Descripcion	varchar(255),
	@RutaImagen		varchar(255)
AS
BEGIN	
 
 
	INSERT INTO dbo.Plato(Nombre,Precio,Descripcion,RutaImagen,Activo)
	VALUES (@Nombre,@Precio,@Descripcion,@RutaImagen,1)
 
	SELECT @@IDENTITY ConsecutivoPlato
END
 
GO
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[MostrarMenu]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MostrarMenu]
    @ConsecutivoRol INT
AS
BEGIN
    IF @ConsecutivoRol = 1
    BEGIN        
        SELECT 
            ConsecutivoPlato,
            Nombre,
            Precio,
            Descripcion,
            RutaImagen + CONVERT(VARCHAR, ConsecutivoPlato) + '.png' AS RutaImagen,
            Activo
        FROM dbo.Plato;
    END
    ELSE 
    BEGIN       
        SELECT 
            ConsecutivoPlato,
            Nombre,
            Precio,
            Descripcion,
            RutaImagen + CONVERT(VARCHAR, ConsecutivoPlato) + '.png' AS RutaImagen,
            Activo
        FROM dbo.Plato
        WHERE Activo = 1;
    END    
END;

GO
/****** Object:  StoredProcedure [dbo].[PagarCarrito]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PagarCarrito]
	@idUsuario INT
AS
BEGIN
	
	INSERT INTO dbo.Factura (idUsuario,Total)
    SELECT	C.idUsuario, SUM(C.Cantidad * P.Precio)
	FROM	Carrito C
	INNER JOIN Plato P ON C.ConsecutivoPlato = P.ConsecutivoPlato
	WHERE C.idUsuario = @idUsuario
	GROUP BY C.idUsuario


	INSERT INTO dbo.Detalle (ConsecutivoFactura,ConsecutivoPlato,Precio,Cantidad,Total)
    SELECT 	@@IDENTITY, C.ConsecutivoPlato, P.Precio, C.Cantidad, (C.Cantidad * P.Precio)
	FROM	Carrito C
	INNER JOIN Plato P ON C.ConsecutivoPlato = P.ConsecutivoPlato
	WHERE C.idUsuario = @idUsuario


	DELETE FROM Carrito
	WHERE idUsuario = @idUsuario


END
GO
/****** Object:  StoredProcedure [dbo].[RegistrarError]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegistrarError]
	@Consecutivo	bigint,
	@Mensaje		varchar(max),
	@Origen			varchar(50)
AS
BEGIN

	INSERT INTO dbo.Error(idUsuario,Mensaje,Origen,FechaHora)
    VALUES (@Consecutivo,@Mensaje,@Origen,GETDATE())

END
GO
/****** Object:  StoredProcedure [dbo].[RegistroUsuarios]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegistroUsuarios]
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
		VALUES (@Cedula,@NombreUsuario,@Correo,@Contrasenna,2,1)
	END

END
GO
/****** Object:  StoredProcedure [dbo].[RemoverPlatoCarrito]    Script Date: 19/12/2024 13:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoverPlatoCarrito]
	@idUsuario INT,
	@ConsecutivoPlato INT
AS
BEGIN
	
	DELETE FROM Carrito
	WHERE	idUsuario = @idUsuario
		AND	ConsecutivoPlato = @ConsecutivoPlato

END
GO
USE [master]
GO
ALTER DATABASE [PizzeriaJumbo] SET  READ_WRITE 
GO
