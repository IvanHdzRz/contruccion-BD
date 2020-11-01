CREATE DATABASE papeleria;
USE papeleria;

CREATE TABLE marcas(
id_marca 		INT AUTO_INCREMENT NOT NULL,
nombre_marca	VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY (id_marca)
);

CREATE TABLE categorias(
id_categoria 		INT AUTO_INCREMENT NOT NULL,
nombre_categoria	VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY (id_categoria)
);

CREATE TABLE unidades(
id_unidad 			INT AUTO_INCREMENT NOT NULL,
nombre_unidad		VARCHAR(50) NOT NULL UNIQUE,
abreviacion_unidad	VARCHAR(4) NOT NULL UNIQUE,
PRIMARY KEY (id_unidad)
);

CREATE TABLE tipo_articulos(
id_tipo_art		INT AUTO_INCREMENT NOT NULL,
nombre_tipo		VARCHAR(20) NOT NULL UNIQUE,
PRIMARY KEY (id_tipo_art)
);

CREATE TABLE articulos(
id_articulo		INT NOT NULL AUTO_INCREMENT,
imagen_url			TINYTEXT,
nombre				VARCHAR(255) NOT NULL,
precio			FLOAT NOT NULL,
activo			BOOL CHECK (activo IN (0,1)) NOT NULL,
tipo_articulo	INT NOT NULL,
FOREIGN KEY (tipo_articulo) REFERENCES tipo_articulos(id_tipo_art),
PRIMARY KEY (id_articulo)  
);

CREATE TABLE productos(
id_articulo 		INT NOT NULL UNIQUE,
id_marca			INT NOT NULL,
id_categoria 		INT NOT NULL,
id_unidad			INT NOT NULL,
nombre				VARCHAR(255) NOT NULL,
contenido			FLOAT NOT NULL,
fraccionable 		BOOL CHECK (fraccionable IN (0,1)) NOT NULL,
codigo_barras		VARCHAR(20),
stock 				FLOAT NOT NULL,
stock_minimo		FLOAT NOT NULL,
 UNIQUE KEY producto_unico (id_articulo,id_marca,id_categoria,id_unidad,nombre,contenido,fraccionable),
FOREIGN KEY (id_articulo) 	REFERENCES articulos(id_articulo),
FOREIGN KEY	(id_marca)		REFERENCES marcas(id_marca),
FOREIGN KEY (id_categoria)	REFERENCES categorias(id_categoria),
FOREIGN KEY (id_unidad)		REFERENCES unidades(id_unidad)
);

CREATE TABLE servicios (
id_servicio			INT NOT NULL UNIQUE,
nombre				VARCHAR(255) NOT NULL UNIQUE,
descripcion			TINYTEXT,
FOREIGN KEY (id_servicio) REFERENCES articulos(id_articulo)
);

CREATE TABLE insumos_servicios(
id_servicio INT NOT NULL,
id_producto INT NOT NULL,
cantidad	FLOAT NOT NULL,
FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio),
FOREIGN KEY (id_producto) REFERENCES productos(id_articulo)
);

CREATE TABLE promociones(
id_promocion	INT NOT NULL UNIQUE,
nombre			VARCHAR(255) NOT NULL UNIQUE,
descripcion		TEXT NOT NULL,
fecha_inicio	DATE NOT NULL,
fecha_fin		DATE NOT NULL,
FOREIGN KEY (id_promocion) REFERENCES articulos(id_articulo)
);

CREATE TABLE detalle_promociones(
id_promocion	INT NOT NULL,
id_producto		INT NOT NULL,
cantidad		FLOAT,
FOREIGN KEY (id_promocion) 	REFERENCES promociones(id_promocion),
FOREIGN KEY (id_producto) 	REFERENCES productos(id_articulo)
);

CREATE TABLE permisos(
id				INT NOT NULL AUTO_INCREMENT,
nombre			VARCHAR(255) NOT NULL UNIQUE,
descripcion		TINYTEXT,
PRIMARY KEY (id)
);

CREATE TABLE roles(
id				INT NOT NULL AUTO_INCREMENT,
nombre			VARCHAR(255) NOT NULL UNIQUE,
descripcion		TINYTEXT,
PRIMARY KEY (id)
);
		
CREATE TABLE permisos_rol(
id_rol			INT NOT NULL,
id_permiso		INT NOT NULL,
autorizado		BOOL CHECK (autorizado in (0,1)),
FOREIGN KEY (id_rol) 	REFERENCES roles(id),
FOREIGN KEY (id_permiso)REFERENCES permisos(id)	
);        

CREATE TABLE usuarios(
nombre_usuario	VARCHAR(50) NOT NULL UNIQUE,
id_rol			INT NOT NULL,
nombre			VARCHAR(50) NOT NULL,
apellido_pat	VARCHAR(50) NOT NULL,
apellido_mat	VARCHAR(50),
email			VARCHAR(50) NOT NULL UNIQUE,
telefono		VARCHAR(50) NOT NULL UNIQUE,
avatar_img		TINYTEXT,
contrasenia		TINYTEXT,
PRIMARY KEY (nombre_usuario),
FOREIGN KEY (id_rol) REFERENCES roles(id)
);

CREATE TABLE tipo_clientes(
id_tipo			INT NOT NULL AUTO_INCREMENT,
nombre			VARCHAR(50) NOT NULL UNIQUE,
descuento		FLOAT CHECK (descuento >= 0 AND descuento <=0.25) NOT NULL,
compra_minima	FLOAT NOT NULL,
PRIMARY KEY (id_tipo)
);

CREATE TABLE clientes(
id				INT NOT NULL AUTO_INCREMENT,
nombre			TINYTEXT NOT NULL,
apellido_pat	TINYTEXT,
apellido_mat	TINYTEXT,
rfc				TINYTEXT,
correo			TINYTEXT,
tipo_cliente	INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (tipo_cliente) REFERENCES tipo_clientes(id_tipo)
);
CREATE TABLE ventas(
id				INT NOT NULL AUTO_INCREMENT,
id_empleado		VARCHAR(50) NOT NULL,
id_cliente		INT DEFAULT 1 NOT NULL,
fecha			DATE,
subtotal		FLOAT CHECK (subtotal>0) NOT NULL,
importe			FLOAT CHECK (importe > 0) NOT NULL,
descuento		FLOAT DEFAULT 0,
PRIMARY KEY(id),
FOREIGN KEY (id_empleado) 	REFERENCES usuarios(nombre_usuario),
FOREIGN KEY (id_cliente) 	REFERENCES clientes(id)
);

CREATE TABLE detalle_ventas(
id_venta		INT NOT NULL,
id_articulo		INT NOT NULL,
precio			FLOAT NOT NULL CHECK (precio>0),
cantidad		FLOAT NOT NULL CHECK (cantidad>0),
FOREIGN KEY (id_venta) 		REFERENCES ventas(id),
FOREIGN KEY (id_articulo)	REFERENCES articulos(id_articulo)
);

CREATE TABLE proveedores(
id			INT NOT NULL AUTO_INCREMENT,
nombre		VARCHAR(255) NOT NULL UNIQUE,
rfc			VARCHAR(30), 
telefono	VARCHAR(10),
correo		VARCHAR(50),
PRIMARY KEY (id)
);

CREATE TABLE compras(
id_compra		INT NOT NULL AUTO_INCREMENT,
id_usuario		VARCHAR(50) NOT NULL,
id_proveedor	INT NOT NULL,
importe			FLOAT CHECK (importe > 0) NOT NULL,
fecha			DATE NOT NULL,
PRIMARY KEY (id_compra),
FOREIGN KEY (id_usuario) 	REFERENCES usuarios (nombre_usuario),
FOREIGN KEY (id_proveedor)	REFERENCES proveedores(id)
);

CREATE TABLE detalle_compras(
id_compra		INT NOT NULL,
id_producto		INT NOT NULL,
cantidad		FLOAT CHECK (cantidad >0) NOT NULL,
costo_unitario	FLOAT CHECK (costo_unitario > 0) NOT NULL,
FOREIGN KEY (id_compra) 	REFERENCES compras(id_compra),
FOREIGN KEY (id_producto)	REFERENCES productos(id_articulo)
);

CREATE TABLE mermas(
id_merma	INT NOT NULL AUTO_INCREMENT,
id_usuario	VARCHAR(50) NOT NULL,
id_producto	INT NOT NULL,
cantidad	FLOAT CHECK (cantidad>0),
precio		FLOAT CHECK (precio>0),
fecha		DATE,
PRIMARY KEY (id_merma),
FOREIGN KEY (id_usuario) 	REFERENCES usuarios(nombre_usuario),
FOREIGN KEY (id_producto)	REFERENCES productos(id_articulo)
);

CREATE TABLE producto_negado (
id_prod_negado 	INT NOT NULL AUTO_INCREMENT,
nombre			VARCHAR(255) NOT NULL UNIQUE,
descripcion		TINYTEXT,
PRIMARY KEY (id_prod_negado)
);