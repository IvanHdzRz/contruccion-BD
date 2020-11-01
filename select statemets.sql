/*NOTA agregar faccionable a tabla de articulos*/

/*SELECCION QUE TRAE productos*/
SELECT 	productos.id_articulo, productos.nombre,marcas.nombre_marca, categorias.nombre_categoria, 
		productos.contenido,unidades.abreviacion_unidad,articulos.precio,productos.fraccionable,productos.codigo_barras,
        productos.stock,productos.stock_minimo
FROM productos
INNER JOIN articulos 	ON articulos.id_articulo=productos.id_articulo
INNER JOIN marcas		ON marcas.id_marca=productos.id_marca
INNER JOIN categorias 	ON categorias.id_categoria=productos.id_categoria
INNER JOIN unidades		ON unidades.id_unidad=productos.id_unidad;

/*SELECT QUE TRAE TODOS LOS SERVICIOS*/

SELECT articulos.id_articulo, servicios.nombre, servicios.descripcion, articulos.precio, articulos.activo
FROM servicios
INNER JOIN articulos ON articulos.id_articulo=servicios.id_servicio;
/*SELECT que trae los insumos de los servcios*/
SELECT servicios.nombre, productos.nombre, cantidad 
FROM insumos_servicios
INNER JOIN servicios ON servicios.id_servicio=insumos_servicios.id_servicio
INNER JOIN productos ON productos.id_articulo=insumos_servicios.id_producto;

/*SELECT DE ARTICULOS*/
SELECT articulos.id_articulo,articulos.nombre, articulos.precio, articulos.activo, tipo_articulos.nombre_tipo
FROM articulos
INNER JOIN tipo_articulos ON tipo_articulos.id_tipo_art=articulos.tipo_articulo;
/*SELECT  DE PROMOCIONES*/
SELECT promociones.id_promocion, promociones.nombre, 
	/*trae los productos que requiere la promocion y los divide entre la cantidad de stock de ese producto*/
    /*y se toma el minimo para calcular las existencias*/
    (SELECT MIN(productos.stock/detalle_promociones.cantidad) 
	FROM detalle_promociones 
	INNER JOIN productos ON productos.id_articulo=detalle_promociones.id_producto
	) AS 'existencias'
FROM promociones;

/*select de detalle de promos insumos de la promocion*/
SELECT detalle_promociones.id_promocion, promociones.nombre,productos.nombre,detalle_promociones.cantidad
FROM detalle_promociones 
INNER JOIN productos ON productos.id_articulo=detalle_promociones.id_producto
INNER JOIN promociones ON promociones.id_promocion=detalle_promociones.id_promocion;

/*obtener existencias de una promocion*/
SELECT detalle_promociones.id_promocion, promociones.nombre,productos.nombre,detalle_promociones.cantidad
FROM detalle_promociones 
INNER JOIN productos ON productos.id_articulo=detalle_promociones.id_producto
INNER JOIN promociones ON promociones.id_promocion=detalle_promociones.id_promocion;



/*INSERCIONES DE ARTICULOS*/
INSERT INTO articulos (nombre,precio,activo,tipo_articulo) VAlUES ('Hoja papel tamaño carta blanca',.33,1,1);
INSERT INTO articulos (nombre,precio,activo,tipo_articulo) VAlUES ('cuaderno profesional cuadro chico',20,1,1);
INSERT INTO articulos (nombre,precio,activo,tipo_articulo) VAlUES ('fotocopia B/N',1,1,2);
INSERT INTO articulos (nombre,precio,activo,tipo_articulo) VAlUES ('regresao a clases',60,1,3);
INSERT INTO articulos (nombre,precio,activo,tipo_articulo) VAlUES ('cuaderno profesional cuadro grande',20,1,1);
SELECT * FROM articulos;
/*INSERCIONES DE PRODUCTOS*/
INSERT INTO productos VALUES(8,1,1,1,'cuaderno profesional cuadro chico',1,0,'',20,5);
INSERT INTO productos VALUES(7,1,1,1,'Hoja papel tamaño carta blanca',1,0,'',20,5);
INSERT INTO productos VALUES(11,1,1,1,'cuaderno profesional cuadro grande',1,0,'',20,5);
/*INSERCIONES EN SERVICIOS*/
INSERT INTO servicios VALUES (9,'fotocopia B/N', '');
/*INSERT INTO insumos*/
INSERT INTO insumos_servicios VALUES (9,7,1);
/*INSERT DE promocion*/
INSERT INTO promociones VALUES (10,'regreso a clases','contiene 4 cuadernos profesionales cuadro chico','2020-07-01','2020-07-29' );
/*INSERT de detalles de promos*/
INSERT INTO detalle_promociones VALUES (10,8,4);
INSERT INTO detalle_promociones VALUES (10,11,2);



