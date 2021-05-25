use GD1C2021;
go

-- creación de tablas

create table ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(
	idFabricante varchar(255) not null primary key,
	telefono decimal(18,0)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_MemoriaRAM(
	codRAM varchar(255) not null primary key,
	tipo varchar(255) not null,
	capacidad varchar(255) not null,
	velocidad varchar(255) not null,
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Microprocesador(
	codMicroprocesador varchar(50) not null primary key,
	cache varchar(50) not null,
	cantHilos decimal(18,0) not null,
	velocidad varchar(50) not null,
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_DiscoRigido(
	codDiscoRigido varchar(255) not null primary key,
	tipo varchar(255) not null,
	capacidad varchar(255) not null,
	velocidad varchar(255) not null,
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_PlacaVideo(
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Fabricante(idFabricante),
	modeloPlaca varchar(50) not null,
	chipset varchar(50) not null,
	velocidad varchar(50) not null,
	capacidad varchar(255) not null,
	primary key (idFabricante, modeloPlaca)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_PC(
	idCodigoPC varchar(50) not null primary key,
	codRAM varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.MemoriaRAM(codRAM),
	motherboard varchar(255),
	codMicroprocesador varchar(50) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Microprocesador(codMicroprocesador),
	idFabricante varchar(255) not null,
	modeloPlaca varchar(50) not null,
	codDiscoRigido varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.DiscoRigido(codDiscoRigido),
	foreign key (idFabricante, modeloPlaca) references ESTUDIANTES_CON_INSOMNIO.PlacaVideo(idFabricante, modeloPlaca)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Sucursal(
	ciudadSucursal varchar(255) not null,
	telefono decimal(18,0) not null,
	mail varchar(255) not null,
	direccionSucursal varchar(255) not null,
	primary key (direccionSucursal, ciudadSucursal)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Cliente(
	idCliente decimal(18,0) not null identity(1,1) primary key,
	sexo varchar(255),
	edadRango varchar(255)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Factura(
	idFactura decimal(18,0) not null identity(1,1) primary key,
	direccionSucursal varchar(255) not null,
	ciudadSucursal varchar(255) not null,
	añoFactura int not null,
	mesFactura int not null,
	precio decimal(18,2),
	idCliente decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Cliente(idCliente),
	foreign key (direccionSucursal, ciudadSucursal) references ESTUDIANTES_CON_INSOMNIO.Sucursal(direccionSucursal, ciudadSucursal)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Compra(
	idCompra decimal(18,0) not null identity(1,1) primary key,
	ciudadSucursal varchar(255) not null,
	direccionSucursal varchar(255) not null,
	añoCompra int not null,
	mesCompra int not null,
	precio decimal(18,2) not null,
	foreign key (direccionSucursal, ciudadSucursal) references ESTUDIANTES_CON_INSOMNIO.Sucursal(direccionSucursal, ciudadSucursal)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Accesorio(
	codAccesorio decimal(18,0) not null identity(1,1) primary key,
	descripcion varchar(255) not null
);

create table ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio(
	idItemAccesorio decimal(18,0) not null identity(1,1) primary key,
	idFactura decimal(18,0) not null,
	codAccesorio decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Accesorio(codAccesorio),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

create table ESTUDIANTES_CON_INSOMNIO.BI_ItemPC(
	idItemPC decimal(18,0) not null identity(1,1) primary key,
	idFactura decimal(18,0) not null,
	idCodigoPc varchar(50) not null foreign key references ESTUDIANTES_CON_INSOMNIO.PC(idCodigoPC),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

create table ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio(
	idCompraAccesorio decimal(18,0) not null identity(1,1) primary key,
	idCompra decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Compra(idCompra),
	codAccesorio decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Accesorio(codAccesorio),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

create table ESTUDIANTES_CON_INSOMNIO.BI_CompraPC(
	idCompraPC decimal(18,0) not null identity(1,1) primary key,
	idCompra decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.Compra(idCompra),
	idCodigoPc varchar(50) not null foreign key references ESTUDIANTES_CON_INSOMNIO.PC(idCodigoPC),
	cantidad decimal(18,0) not null,
	precio decimal(18,2) not null
);

-- creación de índices para cada unas de las tablas sobre la/s PK

create index indiceFabricante on ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(idFabricante);

create index indiceMemoriaRAM on ESTUDIANTES_CON_INSOMNIO.BI_MemoriaRAM(codRAM);

create index indiceMicroprocesador on ESTUDIANTES_CON_INSOMNIO.BI_Microprocesador(codMicroprocesador);

create index indiceDiscoRigido on ESTUDIANTES_CON_INSOMNIO.BI_DiscoRigido(codDiscoRigido);

create index indicePlacaVideo on ESTUDIANTES_CON_INSOMNIO.BI_PlacaVideo(idFabricante, modeloPlaca);

create index indicePC on ESTUDIANTES_CON_INSOMNIO.BI_PC(idCodigoPC);

create index indiceSucursal on ESTUDIANTES_CON_INSOMNIO.BI_Sucursal(direccionSucursal, ciudadSucursal);

create index indiceCliente on ESTUDIANTES_CON_INSOMNIO.BI_Cliente(idCliente);

create index indiceFactura on ESTUDIANTES_CON_INSOMNIO.BI_Factura(idFactura);

create index indiceCompra on ESTUDIANTES_CON_INSOMNIO.BI_Compra(idCompra);

create index indiceAccesorio on ESTUDIANTES_CON_INSOMNIO.BI_Accesorio(codAccesorio);

create index indiceItemAccesorio on ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio(idItemAccesorio);

create index indiceItemPC on ESTUDIANTES_CON_INSOMNIO.BI_ItemPC(idItemPC);

create index indiceCompraAccesorio on ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio(idCompraAccesorio);

create index indiceCompraPC on ESTUDIANTES_CON_INSOMNIO.BI_CompraPC(idCompraPC);

-- Migración de Datos

insert into ESTUDIANTES_CON_INSOMNIO.BI_Fabricante (idFabricante)
	select  distinct DiscoRigido.idFabricante idFabricante
	from ESTUDIANTES_CON_INSOMNIO.DiscoRigido
	where DiscoRigido.idFabricante is not null and not exists (select idFabricante from ESTUDIANTES_CON_INSOMNIO.BI_Fabricante);
	
insert into ESTUDIANTES_CON_INSOMNIO.BI_Fabricante (idFabricante)
	select  distinct MemoriaRAM.idFabricante idFabricante
	from ESTUDIANTES_CON_INSOMNIO.MemoriaRAM
	where MemoriaRAM.idFabricante is not null and not exists (select idFabricante from ESTUDIANTES_CON_INSOMNIO.BI_Fabricante where MemoriaRAM.idFabricante = idFabricante);

insert into ESTUDIANTES_CON_INSOMNIO.BI_Fabricante (idFabricante)
	select  distinct Microprocesador.idFabricante idFabricante
	from ESTUDIANTES_CON_INSOMNIO.Microprocesador
	where Microprocesador.idFabricante is not null and not exists (select idFabricante from ESTUDIANTES_CON_INSOMNIO.BI_Fabricante where Microprocesador.idFabricante = idFabricante);

insert into ESTUDIANTES_CON_INSOMNIO.BI_Fabricante (idFabricante)
	select  distinct PlacaVideo.idFabricante idFabricante
	from ESTUDIANTES_CON_INSOMNIO.PlacaVideo
	where PlacaVideo.idFabricante is not null and not exists (select idFabricante from ESTUDIANTES_CON_INSOMNIO.BI_Fabricante where PlacaVideo.idFabricante = idFabricante);

insert into ESTUDIANTES_CON_INSOMNIO.BI_MemoriaRAM (codRAM, tipo, capacidad, velocidad, idFabricante)
	select distinct MemoriaRAM.codRAM codRAM, MemoriaRAM.tipo tipo, MemoriaRAM.capacidad capacidad, MemoriaRAM.velocidad velocidad, MemoriaRAM.idFabricante idFabricante
	from ESTUDIANTES_CON_INSOMNIO.MemoriaRAM
	where MemoriaRAM.codRAM is not null
	order by MemoriaRAM.codRAM;

insert into ESTUDIANTES_CON_INSOMNIO.BI_Microprocesador (codMicroprocesador, cache, cantHilos, velocidad, idFabricante)
	select distinct Microprocesador.codMicroprocesador codMicroprocesador, Microprocesador.cache cache, Microprocesador.cantHilos cantHilos, Microprocesador.velocidad velocidad, Microprocesador.idFabricante idFabricante
	from ESTUDIANTES_CON_INSOMNIO.Microprocesador
	where Microprocesador.codMicroprocesador is not null
	order by Microprocesador.codMicroprocesador;

insert into ESTUDIANTES_CON_INSOMNIO.BI_PlacaVideo (modeloPlaca, chipset, velocidad, capacidad, idFabricante)
	select distinct PlacaVideo.modeloPlaca modeloPlaca, PlacaVideo.chipset chipset, PlacaVideo.velocidad velocidad, PlacaVideo.capacidad capacidad, PlacaVideo.idFabricante idFabricante
	from ESTUDIANTES_CON_INSOMNIO.PlacaVideo
	where PlacaVideo.idFabricante is not null and PlacaVideo.modeloPlaca is not null;

insert into ESTUDIANTES_CON_INSOMNIO.BI_DiscoRigido (codDiscoRigido, tipo, capacidad, velocidad, idFabricante)
	select distinct DiscoRigido.codDiscoRigido codDiscoRigido, DiscoRigido.tipo tipo, DiscoRigido.capacidad capacidad, DiscoRigido.velocidad velocidad, DiscoRigido.idFabricante idFabricante
	from ESTUDIANTES_CON_INSOMNIO.DiscoRigido
	where DiscoRigido.codDiscoRigido is not null
	order by DiscoRigido.codDiscoRigido;
	
insert into ESTUDIANTES_CON_INSOMNIO.BI_PC(idCodigoPC, codRAM, codMicroprocesador, idFabricante, modeloPlaca, codDiscoRigido)
	select distinct PC.idCodigoPC idCodigoPC, PC.codRAM codRAM, PC.codMicroprocesador codMicroprocesador, PC.idFabricante idFabricante, PC.modeloPlaca modeloPlaca, PC.codDiscoRigido codDiscoRigido
	from ESTUDIANTES_CON_INSOMNIO.PC
	where PC.idCodigoPC is not null
	order by PC.idCodigoPC;

set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Accesorio on;
insert into ESTUDIANTES_CON_INSOMNIO.BI_Accesorio(codAccesorio, descripcion)
	select distinct Accesorio.codAccesorio codAccesorio, Accesorio.descripcion descripcion
	from ESTUDIANTES_CON_INSOMNIO.Accesorio
	where Accesorio.codAccesorio is not null
	order by Accesorio.codAccesorio;
set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Accesorio off;

insert into ESTUDIANTES_CON_INSOMNIO.BI_Sucursal(direccionSucursal, mail, telefono, ciudadSucursal)
	select distinct Sucursal.direccionSucursal direccionSucursal, Sucursal.mail mail, Sucursal.telefono telefono, Sucursal.ciudadSucursal ciudadSucursal
	from ESTUDIANTES_CON_INSOMNIO.Sucursal;

insert into ESTUDIANTES_CON_INSOMNIO.BI_Cliente(apellido, nombre, dni, direccion, mail, telefono, fechaNacimiento)
	select distinct CLIENTE_APELLIDO apellido, CLIENTE_NOMBRE nombre, CLIENTE_DNI dni, CLIENTE_DIRECCION direccion, CLIENTE_MAIL mail, CLIENTE_TELEFONO telefono, CLIENTE_FECHA_NACIMIENTO fechaNacimiento
	from gd_esquema.Maestra
	where CLIENTE_APELLIDO is not null and CLIENTE_NOMBRE is not null and CLIENTE_DNI is not null;

set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Compra on;
insert into ESTUDIANTES_CON_INSOMNIO.BI_Compra(idCompra, direccionSucursal, ciudadSucursal, fechaCompra, precio)
	select distinct COMPRA_NUMERO idCompra, SUCURSAL_DIR direccionSucursal, CIUDAD ciudadSucursal, COMPRA_FECHA fechaCompra, sum(COMPRA_PRECIO) precio 
	from gd_esquema.Maestra 
	where COMPRA_NUMERO is not null
	group by COMPRA_NUMERO, SUCURSAL_DIR, CIUDAD, COMPRA_FECHA
	order by COMPRA_NUMERO;
set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Compra off;

insert into ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio(cantidad, precio, codAccesorio, idCompra)
	select COMPRA_CANTIDAD cantidad, COMPRA_PRECIO precio, Accesorio.codAccesorio codAccesorio, Compra.idCompra idCompra
	from gd_esquema.Maestra Maestra
		left join ESTUDIANTES_CON_INSOMNIO.BI_Compra Compra on Maestra.COMPRA_NUMERO = Compra.idCompra
		left join ESTUDIANTES_CON_INSOMNIO.BI_Accesorio Accesorio on Maestra.ACCESORIO_CODIGO = Accesorio.codAccesorio
	where ACCESORIO_CODIGO is not null and COMPRA_NUMERO is not null
	order by COMPRA_NUMERO;

insert into ESTUDIANTES_CON_INSOMNIO.BI_CompraPC(cantidad, precio, idCodigoPc, idCompra)
	select COMPRA_CANTIDAD cantidad, COMPRA_PRECIO precio, PC_CODIGO idCodigoPc, Compra.idCompra idCompra
	from gd_esquema.Maestra Maestra
		join ESTUDIANTES_CON_INSOMNIO.BI_Compra Compra on Maestra.COMPRA_NUMERO = Compra.idCompra
	where PC_CODIGO is not null and COMPRA_NUMERO is not null
	order by COMPRA_NUMERO;

-- Añadimos el atributo Fabricante a Accesorio, que en la tabla dada por la cátedra no tenía datos

alter table ESTUDIANTES_CON_INSOMNIO.Accesorio
	add idFabricante varchar(255) default 'No especificado' foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(idFabricante)
	on delete cascade
	on update cascade;

set ansi_warnings off;
go

insert into ESTUDIANTES_CON_INSOMNIO.BI_ItemPC(idFactura, idCodigoPc, cantidad, precio)
	select FACTURA_NUMERO idFactura, PC_CODIGO idCodigoPc, count(FACTURA_NUMERO) cantidad, 1.2 * max(CompraPC.precio) precio
	from gd_esquema.Maestra Maestra
		outer apply (
			select top 1 *
			from ESTUDIANTES_CON_INSOMNIO.BI_CompraPC CompraPC
			where CompraPC.idCodigoPc = Maestra.PC_CODIGO) CompraPC
	where FACTURA_NUMERO is not null and PC_CODIGO is not null
	group by FACTURA_NUMERO, PC_CODIGO
	order by FACTURA_NUMERO;

insert into ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio(idFactura, codAccesorio, cantidad, precio)
	select FACTURA_NUMERO idFactura, ACCESORIO_CODIGO codAccesorio, count(ACCESORIO_CODIGO) cantidad, coalesce((max(CompraAccesorio.precio)/max(CompraAccesorio.cantidad)), 0) precio
	from gd_esquema.Maestra
		outer apply (
			select top 1 *
			from ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio CompraAccesorio
			where CompraAccesorio.codAccesorio = Maestra.ACCESORIO_CODIGO) CompraAccesorio
	where ACCESORIO_CODIGO is not null and FACTURA_NUMERO is not null
	group by FACTURA_NUMERO, ACCESORIO_CODIGO;
	
set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Factura on;
insert into ESTUDIANTES_CON_INSOMNIO.BI_Factura(idFactura, precio, direccionSucursal, ciudadSucursal, fechaFacturacion, idCliente)
	select distinct FACTURA_NUMERO idFactura, coalesce(sum(ItemPC.precio) + sum(ItemAccesorio.precio), sum(ItemPC.precio), sum(ItemAccesorio.precio)) precio, SUCURSAL_DIR direccionSucursal, CIUDAD ciudadSucursal, FACTURA_FECHA fechaFacturacion, Cliente.idCliente idCliente
	from gd_esquema.Maestra Maestra
		left join ESTUDIANTES_CON_INSOMNIO.BI_Cliente Cliente on Maestra.CLIENTE_DNI = Cliente.dni and Maestra.CLIENTE_APELLIDO = Cliente.apellido and Maestra.CLIENTE_NOMBRE = Cliente.nombre
		full join ESTUDIANTES_CON_INSOMNIO.BI_ItemPC ItemPC on Maestra.FACTURA_NUMERO = ItemPC.idFactura and Maestra.PC_CODIGO = ItemPC.idCodigoPc
		full join ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio ItemAccesorio on Maestra.FACTURA_NUMERO = ItemAccesorio.idFactura and Maestra.ACCESORIO_CODIGO = ItemAccesorio.codAccesorio
	where FACTURA_NUMERO is not null
	group by FACTURA_NUMERO, SUCURSAL_DIR, CIUDAD, FACTURA_FECHA, Cliente.idCliente;
set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Factura off;

-- agregamos FK a las tablas de ítem ahora, porque si los agregábamos antes se nos dificultaba  crear la tabla Item, 
-- por lo que no podríamos usar los atributos ItemPC.precio y ItemPC.cantidad para calcular el precio de la factura

alter table ESTUDIANTES_CON_INSOMNIO.BI_ItemPC
	add foreign key (idFactura) references ESTUDIANTES_CON_INSOMNIO.BI_Factura(idFactura)
	on delete cascade
	on update cascade;

alter table ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio
	add foreign key (idFactura) references ESTUDIANTES_CON_INSOMNIO.BI_Factura(idFactura)
	on delete cascade
	on update cascade;
go

-- creación de las vistas

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Fabricante as
select * from ESTUDIANTES_CON_INSOMNIO.BI_Fabricante;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_MemoriaRAM as
select * from ESTUDIANTES_CON_INSOMNIO.BI_MemoriaRAM;
go 

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Microprocesador as
select * from ESTUDIANTES_CON_INSOMNIO.BI_Microprocesador;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_DiscoRigido as
select * from ESTUDIANTES_CON_INSOMNIO.BI_DiscoRigido;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_PlacaVideo as
select * from ESTUDIANTES_CON_INSOMNIO.BI_PlacaVideo;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_PC as
select * from ESTUDIANTES_CON_INSOMNIO.BI_PC;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Sucursal as
select * from ESTUDIANTES_CON_INSOMNIO.BI_Sucursal;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Cliente as
select * from ESTUDIANTES_CON_INSOMNIO.BI_Cliente;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Factura as
select * from ESTUDIANTES_CON_INSOMNIO.BI_Factura;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Compra as
select * from ESTUDIANTES_CON_INSOMNIO.BI_Compra;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Accesorio as
select * from ESTUDIANTES_CON_INSOMNIO.BI_Accesorio;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_ItemAccesorio as
select * from ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_ItemPC as
select * from ESTUDIANTES_CON_INSOMNIO.BI_ItemPC;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_CompraAccesorio as
select * from ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_CompraPC as
select * from ESTUDIANTES_CON_INSOMNIO.BI_CompraPC;
go

-- creación de los triggers para evitar que se borren datos ya insertados
-- (medida de seguridad)

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Accesorios
on ESTUDIANTES_CON_INSOMNIO.BI_Accesorio
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Clientes
on ESTUDIANTES_CON_INSOMNIO.BI_Cliente
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Compras
on ESTUDIANTES_CON_INSOMNIO.BI_Compra
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_CompraAccesorios
on ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_CompraPCs
on ESTUDIANTES_CON_INSOMNIO.BI_CompraPC
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_DiscosRigidos
on ESTUDIANTES_CON_INSOMNIO.BI_DiscoRigido
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Fabricantes
on ESTUDIANTES_CON_INSOMNIO.BI_Fabricante
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Facturas
on ESTUDIANTES_CON_INSOMNIO.BI_Factura
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_ItemAccesorios
on ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_ItemPCs
on ESTUDIANTES_CON_INSOMNIO.BI_ItemPC
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_MemoriasRAM
on ESTUDIANTES_CON_INSOMNIO.BI_MemoriaRAM
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Microprocesadores
on ESTUDIANTES_CON_INSOMNIO.BI_Microprocesador
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_PCs
on ESTUDIANTES_CON_INSOMNIO.BI_PC
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_PlacasVideo
on ESTUDIANTES_CON_INSOMNIO.BI_PlacaVideo
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Sucursales
on ESTUDIANTES_CON_INSOMNIO.BI_Sucursal
for delete as
	raiserror('No está permitido borrar datos', 16, 1)
	rollback
go


