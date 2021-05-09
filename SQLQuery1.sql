use GD1C2021;
go

create schema ESTUDIANTES_CON_INSOMNIO;
go

create table ESTUDIANTES_CON_INSOMNIO.MemoriaRAM(
	codRAM varchar(255) not null primary key,
	tipo varchar(255) not null,
	capacidad varchar(255) not null,
	velocidad decimal(18,0) not null,
	fabricante varchar(255) not null
);

create table ESTUDIANTES_CON_INSOMNIO.Microprocesador(
	codMicroprocesador varchar(50) not null primary key,
	cache varchar(50) not null,
	cantHilos decimal(18,0) not null,
	velocidad varchar(50) not null,
	fabricante varchar(255) not null
);

create table ESTUDIANTES_CON_INSOMNIO.DiscoRigido(
	codDiscoRigido varchar(255) not null primary key,
	tipo varchar(255) not null,
	capacidad varchar(255) not null,
	velocidad varchar(255) not null,
	fabricante varchar(255) not null
);

create table ESTUDIANTES_CON_INSOMNIO.PlacaVideo(
	fabricantePlaca varchar(255) not null,
	modeloPlaca varchar(50) not null,
	chipset varchar(50) not null,
	velocidad varchar(50) not null,
	capacidad varchar(255) not null,
	primary key (fabricantePlaca, modeloPlaca)
);

create table ESTUDIANTES_CON_INSOMNIO.PC(
	idCodigoPC varchar(50) not null primary key,
	alto decimal(18,2) not null,
	ancho decimal(18,2) not null,
	profundidad decimal(18,2) not null,
	codRAM varchar(255) foreign key references ESTUDIANTES_CON_INSOMNIO.MemoriaRAM(codRAM),
	motherboard varchar(255) not null,
	codMicroprocesador varchar(50) foreign key references ESTUDIANTES_CON_INSOMNIO.Microprocesador(codMicroprocesador),
	fabricantePlaca varchar(255) not null,
	modeloPlaca varchar(50) not null,
	codDiscoRigido varchar(255) foreign key references ESTUDIANTES_CON_INSOMNIO.DiscoRigido(codDiscoRigido),
	nroSerie int not null,
	modeloGabinete varchar(255) not null,
	foreign key (fabricantePlaca, modeloPlaca) references ESTUDIANTES_CON_INSOMNIO.PlacaVideo(fabricantePlaca, modeloPlaca)
);

create table ESTUDIANTES_CON_INSOMNIO.Sucursal(
	ciudad varchar(255) not null,
	idSucursal decimal(18,0) not null identity(1,1) primary key,
	telefono decimal(18,0) not null,
	mail varchar(255) not null,
	direccion varchar(255) not null
);

create table ESTUDIANTES_CON_INSOMNIO.Cliente(
	idCliente decimal(18,0) not null identity(1,1) primary key,
	apellido varchar(255),
	nombre varchar(255),
	dni decimal(18,0),
	direccion varchar(255),
	mail varchar(255),
	telefono int,
	fechaNacimiento datetime2(3)
);

create table ESTUDIANTES_CON_INSOMNIO.Factura(
	idFactura decimal(18,0) not null identity(1,1) primary key,
	idSucursal decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Sucursal(idSucursal),
	fechaFacturacion datetime2(3) not null,
	precio decimal(18,2) not null,
	idCliente decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Cliente(idCliente)
);

create table ESTUDIANTES_CON_INSOMNIO.Compra(
	idCompra decimal(18,0) not null identity(1,1) primary key,
	idSucursal decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Sucursal(idSucursal),
	fechaCompra datetime2(3) not null,
	precio decimal(18,2) not null
);

create table ESTUDIANTES_CON_INSOMNIO.Accesorio(
	codAccesorio decimal(18,0) not null identity(1,1) primary key,
	descripcion varchar(255) not null,
	fabricante varchar(255) not null
);

create table ESTUDIANTES_CON_INSOMNIO.ItemCompra(
	idItemCompra decimal(18,0) not null identity(1,1) primary key,
	idCompra decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Compra(idCompra),
	idCodigoPc varchar(50) foreign key references ESTUDIANTES_CON_INSOMNIO.PC(idCodigoPC),
	codAccesorio decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Accesorio(codAccesorio),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

create table ESTUDIANTES_CON_INSOMNIO.ItemFactura(
	idItemFactura decimal(18,0) not null identity(1,1) primary key,
	idFactura decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Factura(idFactura),
	idCodigoPc varchar(50) foreign key references ESTUDIANTES_CON_INSOMNIO.PC(idCodigoPC),
	codAccesorio decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Accesorio(codAccesorio),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

set identity_insert ESTUDIANTES_CON_INSOMNIO.MemoriaRAM on;
insert into ESTUDIANTES_CON_INSOMNIO.MemoriaRAM (codRAM, tipo, capacidad, velocidad, fabricante)
	select MEMORIA_RAM_CODIGO codRAM, MEMORIA_RAM_TIPO tipo, MEMORIA_RAM_CAPACIDAD capacidad, MEMORIA_RAM_VELOCIDAD velocidad, MEMORIA_RAM_FABRICANTE fabricante
	from gd_esquema.Maestra
	where MEMORIA_RAM_CODIGO is not null
	order by MEMORIA_RAM_CODIGO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.MemoriaRAM off;

set identity_insert ESTUDIANTES_CON_INSOMNIO.Microprocesador on;
insert into ESTUDIANTES_CON_INSOMNIO.Microprocesador (codMicroprocesador, cache, cantHilos, velocidad, fabricante)
	select MICROPROCESADOR_CODIGO codMicroprocesador, MICROPROCESADOR_CACHE cache, MICROPROCESADOR_CANT_HILOS cantHilos, MICROPROCESADOR_VELOCIDAD velocidad, MICROPROCESADOR_FABRICANTE fabricante
	from gd_esquema.Maestra
	where MICROPROCESADOR_CODIGO is not null
	order by MICROPROCESADOR_CODIGO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.Microprocesador off;

set identity_insert ESTUDIANTES_CON_INSOMNIO.PlacaVideo on;
insert into ESTUDIANTES_CON_INSOMNIO.PlacaVideo (fabricantePlaca, modeloPlaca, chipset, velocidad, capacidad)
	select PLACA_VIDEO_FABRICANTE fabricantePlaca, PLACA_VIDEO_MODELO modeloPlaca, PLACA_VIDEO_CHIPSET chipset, PLACA_VIDEO_VELOCIDAD velocidad, PLACA_VIDEO_CAPACIDAD capacidad
	from gd_esquema.Maestra
	where PLACA_VIDEO_FABRICANTE is not null and PLACA_VIDEO_MODELO is not null
	order by PLACA_VIDEO_FABRICANTE, PLACA_VIDEO_MODELO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.PlacaVideo off;

set identity_insert ESTUDIANTES_CON_INSOMNIO.DiscoRigido on;
insert into ESTUDIANTES_CON_INSOMNIO.DiscoRigido (codDiscoRigido, tipo, capacidad, velocidad, fabricante)
	select DISCO_RIGIDO_CODIGO codDiscoRigido, DISCO_RIGIDO_TIPO tipo, DISCO_RIGIDO_CAPACIDAD capacidad, DISCO_RIGIDO_VELOCIDAD velocidad, DISCO_RIGIDO_FABRICANTE fabricante
	from gd_esquema.Maestra
	where DISCO_RIGIDO_CODIGO is not null
	order by DISCO_RIGIDO_CODIGO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.DiscoRigido off;

set identity_insert ESTUDIANTES_CON_INSOMNIO.PC on;
insert into ESTUDIANTES_CON_INSOMNIO.PC(idCodigoPC, alto, ancho, profundidad, codRAM, motherboard, codMicroprocesador, fabricantePlaca, modeloPlaca, codDiscoRigido, nroSerie, modeloGabinete)
	select PC_CODIGO idCodigoPC, PC_ALTO alto, PC_ANCHO ancho, PC_PROFUNDIDAD profundidad, MEMORIA_RAM_CODIGO codRAM, MICROPROCESADOR_CODIGO codMicroprocesador, PLACA_VIDEO_FABRICANTE fabricantePlaca, PLACA_VIDEO_MODELO modeloPlaca, DISCO_RIGIDO_CODIGO codDiscoRigido
	from gd_esquema.Maestra
	where PC_CODIGO is not null
	order by PC_CODIGO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.PC off;

insert into ESTUDIANTES_CON_INSOMNIO.Sucursal(ciudad, telefono, mail, direccion)
	select SUCURSAL_DIR direccion, SUCURSAL_MAIL mail, SUCURSAL_TEL telefono, CIUDAD ciudad
	from gd_esquema.Maestra;

insert into ESTUDIANTES_CON_INSOMNIO.Cliente(apellido, nombre, dni, direccion, mail, telefono, fechaNacimiento)
	select CLIENTE_DNI dni, CLIENTE_NOMBRE nombre, CLIENTE_APELLIDO apellido, CLIENTE_DIRECCION direccion, CLIENTE_FECHA_NACIMIENTO fechaNacimiento, CLIENTE_MAIL mail, CLIENTE_TELEFONO telefono
	from gd_esquema.Maestra;

set identity_insert ESTUDIANTES_CON_INSOMNIO.Factura on;
insert into ESTUDIANTES_CON_INSOMNIO.Factura(idFactura, idSucursal, fechaFacturacion, precio, idCliente)
	select FACTURA_NUMERO idFactura, FACTURA_FECHA fechaFacturacion
	from gd_esquema.Maestra
	where FACTURA_NUMERO is not null
	order by FACTURA_NUMERO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.Factura off;

set identity_insert ESTUDIANTES_CON_INSOMNIO.Compra on;
insert into ESTUDIANTES_CON_INSOMNIO.Compra(idCompra, idSucursal, fechaCompra, precio)
	select COMPRA_NUMERO idCompra, COMPRA_FECHA fechaCompra, COMPRA_PRECIO precio
	from gd_esquema.Maestra
	where COMPRA_NUMERO is not null
	order by COMPRA_NUMERO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.Compra off;

set identity_insert ESTUDIANTES_CON_INSOMNIO.Accesorio on;
insert into ESTUDIANTES_CON_INSOMNIO.Accesorio(codAccesorio, descripcion, fabricante)
	select ACCESORIO_CODIGO codAccesorio, AC_DESCRIPCION descripcion
	from gd_esquema.Maestra
	where ACCESORIO_CODIGO is not null
	order by ACCESORIO_CODIGO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.Accesorio off;

set identity_insert ESTUDIANTES_CON_INSOMNIO.ItemCompra on;
insert into ESTUDIANTES_CON_INSOMNIO.ItemCompra(idItemCompra, idCompra, idCodigoPc, codAccesorio, cantidad, precio)
	select ACCESORIO_CODIGO codAccesorio, AC_DESCRIPCION descripcion
	from gd_esquema.Maestra
	where ACCESORIO_CODIGO is not null
	order by ACCESORIO_CODIGO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.ItemCompra off;