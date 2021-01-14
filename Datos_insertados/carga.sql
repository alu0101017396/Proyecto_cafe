
insert into Tarjeta_de_puntos (Puntos) values (100);
insert into Tarjeta_de_puntos (Puntos) values (230);
insert into Tarjeta_de_puntos (Puntos) values (69);
insert into Tarjeta_de_puntos (Puntos) values (720);

-- select * from Tarjeta_de_puntos;
-- /// Inserciones Clientes
-- describe Cliente;
insert into Cliente(DNI,Nombre,Telefono,Direccion,Fecha_de_nacimiento,Descuento,ID_Tarjeta) values ("12345678A","Enrique M Pedroza",684145933,"Calle el suspenso",'1996-12-22',0,1);
insert into Cliente(DNI,Nombre,Telefono,Direccion,Fecha_de_nacimiento,Descuento,ID_Tarjeta) values ("12165678A","Cristian Rodriguez",684176933,"Calle GG ez ",'2000-10-01',0,2);
insert into Cliente(DNI,Nombre,Telefono,Direccion,Fecha_de_nacimiento,Descuento,ID_Tarjeta) values ("12234678A","Francisco uwu",634545933,"Calle lemmon squezy",'1999-05-13',0,3);
insert into Cliente(DNI,Nombre,Telefono,Direccion,Fecha_de_nacimiento,Descuento,ID_Tarjeta) values ("12344678A","Alberto owo",684177933,"Calle git gud",'1980-03-03',0,4);
-- select * from Cliente;
-- //// Inserciones Ingredientes

-- describe Ingredientes;

insert into Ingredientes (Nombre,Alergeno,Tipo) values ("cerveza","Gluten","Bebida");
insert into Ingredientes (Nombre,Alergeno,Tipo) values ("huevo",NULL,"Constructor");
insert into Ingredientes (Nombre,Alergeno,Tipo)values ("Pan","Gluten","Harinas");
insert into Ingredientes (Nombre,Alergeno,Tipo)values ("Tomate",NULL,"Verdura");
insert into Ingredientes (Nombre,Alergeno,Tipo)values ("Queso","Lactosa","Lacteo");
insert into Ingredientes (Nombre,Alergeno,Tipo)values ("Carne de res",NULL,"Carnes");
insert into Ingredientes (Nombre,Alergeno,Tipo)values ("Salsa de atun",NULL,"Salsa");
insert into Ingredientes (Nombre,Alergeno,Tipo)values ("Penne","Gluten","Pasta");
insert into Ingredientes (Nombre,Alergeno,Tipo)values ("Papa frita","Gluten","Tuberculo");
insert into Ingredientes (Nombre,Alergeno,Tipo)values ("Expresso",NULL,"Cafe");
insert into Ingredientes (Nombre,Alergeno,Tipo)values ("Manzanilla",NULL,"Te");

-- select * from Ingredientes;


-- describe Plato;

insert into Plato(Nombre,Precio,Alergenos) values ("Cerveza x5",5.0,"Gluten");
insert into Plato(Nombre,Precio,Alergenos) values ("Hamburguesa",4.5,"Lactosa");
insert into Plato(Nombre,Precio,Alergenos) values ("Hamburguesa combo",8,"Gluten,Lactosa");
insert into Plato(Nombre,Precio,Alergenos) values ("Pasta con salsa de atun",6,"Gluten");
-- select * from Plato;


-- describe Plato_Ingrediente;

insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(1,1,5);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(2,2,2);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(2,3,2);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(2,4,1);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(2,5,1);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(2,6,1);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(3,1,1);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(3,2,2);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(3,3,2);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(3,4,1);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(3,5,1);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(3,6,1);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(3,9,1);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(4,7,1);
insert into Plato_Ingrediente (ID_Plato,ID_Ingrediente,Cantidad) values(4,8,1);

-- select * from Plato_Ingrediente;



-- describe Pedido;

insert into Pedido (ID_Plato,Cantidad) values (1,1);
insert into Pedido (ID_Plato,Cantidad) values (1,1);
insert into Pedido (ID_Plato,Cantidad) values (3,1);
insert into Pedido (ID_Plato,Cantidad) values (4,1);
insert into Pedido (ID_Plato,Cantidad) values (4,1);



-- -- -- describe Personal;

insert into Personal (DNI,Nombre,Tarjeta_electronico,Fecha_de_nacimiento,Tipo,Hora_entrada,Hora_salida)values("1111111A","Paco",1,'1999-01-01',"Camarero",'09:00:00','16:00:00');
insert into Personal (DNI,Nombre,Tarjeta_electronico,Fecha_de_nacimiento,Tipo,Hora_entrada,Hora_salida)values("22222222B","Maria",2,'1998-03-22',"Camarero",'16:00:00','21:00:00');
insert into Personal (DNI,Nombre,Tarjeta_electronico,Fecha_de_nacimiento,Tipo,Hora_entrada,Hora_salida)values("33333333C","Vanesa",3,'2000-05-23',"Gerente",'09:00:00','21:00:00');
insert into Personal (DNI,Nombre,Tarjeta_electronico,Fecha_de_nacimiento,Tipo,Hora_entrada,Hora_salida)values("44444444D","Javier",4,'1999-01-01',"Cocinero",'09:00:00','21:00:00');


insert into Personal (DNI,Nombre,Tarjeta_electronico,Fecha_de_nacimiento,Tipo,Hora_entrada,Hora_salida)values("55555555E","Leornardo",5,'2005-03-28',"Gerente","9:00:00","22:00:00");
insert into Personal (DNI,Nombre,Tarjeta_electronico,Fecha_de_nacimiento,Tipo,Hora_entrada,Hora_salida)values("66666666F","Diana",6,"1997-06-06","Camarero","9:00:00","22:00:00");
insert into Personal (DNI,Nombre,Tarjeta_electronico,Fecha_de_nacimiento,Tipo,Hora_entrada,Hora_salida)values("77777777G","Diego",7,"1990-03-27","Cocinero","9:00:00","22:00:00");

-- -- -- select * from Personal;

-- -- -- describe Establecimiento;

insert into Establecimiento (Nombre,Gerente,Direccion)values("C.A.F.E La Laguna","33333333C","Calle Herradores");
insert into Establecimiento (Nombre,Gerente,Direccion)values("C.A.F.E Santa Cruz","55555555E","Tres de Mayo");

-- -- -- describe Establecimiento_Personal;
insert into Establecimiento_Personal(Nombre_Establecimiento,ID_Personal) values ("C.A.F.E La Laguna","1111111A");
insert into Establecimiento_Personal(Nombre_Establecimiento,ID_Personal) values ("C.A.F.E La Laguna","22222222B");
insert into Establecimiento_Personal(Nombre_Establecimiento,ID_Personal) values ("C.A.F.E La Laguna","33333333C");
insert into Establecimiento_Personal(Nombre_Establecimiento,ID_Personal) values ("C.A.F.E La Laguna","44444444D");
insert into Establecimiento_Personal(Nombre_Establecimiento,ID_Personal) values ("C.A.F.E Santa Cruz","55555555E");
insert into Establecimiento_Personal(Nombre_Establecimiento,ID_Personal) values ("C.A.F.E Santa Cruz","66666666F");
insert into Establecimiento_Personal(Nombre_Establecimiento,ID_Personal) values ("C.A.F.E Santa Cruz","77777777G");



insert into Cobro (Tipo,Precio,Rebajado,ID_Cliente,Nombre_Establecimiento,ID_Pedido) values ("Local",NULL,NULL,"12345678A","C.A.F.E La Laguna",1);
insert into Cobro (Tipo,Precio,Rebajado,ID_Cliente,Nombre_Establecimiento,ID_Pedido) values ("Local",NULL,NULL,"12345678A","C.A.F.E La Laguna",1);
insert into Cobro (Tipo,Precio,Rebajado,ID_Cliente,Nombre_Establecimiento,ID_Pedido)values("Domicilio",NULL,NULL,"12234678A","C.A.F.E Santa Cruz",3);
insert into Cobro (Tipo,Precio,Rebajado,ID_Cliente,Nombre_Establecimiento,ID_Pedido)values("Domicilio",NULL,NULL,"12165678A","C.A.F.E La Laguna",4);
insert into Cobro (Tipo,Precio,Rebajado,ID_Cliente,Nombre_Establecimiento,ID_Pedido)values("Local",NULL,NULL,"12344678A","C.A.F.E Santa Cruz",5);


-- -- -- select * from Establecimiento_Personal;

-- -- -- show tables;

-- -- describe Opinion;

insert into Opinion (Nombre_Establecimiento,ID_Cliente_o,Valoracion,Comentario_opinion) values ("C.A.F.E La Laguna","12345678A",4,"Las cervezas estan muy buenas");
insert into Opinion (Nombre_Establecimiento,ID_Cliente_o,Valoracion) values ("C.A.F.E La Laguna","12165678A",3);
insert into Opinion (Nombre_Establecimiento,ID_Cliente_o,Valoracion,Comentario_opinion) values ("C.A.F.E Santa Cruz","12234678A",4,"La proxima pillo pasta");

-- -- -- select * from Opinion;

-- -- describe Reclamaciones;
insert into Reclamaciones (Nombre_Establecimiento,ID_Cliente_r,Encargado,Comentario_reclamacion) values ("C.A.F.E Santa Cruz","12344678A","55555555E","Hay mucha pasta en mi pasta");



-- -- describe Establecimiento_Plato;

insert into Establecimiento_Plato (ID_Establecimiento,ID_Plato) values ("C.A.F.E La Laguna",1);
insert into Establecimiento_Plato (ID_Establecimiento,ID_Plato) values ("C.A.F.E La Laguna",2);
insert into Establecimiento_Plato (ID_Establecimiento,ID_Plato) values ("C.A.F.E La Laguna",3);
insert into Establecimiento_Plato (ID_Establecimiento,ID_Plato) values ("C.A.F.E La Laguna",4);

insert into Establecimiento_Plato (ID_Establecimiento,ID_Plato) values ("C.A.F.E Santa Cruz",1);
insert into Establecimiento_Plato (ID_Establecimiento,ID_Plato) values ("C.A.F.E Santa Cruz",2);
insert into Establecimiento_Plato (ID_Establecimiento,ID_Plato) values ("C.A.F.E Santa Cruz",4);


-- -- describe Stock;

insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E La Laguna",1,20000);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E La Laguna",2,12800);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E La Laguna",3,288);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E La Laguna",4,243);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E La Laguna",5,500);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E La Laguna",6,670);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E La Laguna",7,77);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E La Laguna",8,3);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E La Laguna",9,17);


insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E Santa Cruz",1,20);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E Santa Cruz",2,260);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E Santa Cruz",3,24560);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E Santa Cruz",4,22340);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E Santa Cruz",5,25230);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E Santa Cruz",6,2320);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E Santa Cruz",8,120);
insert into Stock (Nombre_Establecimiento_stock,ID_Ingrediente_stock,Cantidad) values ("C.A.F.E Santa Cruz",9,340);


-- -- describe Objeto;

insert into Objeto (Nombre) values ("Platos");
insert into Objeto (Nombre) values ("Bandejas");
insert into Objeto (Nombre) values ("Vasos");
insert into Objeto (Nombre) values ("Servilletas");

-- -- describe Inventario;

insert into Inventario(Nombre_Establecimiento_Inventario,ID_objeto,Cantidad) values ("C.A.F.E La Laguna",1,300);
insert into Inventario(Nombre_Establecimiento_Inventario,ID_objeto,Cantidad) values ("C.A.F.E La Laguna",2,80);
insert into Inventario(Nombre_Establecimiento_Inventario,ID_objeto,Cantidad) values ("C.A.F.E La Laguna",3,427);
insert into Inventario(Nombre_Establecimiento_Inventario,ID_objeto,Cantidad) values ("C.A.F.E La Laguna",4,4000);

insert into Inventario(Nombre_Establecimiento_Inventario,ID_objeto,Cantidad) values ("C.A.F.E Santa Cruz",1,276);
insert into Inventario(Nombre_Establecimiento_Inventario,ID_objeto,Cantidad) values ("C.A.F.E Santa Cruz",2,44);
insert into Inventario(Nombre_Establecimiento_Inventario,ID_objeto,Cantidad) values ("C.A.F.E Santa Cruz",3,3);
insert into Inventario(Nombre_Establecimiento_Inventario,ID_objeto,Cantidad) values ("C.A.F.E Santa Cruz",4,0);


-- -- select * from Inventario;

-- -- describe Compras;


insert into Compras(Item,Tipo,Cantidad,Nombre_est) values (4,"I",100,"C.A.F.E Santa Cruz");
insert into Compras(Item,Tipo,Cantidad,Nombre_est) values (3,"I",100,"C.A.F.E Santa Cruz");
insert into Compras(Item,Tipo,Cantidad,Nombre_est) values (2,"I",20,"C.A.F.E La Laguna");
insert into Compras(Item,Tipo,Cantidad,Nombre_est) values (1,"I",50,"C.A.F.E La Laguna");

insert into Compras(Item,Tipo,Cantidad,Nombre_est) values (1,"S",1000,"C.A.F.E Santa Cruz");
insert into Compras(Item,Tipo,Cantidad,Nombre_est) values (8,"S",1200,"C.A.F.E Santa Cruz");




