USE [PizzeriaJumbo]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 19/11/2024 15:00:26 ******/
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
/****** Object:  Table [dbo].[DetalleFactura]    Script Date: 19/11/2024 15:00:26 ******/
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
/****** Object:  Table [dbo].[Factura]    Script Date: 19/11/2024 15:00:26 ******/
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
/****** Object:  Table [dbo].[Plato]    Script Date: 19/11/2024 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plato](
	[ConsecutivoPlato] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[RutaImagen] [varchar](255) NULL,
 CONSTRAINT [PK__Plato__6BDB59562EC7EFA7] PRIMARY KEY CLUSTERED 
(
	[ConsecutivoPlato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Puesto]    Script Date: 19/11/2024 15:00:26 ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 19/11/2024 15:00:26 ******/
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
/****** Object:  Table [dbo].[Tipo_Factura]    Script Date: 19/11/2024 15:00:26 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 19/11/2024 15:00:26 ******/
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
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD  CONSTRAINT [FK__Carrito__Consecu__4222D4EF] FOREIGN KEY([ConsecutivoPlato])
REFERENCES [dbo].[Plato] ([ConsecutivoPlato])
GO
ALTER TABLE [dbo].[Carrito] CHECK CONSTRAINT [FK__Carrito__Consecu__4222D4EF]
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD FOREIGN KEY([ConsecutivoFactura])
REFERENCES [dbo].[Factura] ([ConsecutivoFactura])
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK__DetalleFa__Conse__4BAC3F29] FOREIGN KEY([ConsecutivoPlato])
REFERENCES [dbo].[Plato] ([ConsecutivoPlato])
GO
ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK__DetalleFa__Conse__4BAC3F29]
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
/****** Object:  StoredProcedure [dbo].[CrearPlato]    Script Date: 19/11/2024 15:00:27 ******/
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


	INSERT INTO dbo.Plato(Nombre,Precio,Descripcion,RutaImagen)
	VALUES (@Nombre,@Precio,@Descripcion,@RutaImagen)
END
GO
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 19/11/2024 15:00:27 ******/
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
/****** Object:  StoredProcedure [dbo].[MostrarMenu]    Script Date: 19/11/2024 15:00:27 ******/
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
/****** Object:  StoredProcedure [dbo].[RegistroUsuarios]    Script Date: 19/11/2024 15:00:27 ******/
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

CREATE PROCEDURE [dbo].[ConsultarRoles]
	
AS
BEGIN
	
	SELECT	ConsecutivoRol,NombreRol
	FROM	dbo.Roles
END
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

CREATE PROCEDURE ActualizarPerfil
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


CREATE PROCEDURE MostrarEmpleados
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
    INNER JOIN Puesto p ON u.ConsecutivoPuesto = p.ConsecutivoPuesto
    INNER JOIN Roles r ON u.ConsecutivoRol = r.ConsecutivoRol
    WHERE u.ConsecutivoRol = 1 or u.ConsecutivoRol = 2; 
END;



SELECT * FROM Usuarios






