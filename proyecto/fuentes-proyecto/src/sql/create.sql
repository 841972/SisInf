/*
 * File: 	crearTablas.sql
 * Authors: Diego Raul Roldan Uruena,	841723
 * 			Pablo Moreno Munoz, 841972
 * 			Abel Romeo Lancina,	846088
 * Date: diciembre 2023
 * Coms: Sentencias que crean las tablas de la base de datos de PCarp
*/

CREATE TABLE usuario (
	id_usuario 		SERIAL PRIMARY KEY,
	nombre  		VARCHAR (20) NOT NULL,
	apellidos  		VARCHAR (30) NOT NULL,
	contrasena 		VARCHAR (20) NOT NULL,
	direccion 		VARCHAR (30),
    mail            VARCHAR (50) NOT NULL UNIQUE,
	es_admin		BOOLEAN NOT NULL
);

CREATE TABLE pedido (
  	id_pedido		SERIAL PRIMARY KEY,
	id_usuario		INT REFERENCES Usuario (id_usuario),
	fecha   		TIMESTAMP NOT NULL DEFAULT current_timestamp,
	fecha_llegada   DATE CHECK (fecha_llegada>DATE(fecha)),
  	estado       	VARCHAR (10) NOT NULL DEFAULT 'pendiente' CHECK (estado = 'procesando' OR estado = 'enviado' OR estado = 'entregado')
);

CREATE TABLE producto (
  	id_producto     SERIAL PRIMARY KEY,
	marca 			VARCHAR(25) NOT NULL,
	modelo			VARCHAR(50) UNIQUE NOT NULL,
	precio	    	REAL NOT NULL CHECK (precio > 0),
	descuento    	REAL CHECK ((descuento >= 0 ) AND (descuento < 100)), -- en porcentaje
  	descripcion 	VARCHAR (70),
	stock		    INT NOT NULL,
	ventas			INT NOT NULL DEFAULT 0 CHECK (ventas >= 0),
	tipo 			VARCHAR CHECK (tipo='placa_base' OR
								   tipo='procesador' OR
								   tipo='disco_duro' OR
								   tipo='grafica' OR
								   tipo='ram' OR
								   tipo='ventilador' OR
								   tipo='caja_torre' OR
								   tipo='fuente_alimentacion')
);

CREATE TABLE placa_base (
	id_producto     INT REFERENCES Producto (id_producto),
	
	chipset			VARCHAR(15) NOT NULL,
	tiene_m2		INT NOT NULL
);

CREATE TABLE procesador (
	id_producto     INT REFERENCES Producto (id_producto),
	
	familia			VARCHAR(15) NOT NULL
);

CREATE TABLE disco_duro (
  	id_producto     INT REFERENCES Producto (id_producto),

	tamano			INT NOT NULL,-- en GB
	tecnologia		VARCHAR(3) NOT NULL CHECK ((tecnologia='HDD') OR (tecnologia='SSD') OR (tecnologia='M2'))
);

CREATE TABLE grafica (
	id_producto     INT REFERENCES Producto (id_producto),

	tipo 			VARCHAR(6)  NULL CHECK ((tipo='NVIDIA') OR (tipo='AMD') OR (tipo='intel')),
	memoria			INT NOT NULL -- en GB
);

CREATE TABLE ram (
	id_producto     INT REFERENCES Producto (id_producto),
	
	tipo			VARCHAR(4)  NOT NULL CHECK ((tipo='DDR5') OR (tipo='DDR4') OR (tipo='DDR3')),
	cantidad		INT NOT NULL, -- cantidad de ranuras que vienen
	almacenamiento  INT NOT NULL -- GB en cada ranura  
);

CREATE TABLE ventilador (
    ID INT REFERENCES Producto (id_producto),
    tipoDisipador VARCHAR(35),
    nivelRuidoDBA DECIMAL(4, 2)
);

CREATE TABLE caja_torre (
	id_producto     INT REFERENCES Producto (id_producto),
	tipo_placa VARCHAR(20)
);

CREATE TABLE fuente_alimentacion (
	id_producto     INT REFERENCES Producto (id_producto),

	potencia		INT NOT NULL -- en W
);

CREATE TABLE contenido_pedido (
	id_pedido		INT REFERENCES Pedido (id_pedido),
	id_producto		INT REFERENCES Producto (id_producto),
    cantidad        INT NOT NULL,
	PRIMARY KEY (id_pedido, id_producto)
);

/*
DELETE FROM Incompatibilidad;
DELETE FROM Contenido_Pedido;
DELETE FROM Pedido_Usuario;

DELETE FROM Producto;
ALTER SEQUENCE Producto_id_producto_seq RESTART WITH 1;

DELETE FROM Pedido;
ALTER SEQUENCE Pedido_id_pedido_seq RESTART WITH 1;

DELETE FROM Usuario;
ALTER SEQUENCE Usuario_id_usuario_seq RESTART WITH 1;*/