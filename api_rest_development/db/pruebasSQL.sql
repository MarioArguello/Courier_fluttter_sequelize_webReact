select * from unidad;
select * from persona;
select * from grado;
select * from reparto;
select * from usuario;
select * from usuarioreparto; 
select * from usuariorol;
select * from rol;
select * from comedor;
select * from menu;
select * from tiporancho;
select * from menudia;
select * from reserva;

select g.nombrecorto as grado, p.nombres, r.nombre, u.codigo 
from dar.personas p, dar.repartos r, dar.unidades u, DAR.grados g 
where p.idreparto 	= r.idreparto and r.idunidad = u.idunidad and p.idgrado  = g.idgrado 

delete from unidad 
 where idunidad =1;

INSERT INTO persona (idreparto, idgrado, nombres, telefono , correo, sexo, dni, estado, utc) 
	VALUES (1, 2, 'Abdon', '0978723132', 'abdon@gail.com', 'M', '1316166372', 'F', '2021/12/02');

INSERT INTO grado (nombre, nombrecorto, utc) 
	VALUES ('Subteniente', 'subt', '2008/12/31');
	
INSERT INTO unidad (utc, nombre, codigo) 
	VALUES ('2021/12/02', 'Base Aerea Simon Bolivar', 'f001');

INSERT INTO reparto (idunidad, utc, nombre, codigo) 
	VALUES ('2', '2021/12/02', 'COAD', 'f001');

INSERT INTO usuario (idpersona, username, "password", estado, utc) 
	VALUES (1, 'abdon123', 'Pablono30', 'F', '2021/12/02');

INSERT INTO usuarioreparto (idusuario, idreparto, utc) 
	VALUES (1, 1, '2021/12/02');
	
INSERT INTO rol (nombre, estado, utc) 
	VALUES ('administrador', 'F', '2008/12/31');
	
INSERT INTO usuariorol (idusuario, idrol, estado, utc) 
	VALUES (1, 1, 'f', '2008/12/31');
	
INSERT INTO rol (nombre, estado, utc) 
	VALUES ('administrador', 'F', '2008/12/31');
	
INSERT INTO comedor (idreparto, nombre, estado, utc) 
	VALUES (1, 'Comedor ala 22 aereo tecnicos', 'F','2008/12/31');
	
INSERT INTO menu (descripcion, utc) 
	VALUES ('Caldo de gallina', '2008/12/31');
	
INSERT INTO tiporancho (nombre, estado, utc) 
	VALUES ('desayuno', 'F', '2008/12/31');

INSERT INTO menudia (idtiporancho, idmenu, idcomedor, fecha, precio, estado, utc) 
	VALUES (1, 1, 1, '2008/12/31', 2.00, 'F', '2008/12/31');
	
INSERT INTO reserva (idmenudia, idpersona, estado, cantidad, utc) 
	VALUES (1, 1, 'F', 1, '2008/12/31');


