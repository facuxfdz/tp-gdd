IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'sqlnt')) 
BEGIN
    EXEC ('CREATE SCHEMA [sqlnt] AUTHORIZATION [dbo]')
END

CREATE TABLE sqlnt.CATEGORIA
  (
     id      INTEGER,
     detalle NVARCHAR(255),
     PRIMARY KEY (id)
  )

CREATE TABLE sqlnt.PRODUCTO
  (
     id        INTEGER,
     detalle   NVARCHAR(255),
     categoria INTEGER,
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.PRODUCTO_VARIANTE
  (
     codigo          NVARCHAR(50),
     producto        INTEGER,
     variante        INTEGER,
     precio_unitario DECIMAL(18, 2),
     PRIMARY KEY(codigo)
  )

CREATE TABLE sqlnt.VARIANTE
  (
     id            INTEGER,
     tipo_variante INTEGER,
     detalle       NVARCHAR(255),
     PRIMARY KEY(id),
  )

CREATE TABLE sqlnt.TIPO_VARIANTE
  (
     id      INTEGER,
     detalle NVARCHAR(50),
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.PRODUCTO_VARIANTE_VENTA
  (
     venta             DECIMAL(19, 0),
     producto_variante NVARCHAR(50),
     cantidad          DECIMAL(18, 0),
     precio            DECIMAL(18, 2),
     PRIMARY KEY(venta, producto_variante)
  )

CREATE TABLE sqlnt.CANAL_VENTA
  (
     id             INTEGER,
     descripcion    VARCHAR(255),
     costo_asociado DECIMAL(18, 2),
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.ENVIO
  (
     id              INTEGER,
     medio_envio     INTEGER,
     domicilio_envio NVARCHAR(255),
     codigo_postal   DECIMAL(18, 0),
     costo           DECIMAL(18, 2),
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.PRODUCTO_VARIANTE_COMPRA
  (
     compra            DECIMAL(19, 0),
     producto_variante NVARCHAR(50),
     cantidad_producto DECIMAL(18, 0),
     precio_unitario   DECIMAL(18, 2),
     PRIMARY KEY(compra, producto_variante)
  )

CREATE TABLE sqlnt.CUPON
  (
     codigo      NVARCHAR(255),
     tipo_cupon  INTEGER,
     valor       DECIMAL(18, 2),
     fecha_desde DATE,
     fecha_hasta DATE,
     PRIMARY KEY(codigo)
  )

CREATE TABLE sqlnt.TIPO_CUPON
  (
     id          INTEGER,
     descripcion NVARCHAR(50),
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.CUPON_VENTA
  (
     cupon NVARCHAR(255),
     venta DECIMAL(19, 0),
     PRIMARY KEY(cupon)
  )

CREATE TABLE sqlnt.VENTA
  (
     nro_venta        DECIMAL(19, 0),
     fecha_venta      DATE,
     total            DECIMAL(18, 2),
     total_descuentos DECIMAL(18, 2),
     envio            INTEGER,
     cliente          DECIMAL(18, 0),
     canal_venta      INTEGER,
     medio_pago       INTEGER,
     PRIMARY KEY(nro_venta)
  )

CREATE TABLE sqlnt.MEDIO_PAGO_VENTA
  (
     id          INTEGER,
     descripcion VARCHAR(255),
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.DESCUENTO_MEDIO_PAGO_VENTA
  (
     medio_pago        INTEGER,
     importe_descuento DECIMAL(18, 2),
     PRIMARY KEY(medio_pago)
  )

CREATE TABLE sqlnt.DESCUENTO_VENTA
  (
     tipo_descuento    INTEGER,
     venta             DECIMAL(19, 0),
     importe_descuento DECIMAL(18, 2),
     PRIMARY KEY(tipo_descuento, venta)
  )

CREATE TABLE sqlnt.TIPO_DESCUENTO_VENTA
  (
     id       INTEGER,
     concepto NVARCHAR(255),
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.PROVEEDOR
  (
     prove_cuit          NVARCHAR(50),
     prove_razon_social  NVARCHAR(50),
     prove_domicilio     NVARCHAR(50),
     prove_localidad     NVARCHAR(255),
     prove_mail          NVARCHAR(50),
     prove_codigo_postal DECIMAL(18, 0),
     PRIMARY KEY(prove_cuit)
  )

CREATE TABLE sqlnt.MEDIO_PAGO_COMPRA
  (
     id          INTEGER,
     descripcion VARCHAR(255),
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.COMPRA
  (
     nro_compra   DECIMAL(19, 0),
     fecha_compra DATE,
     proveedor    NVARCHAR(50),
     compra_total DECIMAL(18, 2),
     medio_pago   INTEGER,
     PRIMARY KEY(nro_compra)
  )

CREATE TABLE sqlnt.DESCUENTO_COMPRA
  (
     tipo_descuento INTEGER,
     compra             DECIMAL(19, 0),
     importe_valor      DECIMAL(18, 2),
     PRIMARY KEY(tipo_descuento,compra)
  )

CREATE TABLE sqlnt.TIPO_DESCUENTO_COMPRA
  (
     id       INTEGER,
     concepto NVARCHAR(255),
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.CLIENTE
  (
     nombre        NVARCHAR(255),
     apellido      NVARCHAR(255),
     nro_documento DECIMAL(18, 0),
     fecha_nac     DATE,
     mail          NVARCHAR(255),
     localidad     NVARCHAR(255),
     codigo_postal DECIMAL(18, 0),
     direccion     NVARCHAR(255),
     telefono      DECIMAL(18, 0),
     PRIMARY KEY(nro_documento)
  )

CREATE TABLE sqlnt.CODIGO_POSTAL
  (
     codigo_postal DECIMAL(18, 0),
     provincia     INTEGER,
     PRIMARY KEY(codigo_postal)
  )

CREATE TABLE sqlnt.DISPONIBILIDAD_ENVIO
  (
     codigo_postal          DECIMAL(18, 0),
     medio_envio_disponible INTEGER,
     precio 				DECIMAL(18,2),
     PRIMARY KEY(codigo_postal,medio_envio_disponible)
  )

CREATE TABLE sqlnt.MEDIO_ENVIO
  (
     id          INTEGER,
     descripcion NVARCHAR(255),
     PRIMARY KEY(id)
  )

CREATE TABLE sqlnt.PROVINCIA
  (
     id          INTEGER,
     descripcion NVARCHAR(255),
     PRIMARY KEY(id)
  ) 
  
ALTER TABLE sqlnt.PRODUCTO
ADD FOREIGN KEY (categoria) REFERENCES sqlnt.CATEGORIA(id)

ALTER TABLE sqlnt.PRODUCTO_VARIANTE 
ADD FOREIGN KEY (producto) REFERENCES sqlnt.PRODUCTO(id)

ALTER TABLE sqlnt.PRODUCTO_VARIANTE 
ADD FOREIGN KEY (variante) REFERENCES sqlnt.VARIANTE(id)

ALTER TABLE sqlnt.VARIANTE
ADD FOREIGN KEY (tipo_variante) REFERENCES sqlnt.TIPO_VARIANTE(id)

ALTER TABLE sqlnt.PRODUCTO_VARIANTE_COMPRA
ADD FOREIGN KEY (compra) REFERENCES sqlnt.COMPRA(nro_compra)

ALTER TABLE sqlnt.PRODUCTO_VARIANTE_COMPRA
ADD FOREIGN KEY (producto_variante) REFERENCES sqlnt.PRODUCTO_VARIANTE(codigo)

ALTER TABLE sqlnt.PRODUCTO_VARIANTE_VENTA
ADD FOREIGN KEY (venta) REFERENCES sqlnt.VENTA(nro_venta)

ALTER TABLE sqlnt.PRODUCTO_VARIANTE_VENTA
ADD FOREIGN KEY (producto_variante) REFERENCES sqlnt.PRODUCTO_VARIANTE(codigo)

ALTER TABLE sqlnt.VENTA 
ADD FOREIGN KEY (envio) REFERENCES sqlnt.ENVIO(id)

ALTER TABLE sqlnt.VENTA 
ADD FOREIGN KEY (cliente) REFERENCES sqlnt.CLIENTE(nro_documento)

ALTER TABLE sqlnt.VENTA 
ADD FOREIGN KEY (canal_venta) REFERENCES sqlnt.CANAL_VENTA(id)

ALTER TABLE sqlnt.VENTA 
ADD FOREIGN KEY (medio_pago) REFERENCES sqlnt.MEDIO_PAGO_VENTA(id)

ALTER TABLE sqlnt.DESCUENTO_VENTA  
ADD FOREIGN KEY (tipo_descuento) REFERENCES sqlnt.TIPO_DESCUENTO_VENTA(id)

ALTER TABLE sqlnt.DESCUENTO_VENTA  
ADD FOREIGN KEY (venta) REFERENCES sqlnt.VENTA(nro_venta)

ALTER TABLE sqlnt.DESCUENTO_COMPRA  
ADD FOREIGN KEY (tipo_descuento) REFERENCES sqlnt.TIPO_DESCUENTO_COMPRA(id)

ALTER TABLE sqlnt.DESCUENTO_COMPRA  
ADD FOREIGN KEY (compra) REFERENCES sqlnt.COMPRA(nro_compra)

ALTER TABLE sqlnt.COMPRA  
ADD FOREIGN KEY (proveedor) REFERENCES sqlnt.PROVEEDOR(prove_cuit)

ALTER TABLE sqlnt.COMPRA  
ADD FOREIGN KEY (medio_pago) REFERENCES sqlnt.MEDIO_PAGO_COMPRA(id)

ALTER TABLE sqlnt.PROVEEDOR  
ADD FOREIGN KEY (prove_codigo_postal) REFERENCES sqlnt.CODIGO_POSTAL(codigo_postal)

ALTER TABLE sqlnt.CUPON  
ADD FOREIGN KEY (tipo_cupon) REFERENCES sqlnt.TIPO_CUPON(id)

ALTER TABLE sqlnt.CUPON_VENTA 
ADD FOREIGN KEY (cupon) REFERENCES sqlnt.CUPON(codigo)

ALTER TABLE sqlnt.CUPON_VENTA 
ADD FOREIGN KEY (venta) REFERENCES sqlnt.VENTA(nro_venta)

ALTER TABLE sqlnt.CLIENTE
ADD FOREIGN KEY (codigo_postal) REFERENCES sqlnt.CODIGO_POSTAL(codigo_postal)

ALTER TABLE sqlnt.ENVIO 
ADD FOREIGN KEY (medio_envio) REFERENCES sqlnt.MEDIO_ENVIO(id)

ALTER TABLE sqlnt.ENVIO 
ADD FOREIGN KEY (codigo_postal) REFERENCES sqlnt.CODIGO_POSTAL(codigo_postal)

ALTER TABLE sqlnt.CODIGO_POSTAL  
ADD FOREIGN KEY (provincia) REFERENCES sqlnt.PROVINCIA(id)

ALTER TABLE sqlnt.DISPONIBILIDAD_ENVIO
ADD FOREIGN KEY (medio_envio_disponible) REFERENCES sqlnt.MEDIO_ENVIO(id)

ALTER TABLE sqlnt.DISPONIBILIDAD_ENVIO 
ADD FOREIGN KEY (codigo_postal) REFERENCES sqlnt.CODIGO_POSTAL(codigo_postal)

ALTER TABLE sqlnt.DESCUENTO_MEDIO_PAGO_VENTA
ADD FOREIGN KEY (medio_pago) REFERENCES sqlnt.MEDIO_PAGO_VENTA(id)

/*---------------------SEQUENCE---------------------*/

CREATE SEQUENCE sqlnt.contador_categorias
    AS INT
    START WITH 1
    INCREMENT BY 1;
GO

CREATE SEQUENCE sqlnt.contador_productos
    AS INT
    START WITH 1
    INCREMENT BY 1;
GO

/*-- inicio ema ---*/
CREATE SEQUENCE sqlnt.contador_tipo_variante
    AS INT
    START WITH 1
    INCREMENT BY 1;
GO

CREATE SEQUENCE sqlnt.contador_tipo_descuento_venta
    AS INT
    START WITH 1
    INCREMENT BY 1;
GO

CREATE SEQUENCE sqlnt.contador_medio_pago_venta
    AS INT
    START WITH 1
    INCREMENT BY 1;
GO

CREATE SEQUENCE sqlnt.contador_medio_envio
    AS INT
    START WITH 1
    INCREMENT BY 1;
GO

CREATE SEQUENCE sqlnt.contador_tipo_cupon
    AS INT
    START WITH 1
    INCREMENT BY 1;
GO

/*-- fin ema ---*/

/*---------------------INSERTS---------------------*/

CREATE PROCEDURE sqlnt.insertar_categorias
AS
INSERT INTO sqlnt.CATEGORIA(id, detalle)
SELECT NEXT VALUE FOR sqlnt.contador_categorias, PRODUCTO_CATEGORIA
FROM GD2C2022.gd_esquema.Maestra
WHERE PRODUCTO_CATEGORIA IS NOT NULL
GROUP BY PRODUCTO_CATEGORIA;
GO

CREATE PROCEDURE sqlnt.insertar_productos
AS
INSERT INTO sqlnt.PRODUCTO(id, detalle, categoria)
SELECT NEXT VALUE FOR sqlnt.contador_productos,
       PRODUCTO_MARCA,
       (SELECT id FROM sqlnt.CATEGORIA c WHERE c.detalle = PRODUCTO_CATEGORIA)
FROM GD2C2022.gd_esquema.Maestra
WHERE PRODUCTO_MARCA IS NOT NULL
  AND PRODUCTO_CATEGORIA IS NOT NULL
GROUP BY PRODUCTO_MARCA, PRODUCTO_CATEGORIA;
GO

/*-------------------inicio ema-----------------*/

CREATE PROCEDURE sqlnt.insertar_tipo_variante
AS
INSERT INTO sqlnt.TIPO_VARIANTE(id, detalle)
SELECT NEXT VALUE FOR sqlnt.contador_tipo_variante, PRODUCTO_TIPO_VARIANTE
FROM GD2C2022.gd_esquema.Maestra
WHERE PRODUCTO_TIPO_VARIANTE IS NOT NULL
GROUP BY PRODUCTO_TIPO_VARIANTE;
GO

CREATE PROCEDURE sqlnt.insertar_tipo_descuento_venta
AS
INSERT INTO sqlnt.TIPO_DESCUENTO_VENTA(id, concepto)
SELECT NEXT VALUE FOR sqlnt.contador_tipo_descuento_venta, VENTA_DESCUENTO_CONCEPTO
FROM GD2C2022.gd_esquema.Maestra
WHERE VENTA_DESCUENTO_CONCEPTO IS NOT NULL
GROUP BY VENTA_DESCUENTO_CONCEPTO;
GO

CREATE PROCEDURE sqlnt.insertar_medio_envio
AS
INSERT INTO sqlnt.MEDIO_ENVIO(id, descripcion)
SELECT NEXT VALUE FOR sqlnt.contador_medio_envio, VENTA_MEDIO_ENVIO
FROM GD2C2022.gd_esquema.Maestra
WHERE VENTA_MEDIO_ENVIO IS NOT NULL
GROUP BY VENTA_MEDIO_ENVIO;
GO

CREATE PROCEDURE sqlnt.insertar_medio_pago_venta
AS
INSERT INTO sqlnt.MEDIO_PAGO_VENTA (id, descripcion)
SELECT NEXT VALUE FOR sqlnt.contador_medio_pago_venta, VENTA_MEDIO_PAGO
FROM GD2C2022.gd_esquema.Maestra
WHERE VENTA_MEDIO_PAGO IS NOT NULL
GROUP BY VENTA_MEDIO_PAGO;
GO

CREATE PROCEDURE sqlnt.insertar_tipo_cupon
AS
INSERT INTO sqlnt.TIPO_CUPON (id, descripcion)
SELECT NEXT VALUE FOR sqlnt.contador_tipo_cupon, VENTA_CUPON_TIPO
FROM GD2C2022.gd_esquema.Maestra
WHERE VENTA_CUPON_TIPO IS NOT NULL
GROUP BY VENTA_CUPON_TIPO;
GO
/*-------------------fin ema-----------------*/

/*-------------------inicio ema-----------------*/
CREATE PROCEDURE sqlnt.Migracion
AS
    EXECUTE sqlnt.insertar_categorias;
    EXECUTE sqlnt.insertar_productos;
    EXECUTE sqlnt.insertar_tipo_variante;
    EXECUTE sqlnt.insertar_tipo_descuento_venta;
    EXECUTE sqlnt.insertar_medio_envio;
    EXECUTE sqlnt.insertar_medio_pago_venta;
    EXECUTE sqlnt.insertar_medio_pago_venta;
    EXECUTE sqlnt.insertar_tipo_cupon;
GO

EXECUTE sqlnt.Migracion;

/*-------------------fin ema-----------------*/