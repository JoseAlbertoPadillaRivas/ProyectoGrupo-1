USE [master]
GO
/****** Object:  Database [PizzeriaJumbo]    Script Date: 21/11/2024 12:19:10 ******/
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
/****** Object:  Table [dbo].[Carrito]    Script Date: 21/11/2024 12:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrito](
	[ConsecutivoCarrito] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NULL,
	[ConsecutivoPlato] [int] NULL,
	[Cantidad] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ConsecutivoCarrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleFactura]    Script Date: 21/11/2024 12:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleFactura](
	[ConsecutivoDetalleFactura] [int] IDENTITY(1,1) NOT NULL,
	[ConsecutivoFactura] [int] NULL,
	[ConsecutivoPlato] [int] NULL,
	[Cantidad] [int] NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Subtotal] [decimal](10, 2) NULL,
	[Impuesto] [decimal](10, 2) NULL,
	[Total] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ConsecutivoDetalleFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Factura]    Script Date: 21/11/2024 12:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[ConsecutivoFactura] [int] IDENTITY(1,1) NOT NULL,
	[ConsecutivoTipo] [int] NULL,
	[idUsuario] [int] NULL,
	[FechaCompra] [date] NULL,
	[Subtotal] [decimal](10, 2) NULL,
	[Impuesto] [decimal](10, 2) NULL,
	[Total] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ConsecutivoFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plato]    Script Date: 21/11/2024 12:19:10 ******/
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
PRIMARY KEY CLUSTERED 
(
	[ConsecutivoPlato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Puesto]    Script Date: 21/11/2024 12:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puesto](
	[ConsecutivoPuesto] [int] IDENTITY(1,1) NOT NULL,
	[NombrePuesto] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ConsecutivoPuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 21/11/2024 12:19:10 ******/
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
/****** Object:  Table [dbo].[Tipo_Factura]    Script Date: 21/11/2024 12:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Factura](
	[ConsecutivoTipo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Tipo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ConsecutivoTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 21/11/2024 12:19:10 ******/
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
	[ConsecutivoPuesto] [int] NULL,
	[ConsecutivoRol] [int] NOT NULL,
	[Estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD FOREIGN KEY([ConsecutivoPlato])
REFERENCES [dbo].[Plato] ([ConsecutivoPlato])
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD FOREIGN KEY([ConsecutivoFactura])
REFERENCES [dbo].[Factura] ([ConsecutivoFactura])
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD FOREIGN KEY([ConsecutivoPlato])
REFERENCES [dbo].[Plato] ([ConsecutivoPlato])
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD FOREIGN KEY([ConsecutivoTipo])
REFERENCES [dbo].[Tipo_Factura] ([ConsecutivoTipo])
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([ConsecutivoPuesto])
REFERENCES [dbo].[Puesto] ([ConsecutivoPuesto])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([ConsecutivoRol])
REFERENCES [dbo].[Roles] ([ConsecutivoRol])
GO
/****** Object:  StoredProcedure [dbo].[ActualizarPerfil]    Script Date: 21/11/2024 12:19:10 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarRoles]    Script Date: 21/11/2024 12:19:10 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarUsuario]    Script Date: 21/11/2024 12:19:10 ******/
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
/****** Object:  StoredProcedure [dbo].[ConsultarUsuarios]    Script Date: 21/11/2024 12:19:10 ******/
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
	  WHERE U.ConsecutivoRol = 3

END
GO
/****** Object:  StoredProcedure [dbo].[CrearPlato]    Script Date: 21/11/2024 12:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearPlato]	
	@Nombre			varchar(100),
	@Precio			varchar(80),
	@Descripcion			varchar(200),
	@RutaImagen		varchar(255)
AS
BEGIN	


	INSERT INTO dbo.Plato(Nombre,Precio,Descripcion,RutaImagen)
	VALUES (@Nombre,@Precio,@Descripcion,@RutaImagen)
END
GO
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 21/11/2024 12:19:10 ******/
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
/****** Object:  StoredProcedure [dbo].[MostrarEmpleados]    Script Date: 21/11/2024 12:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MostrarEmpleados]
AS
BEGIN
    SELECT 
        u.idUsuario, 
        u.Cedula, 
        u.NombreUsuario, 
        u.Correo, 
        u.Salario, 
        p.NombrePuesto, 
        r.NombreRol, 
        u.Estado
    FROM Usuarios u
    LEFT JOIN Puesto p ON u.ConsecutivoPuesto = p.ConsecutivoPuesto
    INNER JOIN Roles r ON u.ConsecutivoRol = r.ConsecutivoRol
    WHERE u.ConsecutivoRol IN (1, 2);
END;
GO
/****** Object:  StoredProcedure [dbo].[MostrarMenu]    Script Date: 21/11/2024 12:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MostrarMenu]	
AS
BEGIN

	SELECT ConsecutivoPlato,Nombre,Precio,Descripcion,RutaImagen
	  FROM dbo.Plato

END
GO
/****** Object:  StoredProcedure [dbo].[RegistroUsuarios]    Script Date: 21/11/2024 12:19:10 ******/
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
		VALUES (@Cedula,@NombreUsuario,@Correo,@Contrasenna,3,1)
	END

END
GO
USE [master]
GO
ALTER DATABASE [PizzeriaJumbo] SET  READ_WRITE 
GO
