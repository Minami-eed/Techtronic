USE DB_TECTRONIC
GO

-- Obtener Categoría
CREATE OR ALTER PROC sp_obtenerCategoria
AS
BEGIN
    SELECT * FROM CATEGORIA
END
GO

-- Registrar Categoría
CREATE OR ALTER PROC sp_RegistrarCategoria(
    @Descripcion VARCHAR(50),
    @Resultado BIT OUTPUT
)
AS
BEGIN
    SET @Resultado = 1

    IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
        INSERT INTO CATEGORIA (Descripcion) VALUES (@Descripcion)
    ELSE
        SET @Resultado = 0
END
GO

-- Modificar Categoría
CREATE OR ALTER PROC sp_ModificarCategoria(
    @IdCategoria INT,
    @Descripcion VARCHAR(60),
    @Activo BIT,
    @Resultado BIT OUTPUT
)
AS
BEGIN
    SET @Resultado = 1

    IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion AND IdCategoria != @IdCategoria)
        UPDATE CATEGORIA SET 
            Descripcion = @Descripcion,
            Activo = @Activo
        WHERE IdCategoria = @IdCategoria
    ELSE
        SET @Resultado = 0
END
GO

-- Obtener Marca
CREATE OR ALTER PROC sp_obtenerMarca
AS
BEGIN
    SELECT * FROM MARCA
END
GO

-- Registrar Marca
CREATE OR ALTER PROC sp_RegistrarMarca(
    @Descripcion VARCHAR(50),
    @Resultado BIT OUTPUT
)
AS
BEGIN
    SET @Resultado = 1

    IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion)
        INSERT INTO MARCA (Descripcion) VALUES (@Descripcion)
    ELSE
        SET @Resultado = 0
END
GO

-- Modificar Marca
CREATE OR ALTER PROC sp_ModificarMarca(
    @IdMarca INT,
    @Descripcion VARCHAR(60),
    @Activo BIT,
    @Resultado BIT OUTPUT
)
AS
BEGIN
    SET @Resultado = 1

    IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion AND IdMarca != @IdMarca)
        UPDATE MARCA SET 
            Descripcion = @Descripcion,
            Activo = @Activo
        WHERE IdMarca = @IdMarca
    ELSE
        SET @Resultado = 0
END
GO

-- Obtener Producto
CREATE OR ALTER PROC sp_obtenerProducto
AS
BEGIN
    SELECT p.*, m.Descripcion[DescripcionMarca],c.Descripcion[DescripcionCategoria]
    FROM PRODUCTO p
    INNER JOIN MARCA m ON m.IdMarca = p.IdMarca
    INNER JOIN CATEGORIA c ON c.IdCategoria = p.IdCategoria
END
GO

-- Registrar Producto
CREATE OR ALTER PROC sp_registrarProducto(
    @Nombre VARCHAR(500),
    @Descripcion VARCHAR(500),
    @IdMarca INT,
    @IdCategoria INT,
    @Precio DECIMAL(10,2),
    @Stock INT,
    @RutaImagen VARCHAR(500),
    @Resultado INT OUTPUT
)
AS
BEGIN
    SET @Resultado = 0

    IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Descripcion = @Descripcion)
    BEGIN
        INSERT INTO PRODUCTO (Nombre, Descripcion, IdMarca, IdCategoria, Precio, Stock, RutaImagen)
        VALUES (@Nombre, @Descripcion, @IdMarca, @IdCategoria, @Precio, @Stock, @RutaImagen)

        SET @Resultado = SCOPE_IDENTITY()
    END
END
GO

-- Editar Producto
CREATE OR ALTER PROC sp_editarProducto(
    @IdProducto INT,
    @Nombre VARCHAR(500),
    @Descripcion VARCHAR(500),
    @IdMarca INT,
    @IdCategoria INT,
    @Precio DECIMAL(10,2),
    @Stock INT,
    @Activo BIT,
    @Resultado BIT OUTPUT
)
AS
BEGIN
    SET @Resultado = 0

    IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Descripcion = @Descripcion AND IdProducto != @IdProducto)
    BEGIN
        UPDATE PRODUCTO SET 
            Nombre = @Nombre,
            Descripcion = @Descripcion,
            IdMarca = @IdMarca,
            IdCategoria = @IdCategoria,
            Precio = @Precio,
            Stock = @Stock,
            Activo = @Activo
        WHERE IdProducto = @IdProducto

        SET @Resultado = 1
    END
END
GO

-- Actualizar Ruta de Imagen
CREATE OR ALTER PROC sp_actualizarRutaImagen(
    @IdProducto INT,
    @RutaImagen VARCHAR(500)
)
AS
BEGIN
    UPDATE PRODUCTO SET RutaImagen = @RutaImagen WHERE IdProducto = @IdProducto
END
GO

-- Obtener Usuario
CREATE OR ALTER PROC sp_obtenerUsuario(
    @Correo VARCHAR(100),
    @Contrasena VARCHAR(100)
)
AS
BEGIN
    IF EXISTS (SELECT * FROM usuario WHERE correo = @Correo AND contrasena = @Contrasena)
    BEGIN
        SELECT IdUsuario, Nombres, Apellidos, Correo, Contrasena, EsAdministrador
        FROM usuario
        WHERE correo = @Correo AND contrasena = @Contrasena
    END
END
GO

-- Registrar Usuario
CREATE OR ALTER PROC sp_registrarUsuario(
    @Nombres VARCHAR(100),
    @Apellidos VARCHAR(100),
    @Correo VARCHAR(100),
    @Contrasena VARCHAR(100),
    @EsAdministrador BIT,
    @Resultado INT OUTPUT
)
AS
BEGIN
    SET @Resultado = 0

    IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo)
    BEGIN
        INSERT INTO USUARIO (Nombres, Apellidos, Correo, Contrasena, EsAdministrador)
        VALUES (@Nombres, @Apellidos, @Correo, @Contrasena, @EsAdministrador)

        SET @Resultado = SCOPE_IDENTITY()
    END
END
GO

-- Insertar en Carrito
CREATE OR ALTER PROC sp_InsertarCarrito(
    @IdUsuario INT,
    @IdProducto INT,
    @Resultado INT OUTPUT
)
AS
BEGIN
    SET @Resultado = 0

    IF NOT EXISTS (SELECT * FROM CARRITO WHERE IdProducto = @IdProducto AND IdUsuario = @IdUsuario)
    BEGIN
        UPDATE PRODUCTO SET Stock = Stock - 1 WHERE IdProducto = @IdProducto
        INSERT INTO CARRITO (IdUsuario, IdProducto) VALUES (@IdUsuario, @IdProducto)
        SET @Resultado = 1
    END
END
GO

-- Obtener Carrito
CREATE OR ALTER PROC sp_ObtenerCarrito(
    @IdUsuario INT
)
AS
BEGIN
    SELECT c.IdCarrito, p.IdProducto,m.Descripcion,p.Nombre,p.Precio,p.RutaImagen
    FROM CARRITO c
    INNER JOIN PRODUCTO p ON p.IdProducto = c.IdProducto
    INNER JOIN MARCA m ON m.IdMarca = p.IdMarca
    WHERE c.IdUsuario = @IdUsuario
END
GO

-- Registrar Compra
CREATE OR ALTER PROC sp_registrarCompra(
    @IdUsuario INT,
    @TotalProducto INT,
    @Total DECIMAL(10,2),
    @Contacto VARCHAR(100),
    @Telefono VARCHAR(100),
    @Direccion VARCHAR(100),
    @IdDistrito VARCHAR(10),
    @QueryDetalleCompra NVARCHAR(MAX),
    @Resultado BIT OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SET @Resultado = 0
        BEGIN TRANSACTION
        
        DECLARE @idcompra INT = 0
        INSERT INTO COMPRA (IdUsuario, TotalProducto, Total, Contacto, Telefono, Direccion, IdDistrito)
        VALUES (@IdUsuario, @TotalProducto, @Total, @Contacto, @Telefono, @Direccion, @IdDistrito)

        SET @idcompra = SCOPE_IDENTITY()

        SET @QueryDetalleCompra = REPLACE(@QueryDetalleCompra, '¡idcompra!', @idcompra)

        EXECUTE sp_executesql @QueryDetalleCompra

        DELETE FROM CARRITO WHERE IdUsuario = @IdUsuario

        SET @Resultado = 1

        COMMIT
    END TRY
    BEGIN CATCH
        ROLLBACK
        SET @Resultado = 0
    END CATCH
END
GO

-- Obtener Compra
CREATE OR ALTER PROC sp_ObtenerCompra(
    @IdUsuario INT
)
AS
BEGIN
    SELECT
        c.Total,
        CONVERT(CHAR(10), c.FechaCompra, 103)[Fecha],
        (
            SELECT
                m.Descripcion,
                p.Nombre,
                p.RutaImagen,
                dc.Total,
                dc.Cantidad
            FROM DETALLE_COMPRA dc
            INNER JOIN PRODUCTO p ON p.IdProducto = dc.IdProducto
            INNER JOIN MARCA m ON m.IdMarca = p.IdMarca
            WHERE dc.IdCompra = c.IdCompra
            FOR XML PATH ('PRODUCTO'), TYPE
        ) AS 'DETALLE_PRODUCTO'
    FROM compra c
    WHERE c.IdUsuario = @IdUsuario
    FOR XML PATH('COMPRA'), ROOT('DATA') 
END
GO
