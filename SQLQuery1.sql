use GD1C2021;
go

create schema ESTUDIANTES_CON_INSOMNIO;
go

create table ESTUDIANTES_CON_INSOMNIO.Fabricante(
	idFabricante varchar(255) not null primary key,
	telefono decimal(18,0)
);

create table ESTUDIANTES_CON_INSOMNIO.MemoriaRAM(
	codRAM varchar(255) not null primary key,
	tipo varchar(255) not null,
	capacidad varchar(255) not null,
	velocidad varchar(255) not null,
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante)
);

create table ESTUDIANTES_CON_INSOMNIO.Microprocesador(
	codMicroprocesador varchar(50) not null primary key,
	cache varchar(50) not null,
	cantHilos decimal(18,0) not null,
	velocidad varchar(50) not null,
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante)
);

create table ESTUDIANTES_CON_INSOMNIO.DiscoRigido(
	codDiscoRigido varchar(255) not null primary key,
	tipo varchar(255) not null,
	capacidad varchar(255) not null,
	velocidad varchar(255) not null,
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante)
);

create table ESTUDIANTES_CON_INSOMNIO.PlacaVideo(
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante),
	modeloPlaca varchar(50) not null,
	chipset varchar(50) not null,
	velocidad varchar(50) not null,
	capacidad varchar(255) not null,
	primary key (idFabricante, modeloPlaca)
);

create table ESTUDIANTES_CON_INSOMNIO.PC(
	idCodigoPC varchar(50) not null primary key,
	alto decimal(18,2) not null,
	ancho decimal(18,2) not null,
	profundidad decimal(18,2) not null,
	codRAM varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.MemoriaRAM(codRAM),
	motherboard varchar(255),
	codMicroprocesador varchar(50) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Microprocesador(codMicroprocesador),
	idFabricante varchar(255) not null,
	modeloPlaca varchar(50) not null,
	codDiscoRigido varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.DiscoRigido(codDiscoRigido),
	nroSerie int,
	modeloGabinete varchar(255),
	foreign key (idFabricante, modeloPlaca) references ESTUDIANTES_CON_INSOMNIO.PlacaVideo(idFabricante, modeloPlaca)
);

create table ESTUDIANTES_CON_INSOMNIO.Sucursal(
	ciudadSucursal varchar(255) not null,
	telefono decimal(18,0) not null,
	mail varchar(255) not null,
	direccionSucursal varchar(255) not null,
	primary key (direccionSucursal, ciudadSucursal)
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
	direccionSucursal varchar(255) not null,
	ciudadSucursal varchar(255) not null,
	fechaFacturacion datetime2(3) not null,
	precio decimal(18,2) not null,
	idCliente decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Cliente(idCliente),
	foreign key (direccionSucursal, ciudadSucursal) references ESTUDIANTES_CON_INSOMNIO.Sucursal(direccionSucursal, ciudadSucursal)
);

create table ESTUDIANTES_CON_INSOMNIO.Compra(
	idCompra decimal(18,0) not null identity(1,1) primary key,
	ciudadSucursal varchar(255) not null,
	direccionSucursal varchar(255) not null,
	fechaCompra datetime2(3) not null,
	precio decimal(18,2) not null,
	foreign key (direccionSucursal, ciudadSucursal) references ESTUDIANTES_CON_INSOMNIO.Sucursal(direccionSucursal, ciudadSucursal)
);

create table ESTUDIANTES_CON_INSOMNIO.Accesorio(
	codAccesorio decimal(18,0) not null identity(1,1) primary key,
	descripcion varchar(255) not null
	--idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante),
);

create table ESTUDIANTES_CON_INSOMNIO.ItemAccesorio(
	idItemAccesorio decimal(18,0) not null identity(1,1) primary key,
	idFactura decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Factura(idFactura),
	codAccesorio decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Accesorio(codAccesorio),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

create table ESTUDIANTES_CON_INSOMNIO.ItemPC(
	idItemPC decimal(18,0) not null identity(1,1) primary key,
	idFactura decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Compra(idCompra),
	idCodigoPc varchar(50) not null foreign key references ESTUDIANTES_CON_INSOMNIO.PC(idCodigoPC),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

create table ESTUDIANTES_CON_INSOMNIO.CompraAccesorio(
	idCompraAccesorio decimal(18,0) not null identity(1,1) primary key,
	idCompra decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Compra(idCompra),
	codAccesorio decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Accesorio(codAccesorio),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

create table ESTUDIANTES_CON_INSOMNIO.CompraPC(
	idCompraPC decimal(18,0) not null identity(1,1) primary key,
	idCompra decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Compra(idCompra),
	idCodigoPc varchar(50) not null foreign key references ESTUDIANTES_CON_INSOMNIO.PC(idCodigoPC),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

create index indiceFabricante on ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante);

create index indiceMemoriaRAM on ESTUDIANTES_CON_INSOMNIO.MemoriaRAM(codRAM);

create index indiceMicroprocesador on ESTUDIANTES_CON_INSOMNIO.Microprocesador(codMicroprocesador);

create index indiceDiscoRigido on ESTUDIANTES_CON_INSOMNIO.DiscoRigido(codDiscoRigido);

create index indicePlacaVideo on ESTUDIANTES_CON_INSOMNIO.PlacaVideo(idFabricante, modeloPlaca);

create index indicePC on ESTUDIANTES_CON_INSOMNIO.PC(idCodigoPC);

create index indiceSucursal on ESTUDIANTES_CON_INSOMNIO.Sucursal(direccionSucursal, ciudadSucursal);

create index indiceCliente on ESTUDIANTES_CON_INSOMNIO.Cliente(idCliente);

create index indiceFactura on ESTUDIANTES_CON_INSOMNIO.Factura(idFactura);

create index indiceCompra on ESTUDIANTES_CON_INSOMNIO.Compra(idCompra);

create index indiceAccesorio on ESTUDIANTES_CON_INSOMNIO.Accesorio(codAccesorio);

create index indiceItemAccesorio on ESTUDIANTES_CON_INSOMNIO.ItemAccesorio(idItemAccesorio);

create index indiceItemPC on ESTUDIANTES_CON_INSOMNIO.ItemPC(idItemPC);

create index indiceCompraAccesorio on ESTUDIANTES_CON_INSOMNIO.CompraAccesorio(idCompraAccesorio);

create index indiceCompraPC on ESTUDIANTES_CON_INSOMNIO.CompraPC(idCompraPC);

insert into ESTUDIANTES_CON_INSOMNIO.Fabricante (idFabricante)
	select  distinct DISCO_RIGIDO_FABRICANTE nombre
	from gd_esquema.Maestra
	where DISCO_RIGIDO_FABRICANTE is not null and not exists (select idFabricante from ESTUDIANTES_CON_INSOMNIO.Fabricante);
	
insert into ESTUDIANTES_CON_INSOMNIO.Fabricante (idFabricante)
	select  distinct MEMORIA_RAM_FABRICANTE idFabricante
	from gd_esquema.Maestra
	where MEMORIA_RAM_FABRICANTE is not null and not exists (select idFabricante from ESTUDIANTES_CON_INSOMNIO.Fabricante where Maestra.MEMORIA_RAM_FABRICANTE = idFabricante);

insert into ESTUDIANTES_CON_INSOMNIO.Fabricante (idFabricante)
	select  distinct MICROPROCESADOR_FABRICANTE idFabricante
	from gd_esquema.Maestra
	where MICROPROCESADOR_FABRICANTE is not null and not exists (select idFabricante from ESTUDIANTES_CON_INSOMNIO.Fabricante where Maestra.MICROPROCESADOR_FABRICANTE = idFabricante);

insert into ESTUDIANTES_CON_INSOMNIO.Fabricante (idFabricante)
	select  distinct PLACA_VIDEO_FABRICANTE idFabricante
	from gd_esquema.Maestra
	where PLACA_VIDEO_FABRICANTE is not null and not exists (select idFabricante from ESTUDIANTES_CON_INSOMNIO.Fabricante where Maestra.PLACA_VIDEO_FABRICANTE = idFabricante);

insert into ESTUDIANTES_CON_INSOMNIO.MemoriaRAM (codRAM, tipo, capacidad, velocidad, idFabricante)
	select distinct MEMORIA_RAM_CODIGO codRAM, MEMORIA_RAM_TIPO tipo, MEMORIA_RAM_CAPACIDAD capacidad, MEMORIA_RAM_VELOCIDAD velocidad, MEMORIA_RAM_FABRICANTE idFabricante
	from gd_esquema.Maestra Maestra 
	where MEMORIA_RAM_CODIGO is not null
	order by MEMORIA_RAM_CODIGO;

insert into ESTUDIANTES_CON_INSOMNIO.Microprocesador (codMicroprocesador, cache, cantHilos, velocidad, idFabricante)
	select distinct MICROPROCESADOR_CODIGO codMicroprocesador, MICROPROCESADOR_CACHE cache, MICROPROCESADOR_CANT_HILOS cantHilos, MICROPROCESADOR_VELOCIDAD velocidad, MICROPROCESADOR_FABRICANTE idFabricante
	from gd_esquema.Maestra Maestra
	where MICROPROCESADOR_CODIGO is not null
	order by MICROPROCESADOR_CODIGO;

insert into ESTUDIANTES_CON_INSOMNIO.PlacaVideo (modeloPlaca, chipset, velocidad, capacidad, idFabricante)
	select distinct PLACA_VIDEO_MODELO modeloPlaca, PLACA_VIDEO_CHIPSET chipset, PLACA_VIDEO_VELOCIDAD velocidad, PLACA_VIDEO_CAPACIDAD capacidad, PLACA_VIDEO_FABRICANTE idFabricante
	from gd_esquema.Maestra Maestra
	where PLACA_VIDEO_FABRICANTE is not null and PLACA_VIDEO_MODELO is not null;

insert into ESTUDIANTES_CON_INSOMNIO.DiscoRigido (codDiscoRigido, tipo, capacidad, velocidad, idFabricante)
	select distinct DISCO_RIGIDO_CODIGO codDiscoRigido, DISCO_RIGIDO_TIPO tipo, DISCO_RIGIDO_CAPACIDAD capacidad, DISCO_RIGIDO_VELOCIDAD velocidad, DISCO_RIGIDO_FABRICANTE idFabricante
	from gd_esquema.Maestra Maestra
	where DISCO_RIGIDO_CODIGO is not null
	order by DISCO_RIGIDO_CODIGO;
	
insert into ESTUDIANTES_CON_INSOMNIO.PC(idCodigoPC, alto, ancho, profundidad, codRAM, codMicroprocesador, idFabricante, modeloPlaca, codDiscoRigido)
	select distinct PC_CODIGO idCodigoPC, PC_ALTO alto, PC_ANCHO ancho, PC_PROFUNDIDAD profundidad, MEMORIA_RAM_CODIGO codRAM, MICROPROCESADOR_CODIGO codMicroprocesador, PLACA_VIDEO_FABRICANTE idFabricante, PLACA_VIDEO_MODELO modeloPlaca, DISCO_RIGIDO_CODIGO codDiscoRigido
	from gd_esquema.Maestra Maestra
	where PC_CODIGO is not null
	order by PC_CODIGO;

insert into ESTUDIANTES_CON_INSOMNIO.Sucursal(direccionSucursal, mail, telefono, ciudadSucursal)
	select distinct SUCURSAL_DIR direccionSucursal, SUCURSAL_MAIL mail, SUCURSAL_TEL telefono, CIUDAD ciudadSucursal
	from gd_esquema.Maestra;

insert into ESTUDIANTES_CON_INSOMNIO.Cliente(apellido, nombre, dni, direccion, mail, telefono, fechaNacimiento)
	select distinct CLIENTE_APELLIDO apellido, CLIENTE_NOMBRE nombre, CLIENTE_DNI dni, CLIENTE_DIRECCION direccion, CLIENTE_MAIL mail, CLIENTE_TELEFONO telefono, CLIENTE_FECHA_NACIMIENTO fechaNacimiento
	from gd_esquema.Maestra
	where CLIENTE_APELLIDO is not null and CLIENTE_NOMBRE is not null and CLIENTE_DNI is not null;

set identity_insert ESTUDIANTES_CON_INSOMNIO.Compra on;
insert into ESTUDIANTES_CON_INSOMNIO.Compra(idCompra, direccionSucursal, ciudadSucursal, fechaCompra, precio)
	select distinct COMPRA_NUMERO idCompra, SUCURSAL_DIR direccionSucursal, CIUDAD ciudadSucursal, COMPRA_FECHA fechaCompra, sum(COMPRA_PRECIO) precio 
	from gd_esquema.Maestra 
	where COMPRA_NUMERO is not null
	group by COMPRA_NUMERO, SUCURSAL_DIR, CIUDAD, COMPRA_FECHA
	order by COMPRA_NUMERO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.Compra off;

insert into ESTUDIANTES_CON_INSOMNIO.CompraAccesorio(cantidad, precio, codAccesorio, idCompra)
	select COMPRA_CANTIDAD cantidad, COMPRA_PRECIO precio, Accesorio.codAccesorio codAccesorio, Compra.idCompra idCompra
	from gd_esquema.Maestra Maestra
		join ESTUDIANTES_CON_INSOMNIO.Compra Compra on Maestra.COMPRA_NUMERO = Compra.idCompra
		join ESTUDIANTES_CON_INSOMNIO.Accesorio Accesorio on Maestra.ACCESORIO_CODIGO = Accesorio.codAccesorio
	where ACCESORIO_CODIGO is not null and COMPRA_NUMERO is not null
	order by COMPRA_NUMERO;

insert into ESTUDIANTES_CON_INSOMNIO.CompraPC(cantidad, precio, idCodigoPc, idCompra)
	select COMPRA_CANTIDAD cantidad, COMPRA_PRECIO precio, PC_CODIGO idCodigoPc, Compra.idCompra idCompra
	from gd_esquema.Maestra Maestra
		join ESTUDIANTES_CON_INSOMNIO.Compra Compra on Maestra.COMPRA_NUMERO = Compra.idCompra
	where PC_CODIGO is not null and COMPRA_NUMERO is not null
	order by COMPRA_NUMERO;

set identity_insert ESTUDIANTES_CON_INSOMNIO.Accesorio on;
insert into ESTUDIANTES_CON_INSOMNIO.Accesorio(codAccesorio, descripcion)
	select distinct ACCESORIO_CODIGO codAccesorio, AC_DESCRIPCION descripcion
	from gd_esquema.Maestra
	where ACCESORIO_CODIGO is not null
	order by ACCESORIO_CODIGO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.Accesorio off;

alter table ESTUDIANTES_CON_INSOMNIO.Accesorio
	add idFabricante varchar(255) default 'No especificado' foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante);

insert into ESTUDIANTES_CON_INSOMNIO.ItemPC(idFactura, idCodigoPc, cantidad, precio)
	select FACTURA_NUMERO idFactura, PC_CODIGO idCodigoPc, count(PC_CODIGO) cantidad, 1.2 * count(PC_CODIGO) * sum(COMPRA_PRECIO) / count(COMPRA_PRECIO) precio
	from gd_esquema.Maestra
	where FACTURA_NUMERO is not null and PC_CODIGO is not null
	group by FACTURA_NUMERO, PC_CODIGO;
	/*
insert into ESTUDIANTES_CON_INSOMNIO.ItemAccesorio(idFactura, codAccesorio, cantidad, precio)
	select FACTURA_NUMERO idFactura, ACCESORIO_CODIGO codAccesorio, count(ACCESORIO_CODIGO) cantidad, count(ACCESORIO_CODIGO)*(select sum(COMPRA_PRECIO) from gd_esquema.Maestra where ACCESORIO_CODIGO is not null) / (select count(COMPRA_PRECIO) from gd_esquema.Maestra where ACCESORIO_CODIGO is not null) precio
	from gd_esquema.Maestra
	where ACCESORIO_CODIGO is not null and FACTURA_NUMERO is not null
	group by FACTURA_NUMERO
	order by FACTURA_NUMERO;
	
set identity_insert ESTUDIANTES_CON_INSOMNIO.Factura on;
insert into ESTUDIANTES_CON_INSOMNIO.Factura(idFactura, precio, direccionSucursal, ciudadSucursal, fechaFacturacion, idCliente)
	select distinct FACTURA_NUMERO idFactura, sum(ItemPC.precio) + sum(ItemAccesorio.precio) precio,SUCURSAL_DIR direccionSucursal, CIUDAD ciudadSucursal, FACTURA_FECHA fechaFacturacion, Cliente.idCliente
	from gd_esquema.Maestra Maestra
		join ESTUDIANTES_CON_INSOMNIO.Cliente Cliente on Maestra.CLIENTE_DNI = Cliente.dni and Maestra.CLIENTE_APELLIDO = Cliente.apellido and Maestra.CLIENTE_NOMBRE = Cliente.nombre
		left join ESTUDIANTES_CON_INSOMNIO.ItemPC ItemPC on Maestra.FACTURA_NUMERO = ItemPC.idFactura
		left join ESTUDIANTES_CON_INSOMNIO.ItemAccesorio ItemAccesorio on Maestra.FACTURA_NUMERO = ItemAccesorio.idFactura
	where FACTURA_NUMERO is not null
	group by FACTURA_NUMERO, CIUDAD, FACTURA_FECHA, idCliente, SUCURSAL_DIR
	order by FACTURA_NUMERO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.Factura off;*/