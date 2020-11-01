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

/*OBTENER LOS PERMISOS DE UN ROL*/
SELECT roles.nombre, permisos.nombre, permisos_rol.autorizado
FROM permisos_rol
INNER JOIN roles ON roles.id=permisos_rol.id_rol
INNER JOIN permisos ON permisos.id=permisos_rol.id_permiso;
/*OBTENER INF DE USUARIO*/
SELECT usuarios.nombre_usuario, roles.nombre, usuarios.nombre
FROM usuarios
INNER JOIN roles ON roles.id=usuarios.id_rol;

/*select de ventas*/

SELECT v.id ,v.id_empleado,c.nombre,v.fecha,v.importe
FROM ventas AS v
INNER JOIN clientes AS c ON c.id=v.id_cliente;
/*SELECT DE detalle de ventas*/
SELECT dv.id_venta, articulos.nombre, dv.precio,dv.cantidad, (dv.cantidad*dv.precio) AS 'total'
FROM detalle_ventas AS dv
INNER JOIN articulos ON articulos.id_articulo=dv.id_articulo;
/*select de compras*/
SELECT c.id_compra,c.id_usuario,p.nombre,c.importe,c.fecha
FROM compras AS c
INNER JOIN proveedores AS p ON p.id=c.id_proveedor;
/*select de detalle de compras*/
SELECT dc.id_compra,p.nombre,dc.cantidad,dc.costo_unitario, (dc.cantidad*dc.costo_unitario) AS 'total'
FROM detalle_compras AS dc
INNER JOIN productos AS p ON p.id_articulo=dc.id_producto;
/*select de  mermas*/
SELECT m.id_merma, m.id_usuario,productos.nombre,m.cantidad,m.precio,(m.precio*m.cantidad) AS 'perdida', m.fecha
FROM mermas AS m
INNER JOIN productos ON productos.id_articulo = m.id_producto;

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

/*inserts de permisos*/

INSERT INTO permisos (nombre,descripcion) VALUES ('agregar producto','el usuario puede agregar productos nuevos a la base de datos');
 /*inserts de roles*/
 
 INSERT INTO roles (nombre,descripcion) VALUES ('administrador','todos los permisos asigandos');
/*inserts de permisos por rol*/
INSERT INTO permisos_rol VALUES (1,1,1);

/*insert de usuarios*/
SELECT * FROM usuarios;
INSERT INTO usuarios VALUES('ivan',1,'ivan','hdz','rz','mail@mail.com','5512345678','','contrasenia');

/*inserts de tipos de clientes*/

INSERT INTO tipo_clientes (nombre,descuento,compra_minima) VALUES('general',0,0);
INSERT INTO clientes (nombre, tipo_cliente) VALUES ('cliente general',1);

/*inserts en tabla ventas*/

INSERT INTO ventas (id_empleado,fecha,subtotal,importe) VALUES ('ivan','2020-10-10',60,60);

/*insert en detalle de ventas*/
INSERT INTO detalle_ventas VALUES (1,8,20,3);

INSERT INTO proveedores (nombre) VALUES ('desconocido');

INSERT INTO compras (id_usuario,id_proveedor,importe,fecha) VALUES ('ivan',1,260,'2020-10-01');
SELECT * FROM detalle_compras;
INSERT INTO detalle_compras VALUES (2,8,20,13);

INSERT INTO mermas (id_usuario,id_producto,cantidad,precio,fecha) VALUES ('ivan',8,1,20,'2020-10-02');

insert into producto_negado(nombre,descripcion) VALUES ('lluvia', 'adorno de tiras que se pega en el techo');
SELECT * FROM producto_negado;