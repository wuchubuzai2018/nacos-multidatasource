/*
 * Copyright 1999-2018 Alibaba Group Holding Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

CREATE TABLE CONFIG_INFO (
    ID NUMBER ( 20, 0 ) not NULL ,
    DATA_ID VARCHAR2 ( 255 ) NOT NULL,
    GROUP_ID VARCHAR2 ( 255 ) DEFAULT '',
    CONTENT CLOB NOT NULL,
    MD5 VARCHAR2 ( 32 ),
    GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
    GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    SRC_USER CLOB,
    SRC_IP VARCHAR2 ( 50 ) DEFAULT '',
    APP_NAME VARCHAR2 ( 128 ) DEFAULT '',
    TENANT_ID VARCHAR2 ( 128 ) DEFAULT '',
    C_DESC VARCHAR2 ( 256 ) DEFAULT '',
    C_USE VARCHAR2 ( 64 ) DEFAULT '',
    EFFECT VARCHAR2 ( 64 ) DEFAULT '',
    TYPE VARCHAR2 ( 64 ) DEFAULT '',
    C_SCHEMA CLOB,
    encrypted_data_key CLOB DEFAULT '',
    CONSTRAINT CI_PK_ID PRIMARY KEY ( ID ),
    CONSTRAINT UK_CONFIGINFO_DATAGROUPTENANT UNIQUE ( DATA_ID, GROUP_ID, TENANT_ID )
);
CREATE TABLE CONFIG_INFO_AGGR (
    ID NUMBER ( 20, 0 ) not NULL,
    DATA_ID VARCHAR2 ( 255 ) NOT NULL,
    GROUP_ID VARCHAR2 ( 255 ) NOT NULL,
    DATUM_ID VARCHAR2 ( 255 ) NOT NULL,
    CONTENT CLOB NOT NULL,
    GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    APP_NAME VARCHAR2 ( 128 ) DEFAULT '',
    TENANT_ID VARCHAR2 ( 128 ) DEFAULT '',
    CONSTRAINT CIA_PK_ID PRIMARY KEY ( ID ),
    CONSTRAINT UK_CIA_DATAGROUPTENANTDATUM UNIQUE ( DATA_ID, GROUP_ID, TENANT_ID, DATUM_ID )
);
CREATE TABLE CONFIG_INFO_BETA (
    ID NUMBER ( 20, 0 ) not NULL,
    DATA_ID VARCHAR2 ( 255 ) NOT NULL,
    GROUP_ID VARCHAR2 ( 128 ) NOT NULL,
    APP_NAME VARCHAR2 ( 128 ) DEFAULT '',
    CONTENT CLOB NOT NULL,
    BETA_IPS VARCHAR2 ( 1024 ) DEFAULT '',
    MD5 VARCHAR2 ( 32 ) DEFAULT '',
    GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
    GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    SRC_USER CLOB,
    SRC_IP VARCHAR2 ( 50 ),
    TENANT_ID VARCHAR2 ( 128 ) DEFAULT '',
     encrypted_data_key CLOB DEFAULT '',
    CONSTRAINT CIB_PK_ID PRIMARY KEY ( ID ),
    CONSTRAINT UK_CIB_DATAGROUPTENANT UNIQUE ( DATA_ID, GROUP_ID, TENANT_ID )
);
CREATE TABLE CONFIG_INFO_TAG (
    ID NUMBER ( 20, 0 ) not NULL ,
    DATA_ID VARCHAR2 ( 255 ) NOT NULL,
    GROUP_ID VARCHAR2 ( 128 ) NOT NULL,
    TENANT_ID VARCHAR2 ( 128 ) DEFAULT '',
    TAG_ID VARCHAR2 ( 128 ) NOT NULL,
    APP_NAME VARCHAR2 ( 128 ) DEFAULT '',
    CONTENT CLOB NOT NULL,
    MD5 VARCHAR2 ( 32 ) DEFAULT '',
    GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
    GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    SRC_USER CLOB,
    SRC_IP VARCHAR2 ( 50 ),
    CONSTRAINT CIT_PK_ID PRIMARY KEY ( ID ),
    CONSTRAINT UK_CIT_DATAGROUPTENANTTAG UNIQUE ( DATA_ID, GROUP_ID, TENANT_ID, TAG_ID )
);
CREATE TABLE CONFIG_TAGS_RELATION (
    ID NUMBER ( 20, 0 ) not NULL,
    TAG_NAME VARCHAR2 ( 128 ) NOT NULL,
    TAG_TYPE VARCHAR2 ( 64 ) DEFAULT '',
    DATA_ID VARCHAR2 ( 255 ) NOT NULL,
    GROUP_ID VARCHAR2 ( 128 ) NOT NULL,
    TENANT_ID VARCHAR2 ( 128 ) DEFAULT '',
    NID NUMBER ( 20, 0 ) NOT NULL,
    CONSTRAINT CTR_PK_ID PRIMARY KEY ( NID ),
    CONSTRAINT UK_CTR_CONFIGIDTAG UNIQUE ( ID, TAG_NAME, TAG_TYPE )
);
CREATE INDEX IDX_CTR_TENANT_ID ON CONFIG_TAGS_RELATION ( TENANT_ID );
CREATE TABLE GROUP_CAPACITY (
    ID NUMBER ( 20, 0 ) not NULL ,
    GROUP_ID VARCHAR2 ( 128 ) DEFAULT '' NOT NULL,
    QUOTA NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    USAGE NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    MAX_SIZE NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    MAX_AGGR_COUNT NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    MAX_AGGR_SIZE NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    MAX_HISTORY_COUNT NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
    GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    CONSTRAINT GC_PK_ID PRIMARY KEY ( ID ),
    CONSTRAINT UK_GC_GROUP_ID UNIQUE ( GROUP_ID )
);
CREATE TABLE HIS_CONFIG_INFO (
    ID NUMBER ( 20, 0 ) NOT NULL,
    NID NUMBER ( 20, 0 ) not NULL,
    DATA_ID VARCHAR2 ( 255 ) NOT NULL,
    GROUP_ID VARCHAR2 ( 128 ) NOT NULL,
    APP_NAME VARCHAR2 ( 128 ) DEFAULT '',
    CONTENT CLOB NOT NULL,
    MD5 VARCHAR2 ( 32 ) DEFAULT '',
    GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
    GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    SRC_USER CLOB,
    SRC_IP VARCHAR2 ( 50 ) DEFAULT '',
    OP_TYPE CHAR ( 10 ) DEFAULT '',
    TENANT_ID VARCHAR2 ( 128 ) DEFAULT '',
     encrypted_data_key CLOB DEFAULT '',
    CONSTRAINT HCI_PK_ID PRIMARY KEY ( NID )
);
CREATE INDEX IDX_HCI_GMT_CREATE ON HIS_CONFIG_INFO ( GMT_CREATE );
CREATE INDEX IDX_HCI_GMT_MODIFIED ON HIS_CONFIG_INFO ( GMT_MODIFIED );
CREATE INDEX IDX_HCI_DID ON HIS_CONFIG_INFO ( DATA_ID );


CREATE TABLE TENANT_CAPACITY (
    ID NUMBER ( 20, 0 ) not NULL,
    TENANT_ID VARCHAR2 ( 128 ) DEFAULT '' NOT NULL,
    QUOTA NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    USAGE NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    MAX_SIZE NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    MAX_AGGR_COUNT NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    MAX_AGGR_SIZE NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    MAX_HISTORY_COUNT NUMBER ( 10, 0 ) DEFAULT 0 NOT NULL,
    GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
    GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    CONSTRAINT TC_PK_ID PRIMARY KEY ( ID ),
    CONSTRAINT UK_TC_TENANT_ID UNIQUE ( TENANT_ID )
);
CREATE TABLE TENANT_INFO (
    ID NUMBER ( 20, 0 ) not NULL,
    KP VARCHAR2 ( 128 ) NOT NULL,
    TENANT_ID VARCHAR2 ( 128 ) DEFAULT '',
    TENANT_NAME VARCHAR2 ( 128 ) DEFAULT '',
    TENANT_DESC VARCHAR2 ( 256 ) DEFAULT '',
    CREATE_SOURCE VARCHAR2 ( 32 ) DEFAULT '',
    GMT_CREATE NUMBER(20,0) NOT NULL,
    GMT_MODIFIED NUMBER(20,0) NOT NULL,
    CONSTRAINT TI_PK_ID PRIMARY KEY ( ID ),
    CONSTRAINT UK_TENANT_INFO_KPTENANTID UNIQUE ( KP, TENANT_ID )
);
CREATE INDEX IDX_TI_TENANT_ID ON TENANT_INFO ( TENANT_ID );
CREATE TABLE USERS (
    USERNAME VARCHAR2 ( 50 ) NOT NULL,
    PASSWORD VARCHAR2 ( 500 ) NOT NULL,
    ENABLED  NUMBER ( 1, 0 ) DEFAULT 1 NOT NULL,
    CONSTRAINT USERS_PK_NAME PRIMARY KEY ( USERNAME )
);
CREATE TABLE ROLES (
    USERNAME VARCHAR2 ( 50 ) NOT NULL,
    ROLE VARCHAR2 ( 50 ) NOT NULL,
    CONSTRAINT UK_USERNAME_ROLE UNIQUE ( USERNAME, ROLE )
);
CREATE TABLE PERMISSIONS (
    ROLE VARCHAR2 ( 50 ) NOT NULL,
    "RESOURCE" VARCHAR2 ( 512 ) NOT NULL,
    ACTION VARCHAR2 ( 8 ) NOT NULL,
    CONSTRAINT UK_ROLE_PERMISSION UNIQUE ( ROLE, "RESOURCE", ACTION )
);
INSERT INTO USERS ( USERNAME, PASSWORD, ENABLED ) VALUES( 'nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1 );
INSERT INTO ROLES ( USERNAME, ROLE ) VALUES   ( 'nacos', 'ROLE_ADMIN' );

create sequence seq_config_info;
create or replace trigger tg_config_info
--before:执行DML等操作之前触发
before insert on config_info
--行级触发器
for each row
begin
    select seq_config_info.nextval into :new.id from dual;
end;
/
create sequence seq_config_tags_relation;
create or replace trigger tg_config_tags_relation
--before:执行DML等操作之前触发
before insert on config_tags_relation
--行级触发器
for each row
begin
    select seq_config_tags_relation.nextval into :new.nid from dual;
end;
/
create sequence seq_config_info_aggr;
create or replace trigger tg_config_info_aggr
--before:
before insert on config_info_aggr
--行级触发器
for each row
begin
    select seq_config_info_aggr.nextval into :new.id from dual;
end;
/
create sequence seq_config_info_beta;
create or replace trigger tg_config_info_beta
--before:
before insert on config_info_beta
--行级触发器
for each row
begin
    select seq_config_info_beta.nextval into :new.id from dual;
end;
/
create sequence seq_config_info_tag;
create or replace trigger tg_config_info_tag
--before:
before insert on config_info_tag
--行级触发器
for each row
begin
    select seq_config_info_tag.nextval into :new.id from dual;
end;
/
create sequence seq_group_capacity;
create or replace trigger tg_group_capacity
--before:
before insert on group_capacity
--行级触发器
for each row
begin
    select seq_group_capacity.nextval into :new.id from dual;
end;
/
create sequence seq_his_config_info;
create or replace trigger tg_his_config_info
--before:
before insert on his_config_info
--行级触发器
for each row
begin
    select seq_his_config_info.nextval into :new.nid from dual;
end;
/
create sequence seq_tenant_capacity;
create or replace trigger tg_tenant_capacity
--before:
before insert on tenant_capacity
--行级触发器
for each row
begin
    select seq_tenant_capacity.nextval into :new.id from dual;
end;
/
create sequence seq_tenant_info;
create or replace trigger tg_tenant_info
--before:
before insert on tenant_info
--行级触发器
for each row
begin
    select seq_tenant_info.nextval into :new.id from dual;
end;
/