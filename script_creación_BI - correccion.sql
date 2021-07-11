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
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(idFabricante)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Microprocesador(
	codMicroprocesador varchar(50) not null primary key,
	cache varchar(50) not null,
	cantHilos decimal(18,0) not null,
	velocidad varchar(50) not null,
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(idFabricante)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_DiscoRigido(
	codDiscoRigido varchar(255) not null primary key,
	tipo varchar(255) not null,
	capacidad varchar(255) not null,
	velocidad varchar(255) not null,
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(idFabricante)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_PlacaVideo(
	idFabricante varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(idFabricante),
	modeloPlaca varchar(50) not null,
	chipset varchar(50) not null,
	velocidad varchar(50) not null,
	capacidad varchar(255) not null,
	primary key (idFabricante, modeloPlaca)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_PC(
	idCodigoPC varchar(50) not null primary key,
	codRAM varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_MemoriaRAM(codRAM),
	motherboard varchar(255),
	codMicroprocesador varchar(50) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Microprocesador(codMicroprocesador),
	idFabricante varchar(255) not null,
	modeloPlaca varchar(50) not null,
	codDiscoRigido varchar(255) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_DiscoRigido(codDiscoRigido),
	foreign key (idFabricante, modeloPlaca) references ESTUDIANTES_CON_INSOMNIO.BI_PlacaVideo(idFabricante, modeloPlaca)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Sucursal(
	ciudadSucursal varchar(255) not null,
	telefono decimal(18,0) not null,
	mail varchar(255) not null,
	direccionSucursal varchar(255) not null,
	primary key (direccionSucursal, ciudadSucursal)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Accesorio(
	codAccesorio decimal(18,0) not null identity(1,1) primary key,
	descripcion varchar(255) not null
);

create table ESTUDIANTES_CON_INSOMNIO.BI_Fecha(
	idFecha int not null identity(1,1) primary key,
	año int not null,
	mes int not null
);

create table ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio(
	codAccesorio decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Accesorio(codAccesorio),
	idFecha int not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fecha(idFecha),
	ciudadSucursal varchar(255) not null,
	direccionSucursal varchar(255) not null,
	precioProm decimal(18,2) not null,
	promTiempo bigint not null,
	cantAccesorios decimal(18,0) not null,
	sexo varchar(255),
	edadRango varchar(255),
	foreign key (direccionSucursal, ciudadSucursal) references ESTUDIANTES_CON_INSOMNIO.BI_Sucursal(direccionSucursal, ciudadSucursal),
	primary key(codAccesorio, direccionSucursal, ciudadSucursal, idFecha)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_ItemPC(
	idCodigoPc varchar(50) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_PC(idCodigoPC),
	idFecha int not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fecha(idFecha),
	ciudadSucursal varchar(255) not null,
	direccionSucursal varchar(255) not null,
	precioProm decimal(18,2) not null,
	sexo varchar(255),
	edadRango varchar(255),
	promTiempo bigint not null,
	cantPCs decimal(18,0) not null,
	foreign key (direccionSucursal, ciudadSucursal) references ESTUDIANTES_CON_INSOMNIO.BI_Sucursal(direccionSucursal, ciudadSucursal),
	primary key(idCodigoPc, direccionSucursal, ciudadSucursal, idFecha)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio(
	codAccesorio decimal(18,0) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Accesorio(codAccesorio),
	idFecha int not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fecha(idFecha),
	cantAccesorios decimal(18,0) not null,
	ciudadSucursal varchar(255) not null,
	direccionSucursal varchar(255) not null,
	precioProm decimal(18,2) not null, 
	foreign key (direccionSucursal, ciudadSucursal) references ESTUDIANTES_CON_INSOMNIO.BI_Sucursal(direccionSucursal, ciudadSucursal),
	primary key(codAccesorio, direccionSucursal, ciudadSucursal, idFecha)
);

create table ESTUDIANTES_CON_INSOMNIO.BI_CompraPC(
	idCodigoPc varchar(50) not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_PC(idCodigoPC),
	idFecha int not null foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fecha(idFecha),
	cantPCs decimal(18,0) not null,
	ciudadSucursal varchar(255) not null,
	direccionSucursal varchar(255) not null,
	precioProm decimal(18,2) not null,
	foreign key (direccionSucursal, ciudadSucursal) references ESTUDIANTES_CON_INSOMNIO.BI_Sucursal(direccionSucursal, ciudadSucursal),
	primary key(idCodigoPc, direccionSucursal, ciudadSucursal, idFecha)
);

-- creación de índices para cada unas de las tablas sobre la/s PK

create index indiceFabricante on ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(idFabricante);

create index indiceMemoriaRAM on ESTUDIANTES_CON_INSOMNIO.BI_MemoriaRAM(codRAM);

create index indiceMicroprocesador on ESTUDIANTES_CON_INSOMNIO.BI_Microprocesador(codMicroprocesador);

create index indiceDiscoRigido on ESTUDIANTES_CON_INSOMNIO.BI_DiscoRigido(codDiscoRigido);

create index indicePlacaVideo on ESTUDIANTES_CON_INSOMNIO.BI_PlacaVideo(idFabricante, modeloPlaca);

create index indicePC on ESTUDIANTES_CON_INSOMNIO.BI_PC(idCodigoPC);

create index indiceSucursal on ESTUDIANTES_CON_INSOMNIO.BI_Sucursal(direccionSucursal, ciudadSucursal);

create index indiceAccesorio on ESTUDIANTES_CON_INSOMNIO.BI_Accesorio(codAccesorio);

create index indiceFecha on ESTUDIANTES_CON_INSOMNIO.BI_Fecha(idFecha);

create index indiceItemAccesorio on ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio(codAccesorio, direccionSucursal, ciudadSucursal, idFecha);

create index indiceItemPC on ESTUDIANTES_CON_INSOMNIO.BI_ItemPC(idCodigoPc, direccionSucursal, ciudadSucursal, idFecha);

create index indiceCompraAccesorio on ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio(codAccesorio, direccionSucursal, ciudadSucursal, idFecha);

create index indiceCompraPC on ESTUDIANTES_CON_INSOMNIO.BI_CompraPC(idCodigoPc, direccionSucursal, ciudadSucursal, idFecha);

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

insert into ESTUDIANTES_CON_INSOMNIO.BI_Fecha(año, mes)
	select year(Factura.fechaFacturacion) año, month(Factura.fechaFacturacion) mes
	from ESTUDIANTES_CON_INSOMNIO.Factura
	where year(Factura.fechaFacturacion) not in (select año from ESTUDIANTES_CON_INSOMNIO.BI_Fecha)
		or month(Factura.fechaFacturacion) not in (select mes from ESTUDIANTES_CON_INSOMNIO.BI_Fecha where BI_Fecha.año = year(Factura.fechaFacturacion))
	group by year(Factura.fechaFacturacion), month(Factura.fechaFacturacion)

insert into ESTUDIANTES_CON_INSOMNIO.BI_Fecha(año, mes)
	select year(Compra.fechaCompra) año, month(Compra.fechaCompra) mes
	from ESTUDIANTES_CON_INSOMNIO.Compra
	where year(Compra.fechaCompra) not in (select año from ESTUDIANTES_CON_INSOMNIO.BI_Fecha)
		or month(Compra.fechaCompra) not in (select mes from ESTUDIANTES_CON_INSOMNIO.BI_Fecha where BI_Fecha.año = year(Compra.fechaCompra))
	group by year(Compra.fechaCompra), month(Compra.fechaCompra)
	
insert into ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio(codAccesorio, precioProm, idFecha, direccionSucursal, ciudadSucursal, cantAccesorios)
	select CompraAccesorio.codAccesorio codAccesorio, avg(CompraAccesorio.precio) precioProm,
		(select idFecha
		from ESTUDIANTES_CON_INSOMNIO.BI_Fecha
		where BI_Fecha.año = year(Compra.fechaCompra) and BI_Fecha.mes = month(Compra.fechaCompra)) idFecha,
		Compra.direccionSucursal direccionSucursal, Compra.ciudadSucursal ciudadSucursal,
		sum(CompraAccesorio.cantidad) cantAccesorios
	from ESTUDIANTES_CON_INSOMNIO.CompraAccesorio
		join ESTUDIANTES_CON_INSOMNIO.Compra on Compra.idCompra = CompraAccesorio.idCompra
	group by year(Compra.fechaCompra), month(Compra.fechaCompra), Compra.ciudadSucursal,
		Compra.direccionSucursal, CompraAccesorio.codAccesorio;

insert into ESTUDIANTES_CON_INSOMNIO.BI_CompraPC(idCodigoPc, precioProm, idFecha, 
				direccionSucursal, ciudadSucursal, cantPCs)
	select CompraPC.idCodigoPc idCodigoPc, avg(CompraPC.precio) precioProm,
		(select idFecha
		from ESTUDIANTES_CON_INSOMNIO.BI_Fecha
		where BI_Fecha.año = year(Compra.fechaCompra) and BI_Fecha.mes = month(Compra.fechaCompra)) idFecha,
		Compra.direccionSucursal direccionSucursal, Compra.ciudadSucursal ciudadSucursal,
		sum(CompraPC.cantidad) cantPCs
	from ESTUDIANTES_CON_INSOMNIO.CompraPC
		join ESTUDIANTES_CON_INSOMNIO.Compra on Compra.idCompra = CompraPC.idCompra
	group by year(Compra.fechaCompra), month(Compra.fechaCompra), Compra.ciudadSucursal,
		Compra.direccionSucursal, CompraPC.idCodigoPc;

-- Añadimos el atributo Fabricante a Accesorio, que en la tabla dada por la cátedra no tenía datos

alter table ESTUDIANTES_CON_INSOMNIO.BI_Accesorio
	add idFabricante varchar(255) default 'No especificado' foreign key references ESTUDIANTES_CON_INSOMNIO.BI_Fabricante(idFabricante)
	on delete cascade
	on update cascade;

set ansi_warnings off;
go

insert into ESTUDIANTES_CON_INSOMNIO.BI_ItemPC(idCodigoPc, precioProm, idFecha, direccionSucursal, ciudadSucursal, promTiempo, cantPCs,
			sexo, edadRango)
	select IPC.idCodigoPc idCodigoPC,  
		avg(IPC.precio) precioProm, 
		(select idFecha
		from ESTUDIANTES_CON_INSOMNIO.BI_Fecha
		where BI_Fecha.año = year(Factura.fechaFacturacion) and BI_Fecha.mes = month(Factura.fechaFacturacion)) idFecha,
		Factura.direccionSucursal direccionSucursal,
		Factura.ciudadSucursal ciudadSucursal, 
		datediff(day,
	(select avg(cast(datediff(day,Factura.fechaFacturacion,'01-01-1900') as bigint)) from ESTUDIANTES_CON_INSOMNIO.ItemPC
		join ESTUDIANTES_CON_INSOMNIO.Factura on Factura.idFactura = ItemPC.idFactura
	where ItemPC.idCodigoPc = IPC.idCodigoPc
	group by ItemPC.idCodigoPc),
	(select avg(cast(datediff(day,Compra.fechaCompra,'01-01-1900') as bigint)) from ESTUDIANTES_CON_INSOMNIO.CompraPC
		join ESTUDIANTES_CON_INSOMNIO.Compra on CompraPC.idCompra = Compra.idCompra
	where CompraPC.idCodigoPc = IPC.idCodigoPc
	group by CompraPC.idCodigoPc)) promTiempo,
		coalesce(sum(IPC.cantidad), 0) cantPCs,
		'Indefinido' sexo,
		(case 
		when avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) >= 18  and avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) < 31 then '18-30 años'
		when avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) >= 31  and avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) < 51 then '31-50 años' 
		when avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) >= 51 then '> 50 años' 
		else 'menor de edad'
		end) edadRango
	from ESTUDIANTES_CON_INSOMNIO.ItemPC IPC
		join ESTUDIANTES_CON_INSOMNIO.Factura Factura on IPC.idFactura = Factura.idFactura
		left join ESTUDIANTES_CON_INSOMNIO.Cliente Cliente on Cliente.idCliente = Factura.idCliente
	group by year(Factura.fechaFacturacion), month(Factura.fechaFacturacion), Factura.ciudadSucursal, Factura.direccionSucursal,
		IPC.idCodigoPc

insert into ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio(codAccesorio, precioProm, idFecha,
            direccionSucursal, ciudadSucursal, promTiempo, cantAccesorios,
            sexo, edadRango)
    select IAcc.codAccesorio idCodigoAccesorio,  
        avg(IAcc.precio) precioProm, 
		(select idFecha
		from ESTUDIANTES_CON_INSOMNIO.BI_Fecha
		where BI_Fecha.año = year(Factura.fechaFacturacion) and BI_Fecha.mes = month(Factura.fechaFacturacion)) idFecha,
        Factura.direccionSucursal direccionSucursal,
        Factura.ciudadSucursal ciudadSucursal, 
        datediff(day,
    (select avg(cast(datediff(day,Factura.fechaFacturacion,'01-01-1900') as bigint)) from ESTUDIANTES_CON_INSOMNIO.ItemAccesorio
        join ESTUDIANTES_CON_INSOMNIO.Factura on Factura.idFactura = ItemAccesorio.idFactura
    where ItemAccesorio.codAccesorio = IAcc.codAccesorio
    group by ItemAccesorio.codAccesorio),
   (select avg(cast(datediff(day,Compra.fechaCompra,'01-01-1900') as bigint)) from ESTUDIANTES_CON_INSOMNIO.CompraAccesorio
        join ESTUDIANTES_CON_INSOMNIO.Compra on CompraAccesorio.idCompra = Compra.idCompra
    where CompraAccesorio.codAccesorio = IAcc.codAccesorio
    group by CompraAccesorio.codAccesorio)) promTiempo,
        coalesce(sum(IAcc.cantidad),0) cantAccesorios,
        'Indefinido' sexo,
        (case 
        when avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) >= 18  and avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) < 31 then '18-30 años'
        when avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) >= 31  and avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) < 51 then '31-50 años' 
        when avg(cast(datediff(DAY,Cliente.fechaNacimiento,getdate())/365 as int)) >= 51 then '> 50 años' 
        else 'menor de edad'
        end) edadRango
    from ESTUDIANTES_CON_INSOMNIO.ItemAccesorio IAcc
        join ESTUDIANTES_CON_INSOMNIO.Factura Factura on IAcc.idFactura = Factura.idFactura
        left join ESTUDIANTES_CON_INSOMNIO.Cliente Cliente on Cliente.idCliente = Factura.idCliente
    group by year(Factura.fechaFacturacion), month(Factura.fechaFacturacion), Factura.ciudadSucursal, Factura.direccionSucursal,
        IAcc.codAccesorio
go

-- creación de las vistas

-- vistas de PCs

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Promedio_Tiempo_Stock_PC as
select IPC.idCodigoPC CodigoPC, IPC.promTiempo
from ESTUDIANTES_CON_INSOMNIO.BI_ItemPC IPC
group by idCodigoPC, promTiempo
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Promedio_Precio_PC as
select IPC.idCodigoPC CodigoPC, BI_Fecha.año año, BI_Fecha.mes mes,
		IPC.ciudadSucursal ciudadSucursal, IPC.direccionSucursal direccionSucursal, IPC.precioProm precioProm
from ESTUDIANTES_CON_INSOMNIO.BI_ItemPC IPC
	join ESTUDIANTES_CON_INSOMNIO.BI_Fecha on IPC.idFecha = BI_Fecha.idFecha
group by idCodigoPC, año, mes, ciudadSucursal, direccionSucursal, precioProm
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Cant_PC_x_Sucursal_y_mes_PC as
select BI_ItemPC.idCodigoPc CodigoPC, BI_Fecha.año año, BI_Fecha.mes mes, 
		'Venta' tipoOperacion, BI_ItemPC.ciudadSucursal ciudadSucursal, BI_ItemPC.direccionSucursal direccionSucursal,
		BI_ItemPC.cantPCs cantidad
from ESTUDIANTES_CON_INSOMNIO.BI_ItemPC 
	join ESTUDIANTES_CON_INSOMNIO.BI_Fecha on BI_ItemPC.idFecha = BI_Fecha.idFecha
group by  BI_Fecha.año,  BI_Fecha.mes, BI_ItemPC.ciudadSucursal, BI_ItemPC.direccionSucursal,
	BI_ItemPC.idCodigoPc, BI_ItemPC.cantPCs 
union all
select BI_CompraPC.idCodigoPc CodigoPC, BI_Fecha.año año, BI_Fecha.mes mes, 
		'Compra' tipoOperacion, BI_CompraPC.ciudadSucursal ciudadSucursal, BI_CompraPC.direccionSucursal direccionSucursal,
		BI_CompraPC.cantPCs cantidad
from ESTUDIANTES_CON_INSOMNIO.BI_CompraPC
	join ESTUDIANTES_CON_INSOMNIO.BI_Fecha on BI_CompraPC.idFecha = BI_Fecha.idFecha
group by BI_Fecha.año,  BI_Fecha.mes, BI_CompraPC.ciudadSucursal, BI_CompraPC.direccionSucursal,
	BI_CompraPC.idCodigoPc, BI_CompraPC.cantPCs
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Ganancias_PC as
select BI_Fecha.año año, BI_Fecha.mes mes, 
	BI_ItemPC.ciudadSucursal ciudadSucursal, BI_ItemPC.direccionSucursal direccionSucursal,
	coalesce(sum(BI_ItemPC.cantPcs * (BI_ItemPC.precioProm - BI_CompraPC.precioProm)),0) ganancia		 
from ESTUDIANTES_CON_INSOMNIO.BI_ItemPC 
	join ESTUDIANTES_CON_INSOMNIO.BI_Fecha on BI_ItemPC.idFecha = BI_Fecha.idFecha    
    outer apply (
        select avg(BI_CompraPC.precioProm) as precioProm
        from ESTUDIANTES_CON_INSOMNIO.BI_CompraPC
        where BI_CompraPC.idCodigoPc = BI_ItemPC.idCodigoPc) BI_CompraPC
group by  BI_Fecha.año,  BI_Fecha.mes,  BI_ItemPC.ciudadSucursal, BI_ItemPC.direccionSucursal
go

-- vistas de Accesorios

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Promedio_Tiempo_Stock_Accesorios as
select IAcc.codAccesorio CodigoAccesorio, IAcc.promTiempo promTiempo
from ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio IAcc
group by IAcc.codAccesorio, IAcc.promTiempo
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Promedio_Precio_Accesorio as
select IAcc.codAccesorio CodigoAccesorio, IAcc.ciudadSucursal ciudadSucursal,
	IAcc.direccionSucursal direccionSucursal, IAcc.precioProm precioPromedio, 'Venta' tipoOperacion,
	BI_Fecha.año año, BI_Fecha.mes mes
from ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio IAcc
	join ESTUDIANTES_CON_INSOMNIO.BI_Fecha on IAcc.idFecha = BI_Fecha.idFecha 
group by año, mes, codAccesorio, ciudadSucursal, direccionSucursal, precioProm 
union all
select CAcc.codAccesorio CodigoAccesorio, CAcc.ciudadSucursal ciudadSucursal,
	CAcc.direccionSucursal direccionSucursal, CAcc.precioProm precioPromedio, 'Compra' tipoOperacion,
	BI_Fecha.año año, BI_Fecha.mes mes
from ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio CAcc
	join ESTUDIANTES_CON_INSOMNIO.BI_Fecha on CAcc.idFecha = BI_Fecha.idFecha
group by año, mes, codAccesorio, ciudadSucursal, direccionSucursal, precioProm 
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Maximo_Stock_x_Sucursal_y_año_Accesorios as
select BI_CompraAccesorio.ciudadSucursal ciudadSucursal, BI_CompraAccesorio.direccionSucursal direccionSucursal, 
	BI_Fecha.año año, sum(BI_CompraAccesorio.cantAccesorios) maxStock 
from ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio
	join ESTUDIANTES_CON_INSOMNIO.BI_Fecha on BI_Fecha.idFecha = BI_CompraAccesorio.idFecha
group by BI_CompraAccesorio.ciudadSucursal, BI_CompraAccesorio.direccionSucursal, 
	BI_Fecha.año
go

create view ESTUDIANTES_CON_INSOMNIO.vista_BI_Ganancias_Accesorio as
select BI_Fecha.año año, BI_Fecha.mes mes, 
	IAcc.ciudadSucursal ciudadSucursal, IAcc.direccionSucursal direccionSucursal,
	coalesce(sum(IAcc.cantAccesorios * (IAcc.precioProm - BI_CompraAccesorio.precioProm)),0) ganancia
from ESTUDIANTES_CON_INSOMNIO.BI_ItemAccesorio IAcc 
	join ESTUDIANTES_CON_INSOMNIO.BI_Fecha on BI_Fecha.idFecha = IAcc.idFecha       
    outer apply (
        select avg(BI_CompraAccesorio.precioProm) as precioProm
        from ESTUDIANTES_CON_INSOMNIO.BI_CompraAccesorio
        where BI_CompraAccesorio.codAccesorio = IAcc.codAccesorio) BI_CompraAccesorio
group by BI_Fecha.año, BI_Fecha.mes, IAcc.ciudadSucursal, IAcc.direccionSucursal
go
-- creación de los triggers para evitar que se borren datos ya insertados
-- (medida de seguridad)

create trigger ESTUDIANTES_CON_INSOMNIO.borrar_BI_Accesorios
on ESTUDIANTES_CON_INSOMNIO.BI_Accesorio
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


