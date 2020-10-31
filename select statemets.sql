INSERT INTO articulos(precio,activo,tipo_articulo) VALUES(18.50,1,1);
SELECT * FROM articulos;

SELECT * FROM productos;
INSERT INTO productos VALUES(1,1,2,1,'cuaderno profesional cuadro chico',1,0,'07123123123','',20,5);
/*SELECCION QUE TRAE productos*/
SELECT 	productos.id_articulo, productos.nombre,marcas.nombre_marca, categorias.nombre_categoria, 
		productos.contenido,unidades.abreviacion_unidad,productos.fraccionable,productos.codigo_barras,
        productos.stock,productos.stock_minimo
FROM productos
INNER JOIN articulos 	ON articulos.id_articulo=productos.id_articulo
INNER JOIN marcas		ON marcas.id_marca=productos.id_marca
INNER JOIN categorias 	ON categorias.id_categoria=productos.id_categoria
INNER JOIN unidades		ON unidades.id_unidad=productos.id_unidad;