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

		