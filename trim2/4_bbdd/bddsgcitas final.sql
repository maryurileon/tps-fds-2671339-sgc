-- crear base de datos
create database bdsgcitas;

-- usar base de datos
use bdsgcitas;

-- crear tabla roles
	create table roles(
	IdRol int not null auto_increment primary key,
	Nombre varchar(100) not null
	);

-- usar tabla roles
select * from usuarios;

-- crear tabla usuarios
	create table usuarios(
    id_usuarios int not null auto_increment primary key,
    Nombre_usuarios varchar(100) not null,
    Apellido_usuarios varchar(100) not null,
    IdRol int,
    constraint fk_id_usuarios
    foreign key (IdRol)
    references roles (IdRol) 
    on delete cascade
    on update cascade
);

-- crear tabla credenciales
	create table credenciales(
    correo_credenciales varchar(100) not null primary key,
    contraseña_credenciales varchar(100) not null,
    id_usuarios int, 
        constraint fk_id_credenciales
    foreign key (id_usuarios)	
    references usuarios (id_usuarios) 
    on delete cascade
    on update cascade
    );
    
-- editar tabla usuarios 

-- agregar correo
alter table usuarios add column correo VARCHAR(100) not null;

-- agregar contraseña
alter table usuarios add column contraseña VARCHAR(100) not null;

-- eliminar tabla credenciales 
drop table credenciales;

-- crear tabla administrador
	create table administrador( 
    id_administrador int not null auto_increment primary key,
    id_usuarios int, 
        constraint fk_id_administrador
    foreign key (id_usuarios)	
    references usuarios (id_usuarios) 
    on delete cascade
    on update cascade
);

-- crear tabla cliente
	create table cliente( 
    id_cliente int not null auto_increment primary key,
    id_usuarios int, 
        constraint fk_id_cliente
    foreign key (id_usuarios)	
    references usuarios (id_usuarios) 
    on delete cascade
    on update cascade
);

-- crear tabla empleado
	create table empleado( 
    id_empleado int not null auto_increment primary key,
    id_usuarios int, 
        constraint fk_id_empleado
    foreign key (id_usuarios)	
    references usuarios (id_usuarios) 
    on delete cascade
    on update cascade
);

-- crear tabla citas
	create table citas(
    id_citas int not null auto_increment primary key,
    fecha_citas datetime not null,
    hora_citas time not null,
    id_cliente int,
    constraint fk_id_citas
    foreign key (id_cliente)
    references cliente (id_cliente) 
    on delete cascade
    on update cascade
);
-- eliminar columna hora_citas
alter table citas drop column hora_citas;

-- crear tabla servicios
	create table servicios(
    id_servicios int not null auto_increment primary key,
    Nombre_servicios varchar(100) not null,
    precio_servicios decimal (11, 2) not null,
    id_citas int,
    constraint fk_id_servicios
    foreign key (id_citas)
    references citas (id_citas) 
    on delete cascade
    on update cascade
);

-- crear tabla pedidos
	create table pedidos(
    id_pedidos int not null auto_increment primary key,
    fecha_pedidos datetime not null,
    id_cliente int,
    constraint fk_id_pedidos
    foreign key (id_cliente)
    references cliente (id_cliente), 
    -- 
        id_servicios int,
    constraint fk_id_pedidos2
    foreign key (id_servicios)
    references servicios (id_servicios) 
    --
    on delete cascade
    on update cascade
);

ALTER TABLE pedidos DROP FOREIGN KEY fk_id_pedidos2;


alter table servicios add constraint fk_id_pedidos5 foreign key (id_pedidos) references pedidos (id_pedidos);

-- crear tabla productos
	create table productos(
    id_productos int not null auto_increment primary key,
    Nombre_productos varchar(100) not null,
    unidades_productos int not null,
    precio_productos decimal (11, 2) not null,
    id_administrador int,
    constraint fk_id_productos
    foreign key (id_administrador)
    references administrador (id_administrador), 
    -- 
	id_pedidos int,
    constraint fk_id_productos2
    foreign key (id_pedidos)
    references pedidos (id_pedidos) 
    --
    on delete cascade
    on update cascade
);

-- agregar relación entre empleados y citas
alter table citas add column id_empleado int,
add constraint fk_citas_empleados3 foreign key (id_empleado) references empleado (id_empleado);
alter table citas add constraint fk_citas_empleados3 foreign key (id_empleado) references empleado (id_empleado);
select * from citas;

-- crear tabla factura
	create table factura(
    id_factura int not null auto_increment primary key,
    totalprecio_factura decimal (11, 2) not null,
    totalproductos_factura int not null,
    id_pedidos int,
    constraint fk_id_factura5
    foreign key (id_pedidos)
    references pedidos (id_pedidos)
    on delete cascade
    on update cascade
);

-- crear tabla pagos
	create table pagos(
    id_pagos int not null auto_increment primary key,
    comisiones decimal (11, 2) not null,
    id_administrador int,
    constraint fk_id_pagos
    foreign key (id_administrador)
    references administrador (id_administrador), 
    -- 
	id_factura int,
    constraint fk_id_pago
    foreign key (id_factura)
    references factura (id_factura),
    --
	id_empleado int,
    constraint fk_id_pagos3
    foreign key (id_empleado)
    references empleado (id_empleado) 
    
    on delete cascade
    on update cascade
);

-- agregar datos tabla roles
insert into roles (Nombre) values 
('Adminitrador'),
('empleado'),
('cliente');

-- agregar datos tabla  usuarios
insert into usuarios (Nombre_usuarios, Apellido_usuarios, correo, contraseña) values 
('Felipe', 'Arjona','felipealejandro26@gmail.com', 'pipepipe26'),
('Mariana', 'Perez','marianafernanda21@gmail.com', 'mari21#'),
('Clare', 'Bradshaw','felipealejandro26@gmail.com', 'GBQ78DGT2MB'),
('Leigh', 'Erickson','quis.accumsan@icloud.edu', 'TRT56LFN1TN'),
('Kato', 'Hill','nisl.elementum.purus@aol.com', 'ZIL38TXR0GB'),
('Ruth', 'Wheeler','sollicitudin.orci.sem@protonmail.ca', 'TQH55HVQ2XX'),
('Baxter', 'Norman', 'ultricies.ligula@icloud.org', 'OVU44JKH7BD'),
('Ori', 'Gomez','neque@yahoo.net', 'ULL07JWK5PN'),
('Cullen', 'Carrillo','nam.tempor@outlook.edu', 'PDJ06SWF1GG'),
('Ralph', 'Graham','duis.risus@icloud.couk', 'CQB80RAP1HD');
select * from roles;

-- agregar datos tabla citas
insert into citas (fecha_citas) values (current_timestamp());

-- eliminar datos citas
delete from citas where id_citas = 1;

select * from productos;

-- agregar datos tabla  servicios
insert into servicios (Nombre_servicios, precio_servicios) values 
('Afeitado completo', '28000'),
('Alisado de cabello', '35000'),
('Barba tradicional', '30000'),
('Barba con vapor ozono', '40000'),
('Barba de lujo', '60000'),
('Color para barba', '30000'),
('Color para Cabello', '65000'),
('Lavado de Cabello', '8000'),
('Enjuague de Cabello sin Shampoo', '65000'),
('Lavado de Cabello + 1 Proceso (color, matizante, canas o keratina)', '13000');

-- eliminar datos servicios
delete from servicios where id_servicios = 1;

-- agregar datos tabla pedidos
insert into pedidos (fecha_pedidos) values (current_timestamp());
select * from comisión;


-- agregar datos tabla  productos
insert into productos (Nombre_productos, unidades_productos, precio_productos) values 
('tijeras','20', '17000'),
('cuchillas largas','100', '12000'),
('peines','15', '2700'),
('shampoo','25', '30000'),
('acondicionador','25', '30000'),
('tratamiento','25', '30000'),
('esmalte','100', '3000'),
('cera','10', '5000'),
('gel','10', '15000'),
('limas','30', '3000');

-- agregar datos tabla  comisión
insert into comisión (comisiones) values 
('20000'),
('40000'),
('25000'),
('35000'),
('15000'),
('20000'),
('10000'),
('72000'),
('40000'),
('15000');

    FOREIGN KEY (id_empleado)
    REFERENCES empleado (id_empleado)
    ON DELETE CASCADE
    ON UPDATE CASCADE

-- crear tabla salario
create table salario (
IdSalario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_empleado INT,
CONSTRAINT fk_id_salario
    FOREIGN KEY (id_empleado)
    REFERENCES empleado (id_empleado)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    )    

-- agregar datos tabla factura
insert into factura (totalprecio_factura, totalproductos_factura) values 
('40000', '2'),
('80000', '6'),
('50000', '4'),
('70000', '2'),
('30000', '4'),
('40000', '6'),
('20000', '1'),
('144000', '9'),
('80000', '5'),
('30000', '2');
    
rename table pagos to  comisión; 
    
select * from pedidos;


    