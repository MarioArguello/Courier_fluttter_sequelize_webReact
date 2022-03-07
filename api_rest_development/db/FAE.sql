   drop index AK1_AUDITORIA CASCADE;
   drop table auditorias CASCADE;
   drop index AK2_COMEDOR CASCADE;
   drop index AK1_COMEDOR CASCADE;
   drop table comedores CASCADE;
   drop index AK2_GRADO CASCADE;
   drop index AK1_GRADO CASCADE;
   drop table grados CASCADE;
   drop index AK1_MENU CASCADE;
   drop table menus CASCADE;
   drop index AK2_MENUDIA CASCADE;
   drop index AK1_MENUDIA CASCADE;
   drop table menudias CASCADE;
   drop index AK4_PERSONA CASCADE;
   drop index AK3_PERSONA CASCADE;
   drop index AK2_PERSONA CASCADE;
   drop index AK1_PERSONA CASCADE;
   drop table personas CASCADE;
   drop index AK2_REPARTO CASCADE;
   drop index AK1_REPARTO CASCADE;
   drop table repartos CASCADE;
   drop index AK1_RESERVA CASCADE;
   drop table reservas CASCADE;
   drop index AK2_ROL CASCADE;
   drop index AK1_ROL CASCADE;
   drop table roles CASCADE;
   drop index AK2_TIPORANCHO CASCADE;
   drop index AK1_TIPORANCHO CASCADE;
   drop table tiporanchos CASCADE;
   drop index AK2_UNIDAD CASCADE;
   drop index AK1_UNIDAD CASCADE;
   drop table unidad CASCADE;
   drop index AK2_USUARIO CASCADE;
   drop index AK1_USUARIO CASCADE;
   drop table usuarios CASCADE;
   drop index AK1_USUARIOREPARTO CASCADE;
   drop table usuariorepartos CASCADE;
   drop index AK2_USUARIOROL CASCADE;
   drop index AK1_USUARIOROL CASCADE;
   drop table usuarioroles CASCADE;
   drop table comedores CASCADE;
  
   /*==============================================================*/
   /* Table: AUDITORIA                                             */
   /*==============================================================*/
   create table AUDITORIA (
      IDAUDITORIA          SERIAL               not null,
      USUARIO              VARCHAR(100)          not null,
      ACCION               CHAR                 null,
      REGISTRO             VARCHAR(500)         null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_AUDITORIA primary key (IDAUDITORIA)
   );

   /*==============================================================*/
   /* Index: AK1_AUDITORIA                                         */
   /*==============================================================*/
   create unique index AK1_AUDITORIA on AUDITORIA (
   IDAUDITORIA
   );
  
     /*==============================================================*/
   /* Table: COMEDOR                                               */
   /*==============================================================*/
   create table COMEDOR (
      IDCOMEDOR            SERIAL               not null,
      IDREPARTO            INT4                 not null,
      NOMBRE               VARCHAR(100)         not null,
      ESTADO               CHAR                 not null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_COMEDOR primary key (IDCOMEDOR)
   );

   /*==============================================================*/
   /* Index: AK1_COMEDOR                                           */
   /*==============================================================*/
   create unique index AK1_COMEDOR on COMEDOR (
   IDCOMEDOR
   );

   /*==============================================================*/
   /* Index: AK2_COMEDOR                                           */
   /*==============================================================*/
   create  index AK2_COMEDOR on COMEDOR (
   IDREPARTO,
   NOMBRE,
   ESTADO
   );
  
  --
  
     /*==============================================================*/
   /* Table: GRADO                                                 */
   /*==============================================================*/
   create table GRADO (
      IDGRADO              SERIAL               not null,
      NOMBRE               VARCHAR(25)          not null,
      NOMBRECORTO          VARCHAR(15)           not null,
      UTC                  TIMESTAMP            not null default now(),
      constraint PK_GRADO primary key (IDGRADO)
   );

   /*==============================================================*/
   /* Index: AK1_GRADO                                             */
   /*==============================================================*/
   create unique index AK1_GRADO on GRADO (
   IDGRADO
   );

   /*==============================================================*/
   /* Index: AK2_GRADO                                             */
   /*==============================================================*/
   create  index AK2_GRADO on GRADO (
   NOMBRE
   );
  
  
  ---
  
   /*==============================================================*/
   /* Table: MENU                                                  */
   /*==============================================================*/
   create table MENU (
      IDMENU               SERIAL               not null,
      DESCRIPCION          VARCHAR(200)         not null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_MENU primary key (IDMENU)
   );

   /*==============================================================*/
   /* Index: AK1_MENU                                              */
   /*==============================================================*/
   create unique index AK1_MENU on MENU (
   IDMENU
   );

   /*==============================================================*/
   /* Index: AK2_MENU                                              */
   /*==============================================================*/
   create  index AK2_MENUS on MENU (
   DESCRIPCION
   );
  
  ---
  
     /*==============================================================*/
   /* Table: MENUDIA                                               */
   /*==============================================================*/
   create table MENUDIA (
      IDMENUDIA            SERIAL               not null,
      IDTIPORANCHO         INT4                 not null,
      IDMENU               INT4                 not null,
      IDCOMEDOR            INT4                 not null,
      FECHA                DATE                 not null,
      PRECIO               DECIMAL(5,2)         not null,
      ESTADO               CHAR                 not null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_MENUDIA primary key (IDMENUDIA)
   );

   /*==============================================================*/
   /* Index: AK1_MENUDIA                                           */
   /*==============================================================*/
   create unique index AK1_MENUDIA on MENUDIA (
   IDMENUDIA
   );

   /*==============================================================*/
   /* Index: AK2_MENUDIA                                           */
   /*==============================================================*/
   create  index AK2_MENUDIA on MENUDIA (
   IDTIPORANCHO,
   FECHA
   );
  
  --
  
     /*==============================================================*/
   /* Table: PERSONA                                               */
   /*==============================================================*/

   create table PERSONA (
      IDPERSONA            SERIAL               not null,
      IDREPARTO            INT4                 not null,
      IDGRADO              INT4                 not null,
      NOMBRES              VARCHAR(100)         not null,
      TELEFONO             VARCHAR(15)          not null,
      CORREO               VARCHAR(100)          not null,
      SEXO                 CHAR                 not null,
      DNI                  VARCHAR(10)          not null,
      ESTADO               CHAR                 not null,
      UTC                  TIMESTAMP            not null default now(),
      constraint PK_PERSONA primary key (IDPERSONA)
   );

   /*==============================================================*/
   /* Index: AK1_PERSONA                                           */
   /*==============================================================*/
   create unique index AK1_PERSONA on PERSONA (
   IDPERSONA
   );

   /*==============================================================*/
   /* Index: AK2_PERSONA                                           */
   /*==============================================================*/
   create  index AK2_PERSONA on PERSONA (
   IDPERSONA,
   IDGRADO
   );

   /*==============================================================*/
   /* Index: AK3_PERSONA                                           */
   /*==============================================================*/
   create  index AK3_PERSONA on PERSONA (
   IDPERSONA,
   IDREPARTO,
   ESTADO
   );

   /*==============================================================*/
   /* Index: AK4_PERSONA                                           */
   /*==============================================================*/
   create  index AK4_PERSONA on PERSONA (
   DNI
   );
  
  --
     /*==============================================================*/
   /* Table: REPARTO                                               */
   /*==============================================================*/
   create table REPARTO (
      IDREPARTO            SERIAL               not null,
      IDUNIDAD             INT4                 not null,
      UTC                  TIMESTAMP            not null	default now(),
      NOMBRE               VARCHAR(75)          not null,
      CODIGO               VARCHAR(5)           not null,
      constraint PK_REPARTO primary key (IDREPARTO)
   );

   /*==============================================================*/
   /* Index: AK1_REPARTO                                           */
   /*==============================================================*/
   create unique index AK1_REPARTO on REPARTO (
   IDREPARTO
   );

   /*==============================================================*/
   /* Index: AK2_REPARTO                                           */
   /*==============================================================*/
   create unique index AK2_REPARTO on REPARTO (
   NOMBRE,
   IDUNIDAD
   );

  --
  
     /*==============================================================*/
   /* Table: RESERVA                                               */
   /*==============================================================*/
   create table RESERVA (
      IDRESERVA            SERIAL               not null,
      IDMENUDIA            INT4                 not null,
      IDPERSONA            INT4                 not null,
      ESTADO               CHAR                 not null,
      CANTIDAD             DECIMAL(5,2)         not null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_RESERVA primary key (IDRESERVA)
   );

   /*==============================================================*/
   /* Index: AK1_RESERVA                                           */
   /*==============================================================*/
   create unique index AK1_RESERVA on RESERVA (
   IDRESERVA
   );
   
  --
     /*==============================================================*/
   /* Table: ROL                                                   */
   /*==============================================================*/
   create table ROL (
      IDROL                SERIAL               not null,
      NOMBRE               VARCHAR(50)          not null,
      ESTADO               CHAR                 not null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_ROL primary key (IDROL)
   );

   /*==============================================================*/
   /* Index: AK1_ROL                                               */
   /*==============================================================*/
   create unique index AK1_ROL on ROL (
   IDROL
   );

   /*==============================================================*/
   /* Index: AK2_ROL                                               */
   /*==============================================================*/
   create  index AK2_ROL on ROL (
   NOMBRE,
   ESTADO
   );
   
  --
  
     /*==============================================================*/
   /* Table: TIPORANCHO                                            */
   /*==============================================================*/
   create table TIPORANCHO (
      IDTIPORANCHO         SERIAL               not null,
      NOMBRE               VARCHAR(100)         not null,
      ESTADO               CHAR                 not null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_TIPORANCHO primary key (IDTIPORANCHO)
   );

   /*==============================================================*/
   /* Index: AK1_TIPORANCHO                                        */
   /*==============================================================*/
   create unique index AK1_TIPORANCHO on TIPORANCHO (
   IDTIPORANCHO
   );

   /*==============================================================*/
   /* Index: AK2_TIPORANCHO                                        */
   /*==============================================================*/
   create  index AK2_TIPORANCHO on TIPORANCHO (
   NOMBRE,
   ESTADO
   );
   
  --
  
     /*==============================================================*/
   /* Table: UNIDAD                                                */
   /*==============================================================*/
   create table UNIDAD (
      IDUNIDAD             SERIAL               not null,
      UTC                  TIMESTAMP            not null default NOW(),
      NOMBRE               VARCHAR(50)          not null,
      CODIGO               VARCHAR(5)           not null,
      constraint PK_UNIDAD primary key (IDUNIDAD)
   );

   /*==============================================================*/
   /* Index: AK1_UNIDAD                                            */
   /*==============================================================*/
   create unique index AK1_UNIDAD on UNIDAD (
   IDUNIDAD
   );

   /*==============================================================*/
   /* Index: AK2_UNIDAD                                            */
   /*==============================================================*/
   create  index AK2_UNIDAD on UNIDAD (
   NOMBRE,
   CODIGO
   );
   
  --
  
     /*==============================================================*/
   /* Table: USUARIO                                               */
   /*==============================================================*/
   create table USUARIO (
      IDUSUARIO            SERIAL               not null,
      IDPERSONA            INT4                 not null,
      USERNAME             VARCHAR(50)          not null,
      PASSWORD             VARCHAR(60)         not null,
      ESTADO               CHAR                 null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_USUARIO primary key (IDUSUARIO)
   );

   /*==============================================================*/
   /* Index: AK1_USUARIO                                           */
   /*==============================================================*/
   create unique index AK1_USUARIO on USUARIO (
   IDUSUARIO
   );

   /*==============================================================*/
   /* Index: AK2_USUARIO                                           */
   /*==============================================================*/
   create  index AK2_USUARIO on USUARIO (
   IDPERSONA,
   ESTADO
   );
   
  --
  
     /*==============================================================*/
   /* Table: USUARIOREPARTO                                        */
   /*==============================================================*/
   create table USUARIOREPARTO (
      IDUSUARIOREPARTO     SERIAL               not null,
      IDUSUARIO            INT4                 not null,
      IDREPARTO            INT4                 not null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_USUARIOREPARTO primary key (IDUSUARIOREPARTO)
   );

   /*==============================================================*/
   /* Index: AK1_USUARIOREPARTO                                    */
   /*==============================================================*/
   create unique index AK1_USUARIOREPARTO on USUARIOREPARTO (
   IDUSUARIOREPARTO
   );
   
  --
  
     /*==============================================================*/
   /* Table: USUARIOROL                                            */
   /*==============================================================*/
   create table USUARIOROL (
      IDUSUARIOROL         SERIAL               not null,
      IDUSUARIO            INT4                 not null,
      IDROL                INT4                 not null,
      ESTADO               CHAR                 not null,
      UTC                  TIMESTAMP            not null	default now(),
      constraint PK_USUARIOROL primary key (IDUSUARIOROL)
   );

   /*==============================================================*/
   /* Index: AK1_USUARIOROL                                        */
   /*==============================================================*/
   create unique index AK1_USUARIOROL on USUARIOROL (
   IDUSUARIOROL
   );

   /*==============================================================*/
   /* Index: AK2_USUARIOROL                                        */
   /*==============================================================*/
   create  index AK2_USUARIOROL on USUARIOROL (
   ESTADO,
   IDUSUARIO,
   IDROL
   );
   
     alter table COMEDOR
      add constraint FK_COMEDOR_REPARTO foreign key (IDREPARTO)
         references REPARTO (IDREPARTO)
         on delete restrict on update restrict;

   alter table MENUDIA
      add constraint FK_MENUDIA_COMEDOR foreign key (IDCOMEDOR)
         references COMEDOR (IDCOMEDOR)
         on delete restrict on update restrict;

   alter table MENUDIA
      add constraint FK_MENUDIA_MENU foreign key (IDMENU)
         references MENU (IDMENU)
         on delete restrict on update restrict;

   alter table MENUDIA
      add constraint FK_MENUDIA_TIPORANCHO foreign key (IDTIPORANCHO)
         references TIPORANCHO (IDTIPORANCHO)
         on delete restrict on update restrict;

   alter table PERSONA
      add constraint FK_PERSONA_GRADO foreign key (IDGRADO)
         references GRADO (IDGRADO)
         on delete restrict on update restrict;

   alter table PERSONA
      add constraint FK_PERSONA_REPARTO foreign key (IDREPARTO)
         references REPARTO (IDREPARTO)
         on delete restrict on update restrict;

   alter table REPARTO
      add constraint FK_REPARTO_UNIDAD foreign key (IDUNIDAD)
         references UNIDAD (IDUNIDAD)
         on delete restrict on update restrict;

   alter table RESERVA
      add constraint FK_RESERVA_MENUDIA foreign key (IDMENUDIA)
         references MENUDIA (IDMENUDIA)
         on delete restrict on update restrict;

   alter table RESERVA
      add constraint FK_RESERVA_PERSONA foreign key (IDPERSONA)
         references PERSONA (IDPERSONA)
         on delete restrict on update restrict;

   alter table USUARIO
      add constraint FK_USUARIO_PERSONA foreign key (IDPERSONA)
         references PERSONA (IDPERSONA)
         on delete restrict on update restrict;

   alter table USUARIOREPARTO
      add constraint FK_USUARIOREPARTO_REPARTO foreign key (IDREPARTO)
         references REPARTO (IDREPARTO)
         on delete restrict on update restrict;

   alter table USUARIOREPARTO
      add constraint FK_USUARIOREPARTO_USUARIO foreign key (IDUSUARIO)
         references USUARIO (IDUSUARIO)
         on delete restrict on update restrict;

   alter table USUARIOROL
      add constraint FK_USUARIOROL_ROL foreign key (IDROL)
         references ROL (IDROL)
         on delete restrict on update restrict;

   alter table USUARIOROL
      add constraint FK_USUARIOROL_USUARIO foreign key (IDUSUARIO)
         references USUARIO (IDUSUARIO)
         on delete restrict on update restrict;