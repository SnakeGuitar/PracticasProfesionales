create table organizacion_vinculada
(
    ID_Org_Vinculada int auto_increment
        primary key,
    nombre           varchar(100) not null,
    sector           varchar(100) not null,
    correo           varchar(50)  not null,
    telefono         varchar(10)  not null,
    direccion        varchar(100) not null,
    ciudad           varchar(50)  not null,
    estado           varchar(50)  not null
);

create table periodo
(
    ID_Periodo   int auto_increment
        primary key,
    abreviatura  varchar(20) not null,
    fecha_inicio date        not null,
    fecha_fin    date        not null
);

create table estadistica
(
    ID_Periodo                    int not null
        primary key,
    hombres_sector_privado        int not null,
    mujeres_sector_privado        int not null,
    hombres_sector_publico        int not null,
    mujeres_sector_publico        int not null,
    hombres_sector_social         int not null,
    mujeres_sector_social         int not null,
    num_hablantes_idioma_indigena int not null,
    constraint fk_Estadistica_Periodo
        foreign key (ID_Periodo) references periodo (ID_Periodo)
);

create table experiencia_educativa
(
    ID_EE      int auto_increment,
    nrc        int          not null,
    nombre     varchar(100) not null,
    ID_Periodo int          not null,
    primary key (ID_EE, ID_Periodo),
    constraint fk_Experiencia_Educativa_Periodo1
        foreign key (ID_Periodo) references periodo (ID_Periodo)
);

create index fk_Experiencia_Educativa_Periodo1_idx
    on experiencia_educativa (ID_Periodo);

create table responsable_tecnico
(
    ID_Responsable   int auto_increment,
    nombre           varchar(100) not null,
    departamento     varchar(100) not null,
    puesto           varchar(100) not null,
    correo           varchar(50)  not null,
    ID_Org_Vinculada int          not null,
    primary key (ID_Responsable, ID_Org_Vinculada),
    constraint fk_Responsable_Tecnico_Organizacion_Vinculada1
        foreign key (ID_Org_Vinculada) references organizacion_vinculada (ID_Org_Vinculada)
);

create table proyecto
(
    ID_Proyecto       int auto_increment,
    nombre            varchar(100) not null,
    objetivo_general  varchar(100) not null,
    metodologia       varchar(100) not null,
    max_participantes int          not null,
    fecha_inicio      date         not null,
    fecha_fin         date         not null,
    ID_Org_Vinculada  int          not null,
    ID_Responsable    int          not null,
    primary key (ID_Proyecto, ID_Org_Vinculada, ID_Responsable),
    constraint fk_Proyecto_Organizacion_Vinculada1
        foreign key (ID_Org_Vinculada) references organizacion_vinculada (ID_Org_Vinculada),
    constraint fk_Proyecto_Responsable_Tecnico1
        foreign key (ID_Responsable) references responsable_tecnico (ID_Responsable)
);

create index fk_Proyecto_Organizacion_Vinculada1_idx
    on proyecto (ID_Org_Vinculada);

create index fk_Proyecto_Responsable_Tecnico1_idx
    on proyecto (ID_Responsable);

create index fk_Responsable_Tecnico_Organizacion_Vinculada1_idx
    on responsable_tecnico (ID_Org_Vinculada);

create table usuario
(
    ID_Usuario   int auto_increment
        primary key,
    username     varchar(45)                                    not null,
    password     varbinary(255)                                 not null,
    tipo_usuario enum ('COORDINADOR', 'ESTUDIANTE', 'PROFESOR') not null,
    activo       tinyint(1)                                     not null
);

create table coordinador
(
    ID_Coordinador int auto_increment,
    num_personal   int          not null,
    nombre         varchar(100) not null,
    puesto         varchar(100) not null,
    ID_EE          int          not null,
    ID_Usuario     int          null,
    primary key (ID_Coordinador, ID_EE),
    constraint fk_Coordinador_Experiencia_Educativa1
        foreign key (ID_EE) references experiencia_educativa (ID_EE),
    constraint fk_Coordinador_Usuario1
        foreign key (ID_Usuario) references usuario (ID_Usuario)
);

create index fk_Coordinador_Experiencia_Educativa1_idx
    on coordinador (ID_EE);

create index fk_Coordinador_Usuario1_idx
    on coordinador (ID_Usuario);

create table estudiante
(
    ID_Estudiante         int auto_increment
        primary key,
    matricula             varchar(9)      not null,
    nombre                varchar(100)    not null,
    genero                enum ('H', 'M') not null,
    correo                varchar(50)     null,
    telefono              varchar(10)     not null,
    semestre              int             not null,
    promedio              float           not null,
    habla_idioma_indigena tinyint(1)      not null,
    ID_Proyecto           int             null,
    ID_Usuario            int             null,
    constraint matricula_UNIQUE
        unique (matricula),
    constraint fk_Estudiante_Proyecto1
        foreign key (ID_Proyecto) references proyecto (ID_Proyecto),
    constraint fk_Estudiante_Usuario1
        foreign key (ID_Usuario) references usuario (ID_Usuario)
);

create index fk_Estudiante_Proyecto1_idx
    on estudiante (ID_Proyecto);

create index fk_Estudiante_Usuario1_idx
    on estudiante (ID_Usuario);

create table expediente
(
    ID_Estudiante    int                                       not null,
    ID_Periodo       int                                       not null,
    estado           enum ('Activo', 'Concluido', 'Cancelado') null,
    horas_acumuladas int                                       null,
    primary key (ID_Estudiante, ID_Periodo),
    constraint fk_Expediente_Estudiante1
        foreign key (ID_Estudiante) references estudiante (ID_Estudiante),
    constraint fk_Expediente_Periodo1
        foreign key (ID_Periodo) references periodo (ID_Periodo)
);

create table entrega_doc_final
(
    ID_Entrega_Doc_Final int auto_increment,
    fecha_apertura       datetime not null,
    fecha_limite         datetime not null,
    ID_Estudiante        int      not null,
    ID_Periodo           int      not null,
    primary key (ID_Entrega_Doc_Final, ID_Estudiante, ID_Periodo),
    constraint fk_Entrega_Doc_Final_Expediente1
        foreign key (ID_Estudiante, ID_Periodo) references expediente (ID_Estudiante, ID_Periodo)
);

create table documento_final
(
    ID_Doc_Final         int auto_increment,
    fecha_entrega        datetime                                                                           null,
    tipo                 enum ('ReporteFinal', 'Autoevaluacion', 'EvaluacionFinalPorOV', 'CartaLiberacion') not null,
    estado               enum ('Pendiente', 'Entregado', 'Aceptado', 'Rechazado')                           null,
    documento            longblob                                                                           null,
    ID_Entrega_Doc_Final int                                                                                not null,
    primary key (ID_Doc_Final, ID_Entrega_Doc_Final),
    constraint fk_Documento_Final_Entrega_Doc_Final1
        foreign key (ID_Entrega_Doc_Final) references entrega_doc_final (ID_Entrega_Doc_Final)
);

create index fk_Documento_Final_Entrega_Doc_Final1_idx
    on documento_final (ID_Entrega_Doc_Final);

create index fk_Entrega_Doc_Final_Expediente1_idx
    on entrega_doc_final (ID_Estudiante, ID_Periodo);

create table entrega_doc_inicial
(
    ID_Entrega_Doc_Inicialcol int auto_increment,
    fecha_apertura            datetime not null,
    fecha_limite              datetime not null,
    ID_Estudiante             int      not null,
    ID_Periodo                int      not null,
    primary key (ID_Entrega_Doc_Inicialcol, ID_Estudiante, ID_Periodo),
    constraint fk_Entrega_Doc_Inicial_Expediente1
        foreign key (ID_Estudiante, ID_Periodo) references expediente (ID_Estudiante, ID_Periodo)
);

create table documento_inicial
(
    ID_Doc_Inicial         int auto_increment,
    fecha_entrega          datetime                                                                                    null,
    tipo                   enum ('CartaAceptacion', 'Cronograma', 'OficioAsignacion', 'HorarioUV', 'ConstanciaSeguro') not null,
    estado                 enum ('Pendiente', 'Entregado', 'Aceptado', 'Rechazado')                                    null,
    documento              longblob                                                                                    null,
    ID_Entrega_Doc_Inicial int                                                                                         not null,
    primary key (ID_Doc_Inicial, ID_Entrega_Doc_Inicial),
    constraint fk_Documento_Inicial_Entrega_Doc_Inicial1
        foreign key (ID_Entrega_Doc_Inicial) references entrega_doc_inicial (ID_Entrega_Doc_Inicialcol)
);

create index fk_Documento_Inicial_Entrega_Doc_Inicial1_idx
    on documento_inicial (ID_Entrega_Doc_Inicial);

create index fk_Entrega_Doc_Inicial_Expediente1_idx
    on entrega_doc_inicial (ID_Estudiante, ID_Periodo);

create table entrega_doc_parcial
(
    ID_Entrega_Doc_Parcial int auto_increment,
    fecha_apertura         datetime not null,
    fecha_limite           datetime not null,
    ID_Estudiante          int      not null,
    ID_Periodo             int      not null,
    primary key (ID_Entrega_Doc_Parcial, ID_Estudiante, ID_Periodo),
    constraint fk_Entrega_Doc_Parcial_Expediente1
        foreign key (ID_Estudiante, ID_Periodo) references expediente (ID_Estudiante, ID_Periodo)
);

create table documento_parcial
(
    ID_Doc_Parcial         int auto_increment,
    fecha_entrega          datetime                                                 null,
    tipo                   enum ('ReporteParcial', 'EvaluacionParcialPorOV')        not null,
    estado                 enum ('Pendiente', 'Entregado', 'Aceptado', 'Rechazado') null,
    documento              longblob                                                 null,
    ID_Entrega_Doc_Parcial int                                                      not null,
    primary key (ID_Doc_Parcial, ID_Entrega_Doc_Parcial),
    constraint fk_Documento_Parcial_Entrega_Doc_Parcial1
        foreign key (ID_Entrega_Doc_Parcial) references entrega_doc_parcial (ID_Entrega_Doc_Parcial)
);

create index fk_Documento_Parcial_Entrega_Doc_Parcial1_idx
    on documento_parcial (ID_Entrega_Doc_Parcial);

create index fk_Entrega_Doc_Parcial_Expediente1_idx
    on entrega_doc_parcial (ID_Estudiante, ID_Periodo);

create table entrega_reporte
(
    ID_Entrega_Reporte int auto_increment,
    num_reporte        int      not null,
    fecha_apertura     datetime null,
    fecha_limite       datetime null,
    fecha_entrega      datetime null,
    ID_Estudiante      int      not null,
    ID_Periodo         int      not null,
    primary key (ID_Entrega_Reporte, ID_Estudiante, ID_Periodo),
    constraint fk_Entrega_Reporte_Expediente1
        foreign key (ID_Estudiante, ID_Periodo) references expediente (ID_Estudiante, ID_Periodo)
);

create index fk_Entrega_Reporte_Expediente1_idx
    on entrega_reporte (ID_Estudiante, ID_Periodo);

create index fk_Expediente_Periodo1_idx
    on expediente (ID_Periodo);

create table profesor
(
    ID_Profesor  int auto_increment
        primary key,
    nombre       varchar(100) not null,
    num_personal int          not null,
    ID_Usuario   int          null,
    constraint fk_Profesor_Usuario1
        foreign key (ID_Usuario) references usuario (ID_Usuario)
);

create index fk_Profesor_Usuario1_idx
    on profesor (ID_Usuario);

create table reporte_mensual
(
    ID_Reporte_Mensual int auto_increment,
    mes                enum ('Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic') not null,
    horas_reportadas   int                                                                                       not null,
    estado             enum ('Pendiente', 'Entregado', 'Aceptado', 'Rechazado')                                  not null,
    observaciones      text                                                                                      null,
    reporte            longblob                                                                                  null,
    ID_Entrega_Reporte int                                                                                       not null,
    primary key (ID_Reporte_Mensual, ID_Entrega_Reporte),
    constraint fk_Reporte_Mensual_Entrega_Reporte1
        foreign key (ID_Entrega_Reporte) references entrega_reporte (ID_Entrega_Reporte)
);

create index fk_Reporte_Mensual_Entrega_Reporte1_idx
    on reporte_mensual (ID_Entrega_Reporte);

create table rubrica_presentacion
(
    ID_Presentacion int auto_increment,
    fecha_hora      datetime     not null,
    calificacion    float        null,
    observaciones   varchar(500) null,
    ID_Estudiante   int          not null,
    ID_Periodo      int          not null,
    ID_Profesor     int          not null,
    primary key (ID_Presentacion, ID_Estudiante, ID_Periodo, ID_Profesor),
    constraint fk_Rubrica_Presentacion_Expediente1
        foreign key (ID_Estudiante, ID_Periodo) references expediente (ID_Estudiante, ID_Periodo),
    constraint fk_Rubrica_Presentacion_Profesor1
        foreign key (ID_Profesor) references profesor (ID_Profesor)
);

create index fk_Rubrica_Presentacion_Expediente1_idx
    on rubrica_presentacion (ID_Estudiante, ID_Periodo);

create index fk_Rubrica_Presentacion_Profesor1_idx
    on rubrica_presentacion (ID_Profesor);

create
    definer = root@localhost procedure insertar_EE(IN nrc_in int, IN nombre_in varchar(100), IN ID_PERIODO_in int)
    sql security invoker
BEGIN
    INSERT INTO experiencia_educativa
    (
        nrc, nombre, ID_PERIODO
    )
    VALUES
    (
        nrc_in, nombre_in, ID_PERIODO_in
    );
END;

create
    definer = root@localhost procedure insertar_periodo(IN abreviatura_in varchar(20), IN fecha_inicio_in date,
                                                        IN fecha_fin_in date) sql security invoker
BEGIN
    INSERT INTO periodo
    (
        abreviatura, fecha_inicio, fecha_fin
    )
    VALUES
    (
        abreviatura_in, fecha_inicio_in, fecha_fin_in
    );
END;

create
    definer = root@localhost procedure insertar_usuario(IN username_in varchar(45), IN password_in varchar(45),
                                                        IN tipo_usuario_in varchar(20), IN activo_in tinyint)
    sql security invoker
BEGIN
    INSERT INTO usuario
    (
        username, password, tipo_usuario, activo
    )
    VALUES
    (
        username_in,
        AES_ENCRYPT(password_in, '3sk0lAr?p4S5', '', 'hkdf'),
        tipo_usuario_in,
        activo_in
    );
END;