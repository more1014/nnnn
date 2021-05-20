create table authority(
name varchar (50)primary key
)
create table system_user_(
id int primary key not null, 
login varchar (50)not null,
password varchar (60) not null,
email varchar (254)not null,
activated int ,
lang_key varchar(6)not null,
image_url varchar (256),
activation_key varchar (20),
reset_key varchar (20),
reset_date timestamp,
	constraint uk_login unique (login),
	constraint uk_email unique (email)
)
create table user_authority(
	name_rol varchar(50)not null,
	id_system_user_ int not null,
	constraint pk_user primary key (name_rol,id_system_user_),
	constraint fk_uaa foreign key (name_rol)references authority(name),
	constraint fk_ua foreign key (id_system_user_)references system_user_ (id)
	
) 
create table cliente (
	id int primary key ,
	id_tipo_documento int not null,
	numero_documento varchar(50)not null ,
	primer_nombre  varchar (50)not null,
	segundo_nombre  varchar (50),
	primer_apellido varchar (50)not null,
	segundo_apellido varchar (50),
	id_system_user int not null ,
	constraint fk_user_clien foreign key (id_system_user) references  system_user_ (id),
    constraint fk_tido_clie foreign key (id_tipo_documento) references tipo_documento(id),
	constraint uk_cliente unique (id_tipo_documento),
	constraint uk_cliente_ unique (numero_documento),
	constraint uk_user unique (id_system_user)
)
create table tipo_documento(
	id int not null primary key,
	sigla varchar (10)not null ,
	nombre_documento varchar (100) not null ,
	estado varchar(40)not null,
	constraint uk_sigla unique (sigla),
	constraint uk_nombre_documento unique (nombre_documento) 

)
create table log_errores(
id int not null primary key ,
	nivel varchar (400)not null,
	log_name varchar (400)not null,
	mansaje varchar (400)not null,
	fecha date not null,
	id_cliente int not null,
	constraint fk_clie_log_erro foreign key (id_cliente)references cliente (id)
)
create table log_auditoria(
	id int not null  primary key,
	nivel varchar (400)not null,
	log_name varchar (400)not null,
	mansaje varchar (400)not null,
	fecha date not null,
	id_cliente int not null,
    constraint fk_clie_log_audi foreign key (id_cliente)references cliente(id)

)
create table estado_formacion (
   id int not null primary key,
	nombre_estado varchar(40)not null,
	estado varchar(40)not null,
	constraint uk_nombre_estado unique (nombre_estado)
	
)
create table nivel_formacion(
id int not null primary key,
	nivel varchar (40)not null,
	estado varchar (40)not null,
	constraint uk_nivel unique (nivel)
)
create table programa(
id int not null primary key,
	codigo varchar (50)not null,
	version varchar (40)not null,
	nombre varchar (500)not null,
	sigla varchar (40)not null,
	estado varchar (40)not null,
	id_nivel_formacion int not null,
	constraint uk_programa unique (codigo,version),
	constraint fk_nifo_prog foreign key (id_nivel_formacion)references nivel_formacion(id)
	
) 

create table aprendiz(
    id int not null primary key,
	id_cliente int not null,
	id_ficha int not null ,
	id_estado_formacion int not null,
	constraint uk_aprendiz unique (id_cliente,id_ficha),
    constraint fk_esta_apre foreign key (id_cliente)references cliente (id),
	constraint fk_fich_apre foreign key (id_ficha)references ficha(id),
	constraint fk_esta_apre_ foreign key (id_estado_formacion)references estado_formacion (id)
)
create table ficha (
id int primary key not null,
id_programa int not null,
numero_ficha varchar (100)not null, 
fecha_inicio date not null,
fecha_fin date not null,
ruta varchar (40)not null,
id_estado_ficha int not null,
id_jornada int not null,
constraint uk_ficha unique(numero_ficha),
constraint fk_prog_fich foreign key (id_programa)references programa (id),
constraint fk_esfi_fich foreign key (id_estado_ficha)references estado_ficha (id),
constraint fk_jorn_fich foreign key (id_jornada)references jornada (id)
)
create table estado_ficha(
id int not null primary key,
nombre_estado varchar (20)not null,
estado int not null,
constraint uk_nombre_estado_ unique (nombre_estado)
)
create table jornada (
id int not null primary key,
	sigla_jornada varchar (20)not null,
	nombre_jornada varchar(40)not null,
	describcion varchar (100)not null,
	imagen_url varchar (1000),
	estado varchar (40)not null,
	constraint uk_sigla_jornada unique (sigla_jornada),
	constraint uk_nombre_jornada unique (nombre_jornada)
)

create table trimestre (
id int not null primary key ,
nombre_trimestre int not null,
id_jornada int not null,
id_nivel_formacion int not null,
estado varchar (40)not null,
constraint fk_jorn_trim foreign key (id_jornada)references jornada (id),
constraint fk_nifo_trim foreign key (id_nivel_formacion)references nivel_formacion(id),
constraint uk_trimestre_ unique (nombre_trimestre,id_jornada,id_nivel_formacion)
)
create table ficha_has_trimetre(
id int not null primary key ,
id_ficha int not null,
id_trimestre int not null,
constraint uk_ficha_has_trimestre unique (id_ficha,id_trimestre),	
constraint fk_trim_fitr foreign key (id_trimestre)references trimestre(id),
constraint	fk_fht foreign key (id_ficha)references ficha (id)
)
create table planeacion(
	id int not null primary key,
	codigo varchar (40)not null, 
	fecha date not null,
	estado varchar (40)not null,
	constraint uk_codigo unique (codigo)
	
) 
create table ficha_planeacion(
id int not null primary key,
	id_ficha int not null,
	id_planeacion int not null,
	estado varchar (40) not null,
	constraint uk_ficha_planeacion unique (id_ficha,id_planeacion),
    constraint fk_fich_apre foreign key (id_ficha)references ficha (id),
	constraint fk_fich_pln foreign key  (id_planeacion)references planeacion(id)
)
