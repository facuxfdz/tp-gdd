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
     codigo        nvarchar(50),
     nombre		   nvarchar(50),
     descripcion   nvarchar(50),
     material      integer,
     marca         integer,
     categoria INTEGER,
     PRIMARY KEY(codigo)
  )
  
CREATE TABLE sqlnt.MARCA
(
	id			integer,
	detalle		nvarchar(255),
	PRIMARY KEY(id)
)

CREATE TABLE sqlnt.MATERIAL
(
	id			integer,
	detalle		nvarchar(255),
	PRIMARY KEY(id)
)


CREATE TABLE sqlnt.PRODUCTO_VARIANTE
  (
     codigo          NVARCHAR(50),
     producto        nvarchar(50),
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
     detalle NVARCHAR(255),
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
     venta			 DECIMAL(19,0),
     medio_envio     INTEGER,
     domicilio_envio NVARCHAR(255),
     codigo_postal   DECIMAL(18, 0),
     costo           DECIMAL(18, 2),
     PRIMARY KEY(venta)
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
     cupon NVARCHAR(255) NOT NULL,
     venta DECIMAL(19, 0) NOT NULL,
     PRIMARY KEY(cupon,venta)
  )

CREATE TABLE sqlnt.VENTA
  (
     nro_venta        DECIMAL(19, 0),
     fecha_venta      DATE,
     total            DECIMAL(18, 2),
     total_descuentos DECIMAL(18, 2),
     cliente          INTEGER,
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
  	 id 		   INTEGER,
     nombre        NVARCHAR(255),
     apellido      NVARCHAR(255),
     nro_documento DECIMAL(18, 0),
     fecha_nac     DATE,
     mail          NVARCHAR(255),
     localidad     NVARCHAR(255),
     codigo_postal DECIMAL(18, 0),
     direccion     NVARCHAR(255),
     telefono      DECIMAL(18, 0),
     PRIMARY KEY(id)
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

ALTER TABLE sqlnt.PRODUCTO
ADD FOREIGN KEY (material) REFERENCES sqlnt.MATERIAL(id)

ALTER TABLE sqlnt.PRODUCTO
ADD FOREIGN KEY (marca) REFERENCES sqlnt.MARCA(id)


ALTER TABLE sqlnt.PRODUCTO_VARIANTE 
ADD FOREIGN KEY (producto) REFERENCES sqlnt.PRODUCTO(codigo)

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
ADD FOREIGN KEY (cliente) REFERENCES sqlnt.CLIENTE(id)

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

ALTER TABLE sqlnt.ENVIO 
ADD FOREIGN KEY (venta) REFERENCES sqlnt.VENTA(nro_venta)

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


/*---------------------INSERTS---------------------*/

CREATE PROCEDURE sqlnt.insertar_categorias
AS
INSERT INTO sqlnt.CATEGORIA(id, detalle)
SELECT NEXT VALUE FOR sqlnt.contador_categorias, PRODUCTO_CATEGORIA
FROM GD2C2022.gd_esquema.Maestra
WHERE PRODUCTO_CATEGORIA IS NOT NULL
GROUP BY PRODUCTO_CATEGORIA


/*--------------------------------------------------*/

/*----------------------Facu section----------------------------*/

CREATE SEQUENCE sqlnt.seq_canal_venta
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647;

CREATE SEQUENCE sqlnt.seq_provincia
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647;

CREATE SEQUENCE sqlnt.seq_medio_pago_compra
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647;

CREATE SEQUENCE sqlnt.seq_cliente
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647;


CREATE SEQUENCE sqlnt.seq_producto_material
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647;

CREATE SEQUENCE sqlnt.seq_producto_marca
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647;

CREATE SEQUENCE sqlnt.seq_variante
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647;

CREATE PROCEDURE sqlnt.insertar_canales_vta
AS
	INSERT INTO sqlnt.CANAL_VENTA
		(id,descripcion,costo_asociado)
		SELECT
			NEXT VALUE FOR sqlnt.seq_canal_venta,
			m.VENTA_CANAL,
			m.VENTA_CANAL_COSTO
		FROM gd_esquema.Maestra m 
		WHERE 
			m.VENTA_CANAL IS NOT NULL AND 
			m.VENTA_CANAL_COSTO IS NOT NULL
		GROUP BY m.VENTA_CANAL,m.VENTA_CANAL_COSTO 

CREATE PROCEDURE sqlnt.insertar_provincias
AS
	INSERT INTO sqlnt.PROVINCIA
		(id,descripcion)
		SELECT 
			NEXT VALUE FOR sqlnt.seq_provincia,
			CONCAT(m.CLIENTE_PROVINCIA,m.PROVEEDOR_PROVINCIA)
		FROM gd_esquema.Maestra m
		GROUP BY CONCAT(m.CLIENTE_PROVINCIA,m.PROVEEDOR_PROVINCIA)

CREATE PROCEDURE sqlnt.insertar_medio_pago_compra
AS 
	INSERT INTO sqlnt.MEDIO_PAGO_COMPRA 
	(id,descripcion)
	SELECT
		NEXT VALUE FOR sqlnt.seq_medio_pago_compra,
		m.COMPRA_MEDIO_PAGO  
	FROM gd_esquema.Maestra m 
WHERE m.COMPRA_MEDIO_PAGO IS NOT NULL
GROUP BY m.COMPRA_MEDIO_PAGO 

CREATE PROCEDURE sqlnt.insertar_producto_variante_venta
AS
	INSERT INTO sqlnt.PRODUCTO_VARIANTE_VENTA
	(venta,producto_variante,cantidad,precio)
	SELECT 
		m.VENTA_CODIGO,
		m.PRODUCTO_VARIANTE_CODIGO,
		m.VENTA_PRODUCTO_CANTIDAD,
		m.VENTA_PRODUCTO_PRECIO 
	FROM gd_esquema.Maestra m
	WHERE 
		m.VENTA_CODIGO IS NOT NULL
		AND
		m.PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	GROUP BY 	m.VENTA_CODIGO,
		m.PRODUCTO_VARIANTE_CODIGO,
		m.VENTA_PRODUCTO_CANTIDAD,
		m.VENTA_PRODUCTO_PRECIO 

CREATE PROCEDURE sqlnt.insertar_codigo_postal
AS 
	INSERT INTO sqlnt.CODIGO_POSTAL 
	(codigo_postal,provincia)
	SELECT 
		* 
	FROM (
		SELECT 
			CONCAT(CLIENTE_CODIGO_POSTAL,PROVEEDOR_CODIGO_POSTAL) AS CODIGO_POSTAL,
			(SELECT p.id  FROM sqlnt.PROVINCIA p WHERE p.descripcion = CONCAT(CLIENTE_PROVINCIA,PROVEEDOR_PROVINCIA)) AS PROVINCIA
		FROM gd_esquema.Maestra 
	) T
	GROUP BY CODIGO_POSTAL,PROVINCIA
	
CREATE PROCEDURE sqlnt.insertar_cliente
AS 
	INSERT INTO sqlnt.CLIENTE 
	(
		id,
		nombre,
		apellido,
		nro_documento,
		fecha_nac,
		mail,
		localidad,
		codigo_postal,
		direccion,
		telefono
	)
	SELECT 
		NEXT VALUE FOR sqlnt.seq_cliente,
		NOMBRE,
		APELLIDO,
		DNI,
		FECHA_NAC,
		MAIL,
		LOCALIDAD,
		CODIGO_POSTAL,
		DIRECCION,
		TELEFONO
	FROM (
	SELECT
		m.CLIENTE_NOMBRE AS NOMBRE,
		m.CLIENTE_APELLIDO AS APELLIDO,
		m.CLIENTE_DNI AS DNI,
		m.CLIENTE_FECHA_NAC AS FECHA_NAC,
		m.CLIENTE_MAIL AS MAIL,
		m.CLIENTE_LOCALIDAD AS LOCALIDAD,
		(SELECT cp.codigo_postal FROM sqlnt.CODIGO_POSTAL cp WHERE cp.codigo_postal = m.CLIENTE_CODIGO_POSTAL) AS CODIGO_POSTAL,
		m.CLIENTE_DIRECCION AS DIRECCION,
		m.CLIENTE_TELEFONO AS TELEFONO
	FROM gd_esquema.Maestra m
	WHERE m.CLIENTE_DNI is not null
	) T
	GROUP BY
		NOMBRE,
		APELLIDO,
		DNI,
		FECHA_NAC,
		MAIL,
		LOCALIDAD,
		CODIGO_POSTAL,
		DIRECCION,
		TELEFONO

CREATE PROCEDURE sqlnt.insertar_venta
AS 
	INSERT INTO sqlnt.VENTA 
	(
		nro_venta,
		fecha_venta,
		total,
		total_descuentos,
		cliente,
		canal_venta,
		medio_pago 
	)
	SELECT 
		CODIGO,
		FECHA,
		TOTAL,
		SUM(ISNULL(DESCUENTO_VENTA,0)) AS TOTAL_DESCUENTOS,
		CLIENTE,
		CANAL,
		MEDIO_PAGO
	FROM
	(
	SELECT 
		VENTA_CODIGO AS CODIGO,
		VENTA_FECHA AS FECHA,
		VENTA_TOTAL AS TOTAL,
		VENTA_DESCUENTO_IMPORTE AS DESCUENTO_VENTA,
		(SELECT c.id FROM sqlnt.CLIENTE c WHERE c.nro_documento = CLIENTE_DNI AND c.mail = CLIENTE_MAIL) AS CLIENTE,
		(SELECT cv.id FROM sqlnt.CANAL_VENTA cv WHERE cv.descripcion = VENTA_CANAL) AS CANAL,
		(SELECT mpv.id FROM sqlnt.MEDIO_PAGO_VENTA mpv WHERE mpv.descripcion = VENTA_MEDIO_PAGO) AS MEDIO_PAGO
	FROM gd_esquema.Maestra
	) T
	WHERE CODIGO IS NOT NULL
	GROUP BY
		CODIGO,
		FECHA,
		TOTAL,
		CLIENTE,
		CANAL,
		MEDIO_PAGO

CREATE PROCEDURE sqlnt.insertar_envio
AS
	INSERT INTO sqlnt.ENVIO 
	(
		venta,
		medio_envio,
		domicilio_envio,
		codigo_postal,
		costo
	)
	SELECT
		VENTA,
		MEDIO_ENVIO,
		DIRECCION,
		CODIGO_POSTAL,
		COSTO_ENVIO
	FROM 
	(
	SELECT
		m.VENTA_CODIGO AS VENTA,
		(SELECT me.id FROM sqlnt.MEDIO_ENVIO me WHERE me.descripcion = m.VENTA_MEDIO_ENVIO) AS MEDIO_ENVIO,
		m.CLIENTE_DIRECCION AS DIRECCION,
		(SELECT cp.codigo_postal FROM sqlnt.CODIGO_POSTAL cp WHERE cp.codigo_postal = m.CLIENTE_CODIGO_POSTAL) AS CODIGO_POSTAL,
		m.VENTA_ENVIO_PRECIO AS COSTO_ENVIO
	FROM gd_esquema.Maestra m 	
	WHERE m.VENTA_MEDIO_ENVIO IS NOT NULL
	) T
	GROUP BY
		VENTA,
		MEDIO_ENVIO,
		DIRECCION,
		CODIGO_POSTAL,
		COSTO_ENVIO
		
CREATE PROCEDURE sqlnt.insertar_cupon
AS
	INSERT INTO sqlnt.CUPON 
	(codigo,tipo_cupon,valor,fecha_desde,fecha_hasta)
	SELECT 
		CODIGO,
		TIPO_CUPON,
		VALOR,
		FECHA_DESDE,
		FECHA_HASTA
	FROM
	(
	SELECT 
		m.VENTA_CUPON_CODIGO AS CODIGO,
		(SELECT tc.id  FROM sqlnt.TIPO_CUPON tc WHERE tc.descripcion = m.VENTA_CUPON_TIPO) AS TIPO_CUPON,
		m.VENTA_CUPON_VALOR AS VALOR,
		m.VENTA_CUPON_FECHA_DESDE AS FECHA_DESDE,
		m.VENTA_CUPON_FECHA_HASTA AS FECHA_HASTA
	FROM gd_esquema.Maestra m 
	WHERE m.VENTA_CUPON_CODIGO IS NOT NULL
	) T
	GROUP BY 
		CODIGO,
		TIPO_CUPON,
		VALOR,
		FECHA_DESDE,
		FECHA_HASTA

CREATE PROCEDURE sqlnt.insertar_cupon_venta
AS
	INSERT INTO sqlnt.CUPON_VENTA 
	(cupon,venta)
	SELECT * FROM
	(
	SELECT 
		(SELECT c.codigo FROM sqlnt.CUPON c WHERE c.codigo = m.VENTA_CUPON_CODIGO) AS CUPON,
		(SELECT v.nro_venta FROM sqlnt.VENTA v WHERE v.nro_venta = m.VENTA_CODIGO) AS VENTA
	FROM gd_esquema.Maestra m 
	WHERE m.VENTA_CUPON_CODIGO IS NOT NULL
	) T
	GROUP BY 
		CUPON,
		VENTA
		
CREATE PROCEDURE sqlnt.insertar_proveedores
AS
	INSERT INTO sqlnt.PROVEEDOR
	(
		prove_cuit,
		prove_razon_social,
		prove_domicilio,
		prove_localidad,
		prove_mail,
		prove_codigo_postal 
	)
	SELECT *
	FROM (
		SELECT
			m.PROVEEDOR_CUIT AS CUIT,
			m.PROVEEDOR_RAZON_SOCIAL AS RAZON_SOCIAL,
			m.PROVEEDOR_DOMICILIO AS DOMICILIO,
			m.PROVEEDOR_LOCALIDAD AS LOCALIDAD,
			m.PROVEEDOR_MAIL AS MAIL,
			(SELECT cp.codigo_postal FROM sqlnt.CODIGO_POSTAL cp WHERE cp.codigo_postal = m.PROVEEDOR_CODIGO_POSTAL) AS CODIGO_POSTAL
		FROM gd_esquema.Maestra m 
		WHERE m.PROVEEDOR_CUIT IS NOT NULL
	) T 
	GROUP BY 
		CUIT,
		RAZON_SOCIAL,
		DOMICILIO,
		LOCALIDAD,
		MAIL,
		CODIGO_POSTAL
		
CREATE PROCEDURE sqlnt.insertar_compras
AS
	INSERT INTO sqlnt.COMPRA 
	(nro_compra,fecha_compra,proveedor,compra_total,medio_pago)	
	SELECT * FROM (	
		SELECT
			m.COMPRA_NUMERO AS NUMERO_COMPRA,
			m.COMPRA_FECHA AS FECHA_COMPRA,
			(SELECT p.prove_cuit FROM sqlnt.PROVEEDOR p WHERE p.prove_cuit = m.PROVEEDOR_CUIT) AS PROVEEDOR,
			m.COMPRA_TOTAL AS TOTAL,
			(SELECT mpc.id FROM sqlnt.MEDIO_PAGO_COMPRA mpc WHERE mpc.descripcion = m.COMPRA_MEDIO_PAGO) AS MEDIO_PAGO 
		FROM gd_esquema.Maestra m 
		WHERE m.COMPRA_NUMERO IS NOT NULL
	) T
	GROUP BY 
		NUMERO_COMPRA,
		FECHA_COMPRA,
		PROVEEDOR,
		TOTAL,
		MEDIO_PAGO
		
CREATE PROCEDURE sqlnt.insertar_materiales
AS
	INSERT INTO sqlnt.MATERIAL 
	(id,detalle)
	SELECT 
		NEXT VALUE FOR sqlnt.seq_producto_material,
		m.PRODUCTO_MATERIAL  
	FROM gd_esquema.Maestra m
	WHERE m.PRODUCTO_MATERIAL IS NOT NULL
	GROUP BY m.PRODUCTO_MATERIAL 

CREATE PROCEDURE sqlnt.insertar_marcas
AS
	INSERT INTO sqlnt.MARCA 
	(id,detalle)
	SELECT 
		NEXT VALUE FOR sqlnt.seq_producto_marca,
		m.PRODUCTO_MARCA
	FROM gd_esquema.Maestra m
	WHERE m.PRODUCTO_MARCA IS NOT NULL
	GROUP BY m.PRODUCTO_MARCA 
	
CREATE PROCEDURE sqlnt.insertar_productos
AS 
INSERT INTO sqlnt.PRODUCTO 
(codigo,nombre,descripcion,material,marca,categoria)
SELECT * FROM
(	
	SELECT
		m.PRODUCTO_CODIGO AS CODIGO,
		m.PRODUCTO_NOMBRE AS NOMBRE,
		m.PRODUCTO_DESCRIPCION AS DESCRIPCION,
		(SELECT ma.id FROM sqlnt.MATERIAL ma WHERE ma.detalle = m.PRODUCTO_MATERIAL) AS MATERIAL,
		(SELECT m2.id  FROM sqlnt.MARCA m2 WHERE m2.detalle = m.PRODUCTO_MARCA) AS MARCA,
		(SELECT c.id  FROM sqlnt.CATEGORIA c WHERE c.detalle = m.PRODUCTO_CATEGORIA) AS CATEGORIA 
	FROM gd_esquema.Maestra m 
	WHERE PRODUCTO_CODIGO is not null
) T
GROUP BY 
	CODIGO,
	NOMBRE,
	DESCRIPCION,
	MATERIAL,
	MARCA,
	CATEGORIA
	
CREATE PROCEDURE sqlnt.insertar_variante
AS 
	INSERT INTO sqlnt.VARIANTE 
	(id,detalle,tipo_variante)
	SELECT 
		NEXT VALUE FOR sqlnt.seq_variante,
		DETALLE,
		TIPO_VARIANTE
	FROM
	(
		SELECT 
			m.PRODUCTO_VARIANTE AS DETALLE,
			(SELECT tv.id FROM sqlnt.TIPO_VARIANTE tv WHERE tv.detalle = m.PRODUCTO_TIPO_VARIANTE) AS TIPO_VARIANTE 
		FROM gd_esquema.Maestra m 
		WHERE m.PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	) T
	GROUP BY 
		DETALLE,
		TIPO_VARIANTE

CREATE PROCEDURE sqlnt.insertar_producto_variante
AS 
	INSERT INTO sqlnt.PRODUCTO_VARIANTE 
	(codigo,producto,variante,precio_unitario)
	SELECT
		CODIGO,
		PRODUCTO,
		VARIANTE,
		MAX(PRECIO) AS PRECIO
	FROM (	
		SELECT 
			m.PRODUCTO_VARIANTE_CODIGO AS CODIGO,
			(SELECT p.codigo FROM sqlnt.PRODUCTO p WHERE p.codigo = m.PRODUCTO_CODIGO) AS PRODUCTO,
			(SELECT v.id FROM sqlnt.VARIANTE v WHERE v.detalle = m.PRODUCTO_VARIANTE) AS VARIANTE,
			m.VENTA_PRODUCTO_PRECIO AS PRECIO
		FROM gd_esquema.Maestra m 
		WHERE m.PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	) T
	GROUP BY
		CODIGO,
		PRODUCTO,
		VARIANTE
		
CREATE PROCEDURE sqlnt.insertar_producto_variante_venta
AS
	INSERT INTO sqlnt.PRODUCTO_VARIANTE_VENTA 
	(venta,producto_variante,cantidad,precio)
	SELECT 
		VENTA,
		PRODUCTO_VARIANTE,
		PRECIO,
		SUM(CANTIDAD)
	FROM (
	SELECT 
		(SELECT v.nro_venta FROM sqlnt.VENTA v WHERE v.nro_venta = m.VENTA_CODIGO) AS VENTA,
		(SELECT pv.codigo FROM sqlnt.PRODUCTO_VARIANTE pv WHERE pv.codigo = m.PRODUCTO_VARIANTE_CODIGO) AS PRODUCTO_VARIANTE,
		m.VENTA_PRODUCTO_PRECIO AS PRECIO,	
		m.VENTA_PRODUCTO_CANTIDAD AS CANTIDAD
	FROM gd_esquema.Maestra m 
	WHERE m.PRODUCTO_VARIANTE_CODIGO IS NOT NULL AND m.VENTA_CODIGO IS NOT NULL
	) T
	GROUP BY VENTA,PRODUCTO_VARIANTE,PRECIO
	
	
CREATE PROCEDURE sqlnt.insertar_producto_variante_compra
AS
	INSERT INTO sqlnt.PRODUCTO_VARIANTE_COMPRA 
	(compra,producto_variante,cantidad_producto,precio_unitario)
	SELECT
		COMPRA,
		PRODUCTO_VARIANTE,
		SUM(CANTIDAD),
		PRECIO
	FROM 
	(
		SELECT
			(SELECT c.nro_compra FROM sqlnt.COMPRA c WHERE c.nro_compra = m.COMPRA_NUMERO) AS COMPRA,
			(SELECT pv.codigo FROM sqlnt.PRODUCTO_VARIANTE pv WHERE pv.codigo = m.PRODUCTO_VARIANTE_CODIGO) AS PRODUCTO_VARIANTE,
			m.COMPRA_PRODUCTO_CANTIDAD AS CANTIDAD,
			m.COMPRA_PRODUCTO_PRECIO AS PRECIO
		FROM gd_esquema.Maestra m 
		WHERE m.COMPRA_NUMERO IS NOT NULL AND m.PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	) T
	GROUP BY COMPRA,PRODUCTO_VARIANTE,PRECIO
	
/*----------------------Facu section----------------------------*/

EXEC sqlnt.insertar_categorias
EXEC sqlnt.insertar_materiales
EXEC sqlnt.insertar_marcas
EXEC sqlnt.insertar_productos
EXEC sqlnt.insertar_canales_vta
EXEC sqlnt.insertar_provincias
EXEC sqlnt.insertar_medio_pago_compra
EXEC sqlnt.insertar_codigo_postal
EXEC sqlnt.insertar_cliente
EXEC sqlnt.insertar_venta
EXEC sqlnt.insertar_envio
EXEC sqlnt.insertar_cupon
EXEC sqlnt.insertar_cupon_venta
EXEC sqlnt.insertar_proveedores
EXEC sqlnt.insertar_compras
EXEC sqlnt.insertar_variante
EXEC sqlnt.insertar_producto_variante
EXEC sqlnt.insertar_producto_variante_venta
EXEC sqlnt.insertar_producto_variante_compra
