/*NOTA agregar faccionable a tabla de articulos*/

/*SELECCION QUE TRAE productos*/
SELECT 	productos.id_articulo, productos.nombre,marcas.nombre_marca, categorias.nombre_categoria, 
		productos.contenido,unidades.abreviacion_unidad,productos.fraccionable,productos.codigo_barras,
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
INNER JOIN productos ON productos.id_articulo=insumos_servicios.id_producto
WHERE insumos_servicios.id_servicio=3;

/*INSERCIONES DE ARTICULOS*/
INSERT INTO articulos (nombre,precio,activo,tipo_articulo) VAlUES ('cuaderno profesional cuadro chico',20,1,1);
INSERT INTO articulos (nombre,precio,activo,tipo_articulo) VAlUES ('Hoja papel tamaño carta blanca',.33,1,1);
INSERT INTO articulos (nombre,precio,activo,tipo_articulo) VAlUES ('fotocopia B/N',1,1,1);

/*INSERCIONES DE PRODUCTOS*/
INSERT INTO productos VALUES(1,1,1,1,'cuaderno profesional cuadro chico',1,0,'','',20,5);
/*INSERCIONES EN SERVICIOS*/
INSERT INTO servicios VALUES (3,'fotocopia B/N', '');
/*INSERT INTO insumos*/
INSERT INTO insumos_servicios VALUES (3,2,1);


