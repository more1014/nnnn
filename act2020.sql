create table authority(
name varchar (50)primary key
)
create table system_user_(
id int primary key not null, 
login varchar (50)not null,
password varchar (60),
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
