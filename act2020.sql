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
create table ficha_has_trimestre(
id int not null primary key ,
id_ficha int not null,
id_trimestre int not null,
constraint uk_ficha_has_trimestre_ unique (id_ficha,id_trimestre),	
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
create table competencia(
id int not null primary key,
	id_programa int not null,
	codigo_competencia varchar(50)not null,
	denominacion varchar (1000)not null ,
	constraint uk_competencia unique (id_programa,codigo_competencia),
	constraint fk_prog_comp foreign key (id_programa)references programa(id)
	
)
create table resultado_aprendizaje(
id int not null primary key,
	codigo_resultado varchar (40)not null,
	id_competencia int not null,
	denominacion varchar (1000)not null,
	constraint uk_resultado_aprendizaje unique (codigo_resultado,id_competencia),
	constraint fk_comp_reap foreign key (id_competencia)references competencia (id)	
)
create table resultados_vistos (
id int not null primary key,
	id_resultado_aprendizaje int not null,
	id_ficha_has_trimestre int not null,
	id_planeacion int not null,
	constraint uk_resultados_vistos unique (id_resultado_aprendizaje,id_ficha_has_trimestre,id_planeacion),
	constraint fk_reap_revi foreign key (id_resultado_aprendizaje)references resultado_aprendizaje(id),
	constraint fk_fitr_revi foreign key (id_ficha_has_trimestre)references ficha_has_trimestre(id),
	constraint fk_plan foreign key (id_planeacion)references planeacion (id)
)
create table programacion_trimestre(
	id int not null primary key,
	id_resultado_aprendizaje int not null,
	id_trimestre int not null,
	id_planeacion int not null,
	constraint uk_programacion_trimestre unique (id_resultado_aprendizaje,id_trimestre,id_planeacion),
	constraint fk_reap_pltr foreign key (id_resultado_aprendizaje)references resultado_aprendizaje (id),
	constraint fk_pro_tri foreign key (id_trimestre)references trimestre(id),
	constraint fk_trim_pltr foreign key (id_planeacion)references planeacion(id)

)
create table actividad_planeacion(
id int not null primary key,
	id_actividad_proyecto int not null,
	id_programacion_trimestre int not null,
	constraint uk_actividad_plneacion unique (id_actividad_proyecto,id_programacion_trimestre),
	constraint fk_acti_acpl foreign key (id_actividad_proyecto)references actividad_proyecto(id),
	constraint fk_act_protri foreign key (id_programacion_trimestre)references programacion_trimestre (id)
	
)
create table actividad_proyecto(
id int not null primary key,
id_fase int not null ,
numero_actividad int not null,
descipcion_actividad varchar (400),
estado varchar (40),
constraint uk_actividad_proyecto unique (id_fase,numero_actividad),
constraint fk_fase_acti foreign key (id_fase)references fase(id)
)
create table fase (
id int not null primary key,
	id_proyecto int not null,
	nombre varchar (40)not null,
	estado varchar (40)not null,
	constraint uk_fase unique (id_proyecto,nombre),
	constraint fk_proy_fase foreign key (id_proyecto)references proyecto(id)	
)
create table proyecto(
	id int not null primary key,
	codigo varchar(40)not null,
	nombre varchar (500)not null,
	estado varchar (40)not null,
	id_programa int not null,
	constraint uk_codigo_ unique (codigo),
	constraint fk_prom foreign key (id_programa)references programa (id)
	
)							  
create table limitacion_ambiente(
id int not null primary key,
	id_resultado_aprendizaje int not null,
	id_ambiente int not null,
	constraint uk_limitacion_ambiente unique (id_resultado_aprendizaje,id_ambiente),
	constraint fk_reap_liam foreign key (id_resultado_aprendizaje)references resultado_aprendizaje (id),
	constraint fk_ambi_liam foreign key (id_ambiente)references ambiente (id)
)
create table ambiente(
	id int not null primary key,
	id_sede int not null,
	numero_ambiente varchar(50)not null,
	descripcion varchar (1000)not null,
	estado varchar (40)not null,
	limitacion varchar (40)not null,
	id_tipo_ambiente int not null,
	constraint uk_ambiente unique (id_sede,numero_ambiente),
	constraint fk_sede_ambi foreign key (id_sede)references sede (id),
	constraint fk_tiam_ambi foreign key (id_tipo_ambiente)references tipo_ambiente (id)

)
create table tipo_ambiente(
id int not null primary key,
	tipo varchar (50)not null,
	descripcion varchar (100)not null,
	estado varchar (40)not null,
	constraint uk_tipo_ambiente unique (tipo)

)
create table sede (
id int not null primary key,
	nombre_sede varchar (50)not null,
	direccion varchar (400)not null,
	estado varchar (40)not null,
	constraint uk_sede unique (nombre_sede)
)
create table dia (
id int not null primary key,
	nombre_dia varchar(40)not null,
	estado varchar (40)not null,
	constraint uk_dia unique (nombre_dia)

)
create table  horario(
id int not null primary key,
	hora_inicio time not null,
	id_ficha_has_trimestre int not null,
	id_instructor int not null,
	id_dia int not null,
	id_ambiente int  not null,
	id_version_horario int not null,
	hora_fin time not null,
	id_modalidad int not null,
	constraint uk_horario unique(hora_inicio,id_ficha_has_trimestre,id_instructor,id_dia,id_ambiente,id_version_horario,hora_fin ),
	constraint fk_filr_hora foreign key (id_ficha_has_trimestre)references ficha_has_trimestre (id),
	constraint fk_inst_hora foreign key (id_instructor)references instructor (id ),
	constraint fk_dia_hora foreign key (id_dia)references dia (id),
	constraint fk_ambi_hora foreign key (id_ambiente)references ambiente (id),
	constraint fk_veho_hora foreign key (id_version_horario)references version_horario(id),
	constraint fk_moda_hora foreign key (id_modalidad )references modalidad (id) 
	
)
create table modalidad (
id int not null primary key,
	nombre_modalidad varchar (40)not null,
	color varchar (50)not null,
	estado varchar (40)not null,
	constraint uk_modalidad unique (nombre_modalidad)
	
)
 create table version_horario(
 id int not null primary key,
	 numero_version varchar (40)not null,
	 id_trimestre_vigente int not null,
	 estado varchar (40)not null,
	 constraint uk_version_horario unique (numero_version,id_trimestre_vigente),
	 constraint fk_trvi_veho foreign key (id_trimestre_vigente)references trimestre_vigente (id)
 )
 create table trimestre_vigente(
 id int not null primary key,
	 id_year int not null,
	trimestre_programado int not null,
	 fecha_inicio date not null,
	 fecha_fin date not null,
	 estado  varchar (40)not null,
	 constraint uk_trimestre_vigente unique ( id_year,trimestre_programado),
	 constraint fk_year_trim_vige foreign key (id_year)references year_ (id)
 )
 
 
 
 
 
 create table year_(
 id int not null primary key,
	 number_year int not null, 
	 estado varchar (40)not null,
	 constraint uk_year unique (number_year)
 ) 
 create table instructor(
 id int not null primary key,
	 id_cliente int not null,
	 estado varchar (40)not null,
	 constraint uk_instuctor unique (id_cliente)
 ) 
 create table disponibilidad_competencias(
	 id int not null primary key,
	 id_competencia int not null,
	 id_vinculacion_instructor int not null,
	 constraint uk_disp_comp unique ( id_competencia, id_vinculacion_instructor),
	 constraint fk_vi_ins foreign key (id_vinculacion_instructor)references vinculacion_instructor(id),
	 constraint fk_ foreign key (id_competencia)references competencia (id)
	 
 )
 create table dia_jornada (
	 id int not null primary key,
	 id_jornada_instructor int not null,
	 id_dia int not null,
	 hora_inicio int not null,
	 hora_fin int not null,
	 constraint uk_dia_jornada unique (id_jornada_instructor,id_dia,hora_inicio, hora_fin),
	 constraint fk_jorn_inst foreign key (id_jornada_instructor)references jornada_instructor (id),
	 constraint fr_dia_jorn foreign key (id_dia)references dia (id) 
 )
create table jornada_instructor(
id int not null primary key,
	nombre_jornada varchar (80)not null,
	descripcion varchar (200)not null,
	estado varchar (40)not null ,
	constraint uk_nombre_jornada_ unique (nombre_jornada)
)
create table disponibilidad_horaria(
	id int not null primary key,
	id_jornada_instructor int not null,
	id_vinculacion_instructor  int not null,
	constraint uk_disponibilidad_horaria unique (id_jornada_instructor,id_vinculacion_instructor),
	constraint fk_jorn_disp foreign key (id_jornada_instructor)references jornada_instructor (id),
	constraint fk_vin_ins foreign key (id_vinculacion_instructor)references vinculacion_instructor(id)
	 
)
create table vinculacion_instructor (
	id int not null primary key,
	id_year int not null,
	fecha_inicio date not null,
	fecha_fin date not null ,
	id_vinculacion int not null,
	id_instructor int not null,
	constraint uk_vinculacion_instructor unique (id_year,fecha_inicio,fecha_fin,id_vinculacion,id_instructor),
	constraint fk_year_ foreign key (id_year) references year_ (id),
	constraint fk_vinc_inst foreign key (id_vinculacion)references vinculacion (id),
	constraint fk_inst foreign key (id_instructor) references instructor (id)
)
create table  vinculacion (
id int not null primary key,
	tipo_vinculacion varchar(40)not null,
	horas int not null,
	estado varchar (40)not null,
	constraint uk_vonculacion unique (tipo_vinculacion)
)
create table area(
	id int not null primary key,
	nombre_area varchar (40)not null,
	estado varchar (40)not null,
	url_logo varchar (1000),
	constraint uk_area unique (nombre_area)
	
) 
create table area_instructor(
id int not null primary key,
	id_area int not null,
	id_instructor int not null,
	estado varchar (40)not null,
	constraint uk_area_instructor unique (id_area,id_instructor),
	constraint fk_intr_esin foreign key (id_instructor)references instructor(id),
	constraint fk_a_i foreign key (id_area)references area (id) 
)

