use GD1C2021;
go

-- creaci?n de tablas

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
	a?oFactura int not null,
	mesFactura int not null,
	precio decimal(18,2),
	idCliente decimal(18,0) foreign key references ESTUDIANTES_CON_INSOMNIO.Cliente(idCliente),
	foreign key (direccionSucursal, ciudadSucursal) references ESTUDIANTES_CON_INSOMNIO.Sucursal(direccionSucursal, ciudadSucursal)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Compra(
	idCompra decimal(18,0) not null identity(1,1) primary key,
	ciudadSucursal varchar(255) not null,
	direccionSucursal varchar(255) not null,
	a?oCompra int not null,
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

-- creaci?n de ?ndices para cada unas de las tablas sobre la/s PK

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

-- Migraci?n de Datos

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

insert into ESTUDIANTES_CON_INSOMNIO.BI_Cliente(edadRango, sexo)
	select 
	(case 
	when (cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) > 18  and (cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) < 31 then '18-30 a?os'
	when (cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) > 31  and (cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) < 50 then '31-50 a?os' 
	when (cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) > 50 then '> 50 a?os' 
	else 'menor de edad'
	end) edadRango, 'Indefinido' sexo
	from ESTUDIANTES_CON_INSOMNIO.Cliente
	where Cliente.apellido is not null and Cliente.nombre is not null and Cliente.dni is not null;

set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Compra on;
insert into ESTUDIANTES_CON_INSOMNIO.BI_Compra(idCompra, direccionSucursal, ciudadSucursal, a?oCompra, mesCompra, precio)
	select distinct Compra.idCompra idCompra, Compra.direccionSucursal direccionSucursal, Compra.ciudadSucursal ciudadSucursal, year(Compra.fechaCompra) a?oCompra, month(Compra.fechaCompra) mesCompra, Compra.precio precio 
	from ESTUDIANTES_CON_INSOMNIO.Compra 
	where Compra.idCompra is not null
	order by Compra.idCompra;
set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Compra off;

insert into ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio(cantidad, precio, codAccesorio, idCompra)
	select CompraAccesorio.cantidad cantidad, CompraAccesorio.precio precio, CompraAccesorio.codAccesorio codAccesorio, CompraAccesorio.idCompra idCompra
	from ESTUDIANTES_CON_INSOMNIO.CompraAccesorio
	where CompraAccesorio.idCompraAccesorio is not null
	order by CompraAccesorio.idCompraAccesorio;

insert into ESTUDIANTES_CON_INSOMNIO.BI_CompraPC(cantidad, precio, idCodigoPc, idCompra)
	select CompraPC.cantidad cantidad, CompraPC.precio precio, CompraPC.idCodigoPc idCodigoPc, CompraPC.idCompra idCompra
	from ESTUDIANTES_CON_INSOMNIO.CompraPC
	where CompraPC.idCompraPC is not null
	order by CompraPC.idCompraPC;

-- A?adimos el atributo Fabricante a Accesorio, que en la tabla dada por la c?tedra no ten?a datos

alter table ESTUDIANTES_CON_INSOMNIO.BI_Accesorio
	add idFabricante varchar(255) default 'No especificado' foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(idFabricante)
	on delete cascade
	on update cascade;

set ansi_warnings off;
go

insert into ESTUDIANTES_CON_INSOMNIO.BI_ItemPC(idFactura, idCodigoPc, cantidad, precio)
	select ItemPC.idFactura idFactura, ItemPC.idCodigoPc idCodigoPc, ItemPC.cantidad cantidad, ItemPC.precio precio
	from ESTUDIANTES_CON_INSOMNIO.ItemPC
	where ItemPC.idItemPC is not null
	order by ItemPC.idFactura;

insert into ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio(idFactura, codAccesorio, cantidad, precio)
	select ItemAccesorio.idFactura idFactura, ItemAccesorio.codAccesorio codAccesorio, ItemAccesorio.cantidad cantidad, ItemAccesorio.precio precio
	from ESTUDIANTES_CON_INSOMNIO.ItemAccesorio
	where ItemAccesorio.idItemAccesorio is not null;
	
set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Factura on;
insert into ESTUDIANTES_CON_INSOMNIO.BI_Factura(idFactura, precio, direccionSucursal, ciudadSucursal, a?oFactura, mesFactura, idCliente)
	select distinct Factura.idFactura idFactura, Factura.precio precio, Factura.direccionSucursal direccionSucursal, Factura.ciudadSucursal ciudadSucursal, year(Factura.fechaFacturacion) a?oFactura, month(Factura.fechaFacturacion) mesFactura, Factura.idCliente idCliente
	from ESTUDIANTES_CON_INSOMNIO.Factura
	where Factura.idFactura is not null;
set identity_insert ESTUDIANTES_CON_INSOMNIO.BI_Factura off;

-- agregamos FK a las tablas de ?tem ahora, porque si los agreg?bamos antes se nos dificultaba  crear la tabla Item, 
-- por lo que no podr?amos usar los atributos ItemPC.precio y ItemPC.cantidad para calcular el precio de la factura

alter table ESTUDIANTES_CON_INSOMNIO.BI_ItemPC
	add foreign key (idFactura) references ESTUDIANTES_CON_INSOMNIO.BI_Factura(idFactura)
	on delete cascade
	on update cascade;

alter table ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio
	add foreign key (idFactura) references ESTUDIANTES_CON_INSOMNIO.BI_Factura(idFactura)
	on delete cascade
	on update cascade;
go


-- creaci?n de las vistas

-- vistas de PCs

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Promedio_Tiempo_Stock_PC as
select IPC.idCodigoPC CodigoPC, datediff(day,
	(select avg(datediff(day,Factura.fechaFacturacion,'01-01-1900')) from ESTUDIANTES_CON_INSOMNIO.ItemPC
		join ESTUDIANTES_CON_INSOMNIO.Factura on Factura.idFactura = ItemPC.idFactura
	where ItemPC.idCodigoPc = IPC.idCodigoPc
	group by ItemPC.idCodigoPc),
	(select avg(datediff(day,Compra.fechaCompra,'01-01-1900')) from ESTUDIANTES_CON_INSOMNIO.CompraPC
		join ESTUDIANTES_CON_INSOMNIO.Compra on CompraPC.idCompra = Compra.idCompra
	where CompraPC.idCodigoPc = IPC.idCodigoPc
	group by CompraPC.idCodigoPc)) PromedioTiempo
from ESTUDIANTES_CON_INSOMNIO.ItemPC IPC
group by IPC.idCodigoPc;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Promedio_Precio_PC as
select avg(BI_ItemPC.precio) precioPromedio, BI_ItemPC.idCodigoPc CodigoPC, 'Venta' tipoOperacion
from ESTUDIANTES_CON_INSOMNIO.BI_ItemPC 
group by BI_ItemPC.idCodigoPc
union all
select avg(BI_CompraPC.precio) precioPromedio, BI_CompraPC.idCodigoPc CodigoPC, 'Compra' tipoOperacion
from ESTUDIANTES_CON_INSOMNIO.BI_CompraPC
group by BI_CompraPC.idCodigoPc
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Cant_PC_x_Sucursal_y_mes_PC as
select count(BI_ItemPC.cantidad) cantidad, BI_Factura.ciudadSucursal sucursal, BI_Factura.mesFactura mes, BI_Factura.a?oFactura a?o, 'Venta' tipoOperacion
from ESTUDIANTES_CON_INSOMNIO.BI_ItemPC 
	left join ESTUDIANTES_CON_INSOMNIO.BI_Factura on BI_ItemPC.idFactura = BI_Factura.idFactura
group by BI_Factura.a?oFactura, BI_Factura.mesFactura, BI_Factura.ciudadSucursal
union all
select count(BI_CompraPC.cantidad) cantidad, BI_Compra.ciudadSucursal sucursal, BI_Compra.mesCompra mes, BI_Compra.a?oCompra a?o, 'Compra' tipoOperacion
from ESTUDIANTES_CON_INSOMNIO.BI_CompraPC
	left join ESTUDIANTES_CON_INSOMNIO.BI_Compra on BI_CompraPC.idCompra = BI_Compra.idCompra
group by BI_Compra.a?oCompra, BI_Compra.mesCompra, BI_Compra.ciudadSucursal
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Ganancias_PC as
select coalesce(sum(BI_ItemPC.cantidad * (BI_ItemPC.precio - BI_CompraPC.promedioPrecio)),0) ganancia, BI_Factura.ciudadSucursal sucursal, BI_Factura.mesFactura mes, BI_Factura.a?oFactura a?o
from ESTUDIANTES_CON_INSOMNIO.BI_ItemPC 
	left join ESTUDIANTES_CON_INSOMNIO.BI_Factura on BI_ItemPC.idFactura = BI_Factura.idFactura		
	outer apply (
		select avg(BI_CompraPC.precio) as promedioPrecio
		from ESTUDIANTES_CON_INSOMNIO.BI_CompraPC
		where BI_CompraPC.idCodigoPc = BI_ItemPC.idCodigoPc) BI_CompraPC
group by BI_Factura.a?oFactura, BI_Factura.mesFactura, BI_Factura.ciudadSucursal
go

-- vistas de Accesorios

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Promedio_Tiempo_Stock_Accesorios as
select IAcc.codAccesorio CodigoAccesorio, datediff(day,
	(select avg(datediff(day,Factura.fechaFacturacion,'01-01-1900')) from ESTUDIANTES_CON_INSOMNIO.ItemAccesorio
		join ESTUDIANTES_CON_INSOMNIO.Factura on Factura.idFactura = ItemAccesorio.idFactura
	where ItemAccesorio.codAccesorio = IAcc.codAccesorio
	group by ItemAccesorio.codAccesorio),
	(select avg(cast (datediff(day,Compra.fechaCompra,'01-01-1900') as bigint)) from ESTUDIANTES_CON_INSOMNIO.CompraAccesorio
		join ESTUDIANTES_CON_INSOMNIO.Compra on CompraAccesorio.idCompra = Compra.idCompra
	where CompraAccesorio.codAccesorio = IAcc.codAccesorio
	group by CompraAccesorio.codAccesorio)) PromedioTiempo
from ESTUDIANTES_CON_INSOMNIO.ItemAccesorio IAcc
group by IAcc.codAccesorio;
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Promedio_Precio_Accesorio as
select avg(BI_ItemAccesorio.precio) precioPromedio, BI_ItemAccesorio.codAccesorio CodigoAccesorio, 'Venta' tipoOperacion
from ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio 
group by BI_ItemAccesorio.codAccesorio
union all
select avg(BI_CompraAccesorio.precio) precioPromedio, BI_CompraAccesorio.codAccesorio CodigoAccesorio, 'Compra' tipoOperacion
from ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio
group by BI_CompraAccesorio.codAccesorio
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Maximo_Stock_x_Sucursal_y_a?o_Accesorios as
select sum(BI_CompraAccesorio.cantidad) cantidad, BI_Compra.ciudadSucursal sucursal, BI_Compra.a?oCompra a?o
from ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio
	left join ESTUDIANTES_CON_INSOMNIO.BI_Compra on BI_CompraAccesorio.idCompra = BI_Compra.idCompra
group by BI_Compra.ciudadSucursal, BI_Compra.a?oCompra
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Ganancias_Accesorio as
select coalesce(sum(BI_ItemAccesorio.cantidad * (BI_ItemAccesorio.precio - BI_CompraAccesorio.promedioPrecio)),0) ganancia, BI_Factura.ciudadSucursal sucursal, BI_Factura.mesFactura mes, BI_Factura.a?oFactura a?o
from ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio 
	left join ESTUDIANTES_CON_INSOMNIO.BI_Factura on BI_ItemAccesorio.idFactura = BI_Factura.idFactura		
	outer apply (
		select avg(BI_CompraAccesorio.precio) as promedioPrecio
		from ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio
		where BI_CompraAccesorio.codAccesorio = BI_ItemAccesorio.codAccesorio) BI_CompraAccesorio
group by BI_Factura.a?oFactura, BI_Factura.mesFactura, BI_Factura.ciudadSucursal
go

-- creaci?n de los triggers para evitar que se borren datos ya insertados
-- (medida de seguridad)

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Accesorios
on ESTUDIANTES_CON_INSOMNIO.BI_Accesorio
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Clientes
on ESTUDIANTES_CON_INSOMNIO.BI_Cliente
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Compras
on ESTUDIANTES_CON_INSOMNIO.BI_Compra
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_CompraAccesorios
on ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_CompraPCs
on ESTUDIANTES_CON_INSOMNIO.BI_CompraPC
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_DiscosRigidos
on ESTUDIANTES_CON_INSOMNIO.BI_DiscoRigido
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Fabricantes
on ESTUDIANTES_CON_INSOMNIO.BI_Fabricante
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Facturas
on ESTUDIANTES_CON_INSOMNIO.BI_Factura
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_ItemAccesorios
on ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_ItemPCs
on ESTUDIANTES_CON_INSOMNIO.BI_ItemPC
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_MemoriasRAM
on ESTUDIANTES_CON_INSOMNIO.BI_MemoriaRAM
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Microprocesadores
on ESTUDIANTES_CON_INSOMNIO.BI_Microprocesador
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_PCs
on ESTUDIANTES_CON_INSOMNIO.BI_PC
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_PlacasVideo
on ESTUDIANTES_CON_INSOMNIO.BI_PlacaVideo
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Sucursales
on ESTUDIANTES_CON_INSOMNIO.BI_Sucursal
for delete as
	raiserror('No est? permitido borrar datos', 16, 1)
	rollback
go


