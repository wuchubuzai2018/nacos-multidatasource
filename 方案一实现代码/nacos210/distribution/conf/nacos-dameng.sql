/*
 * Copyright 1999-2022 Alibaba Group Holding Ltd.
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
                             ID BIGINT NOT NULL IDENTITY(1, 1),
                             DATA_ID VARCHAR(255) NOT NULL,
                             GROUP_ID VARCHAR(255),
                             CONTENT CLOB NOT NULL,
                             MD5 VARCHAR(32),
                             GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
                             GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
                             SRC_USER TEXT,
                             SRC_IP VARCHAR(20),
                             APP_NAME VARCHAR(128),
                             TENANT_ID VARCHAR(128) DEFAULT '',
                             C_DESC VARCHAR(256),
                             C_USE VARCHAR(64),
                             EFFECT VARCHAR(64),
                             "TYPE" VARCHAR(64),
                             C_SCHEMA TEXT,
                             ENCRYPTED_DATA_KEY CLOB DEFAULT '',
                             CONSTRAINT CI_PK_ID PRIMARY KEY (ID)
);

CREATE UNIQUE INDEX "uk_configinfo_datagrouptenant" ON CONFIG_INFO (DATA_ID,GROUP_ID,TENANT_ID);


CREATE TABLE CONFIG_INFO_AGGR (
                                  ID BIGINT NOT NULL IDENTITY(1, 1),
                                  DATA_ID VARCHAR(255) NOT NULL,
                                  GROUP_ID VARCHAR(255) NOT NULL,
                                  DATUM_ID VARCHAR(255) NOT NULL,
                                  CONTENT CLOB NOT NULL,
                                  GMT_MODIFIED TIMESTAMP NOT NULL,
                                  APP_NAME VARCHAR(128),
                                  TENANT_ID VARCHAR(128) DEFAULT '',
                                  CONSTRAINT CONS134220CIA_PK_ID045 PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX "uk_configinfoaggr_datagrouptenantdatum" ON CONFIG_INFO_AGGR (DATA_ID,GROUP_ID,TENANT_ID,DATUM_ID);


CREATE TABLE CONFIG_INFO_BETA (
                                  ID BIGINT NOT NULL IDENTITY(1, 1),
                                  DATA_ID VARCHAR(255) NOT NULL,
                                  GROUP_ID VARCHAR(128) NOT NULL,
                                  APP_NAME VARCHAR(128),
                                  CONTENT CLOB NOT NULL,
                                  BETA_IPS VARCHAR(1024),
                                  MD5 VARCHAR(32),
                                  GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
                                  GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
                                  SRC_USER TEXT,
                                  SRC_IP VARCHAR(20),
                                  TENANT_ID VARCHAR(128) DEFAULT '',
                                  ENCRYPTED_DATA_KEY CLOB DEFAULT '',
                                  CONSTRAINT CONS134220043 PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX "uk_configinfobeta_datagrouptenant" ON CONFIG_INFO_BETA (DATA_ID,GROUP_ID,TENANT_ID);


CREATE TABLE CONFIG_INFO_TAG (
                                 ID BIGINT NOT NULL IDENTITY(1, 1),
                                 DATA_ID VARCHAR(255) NOT NULL,
                                 GROUP_ID VARCHAR(128) NOT NULL,
                                 TENANT_ID VARCHAR(128) DEFAULT '',
                                 TAG_ID VARCHAR(128) NOT NULL,
                                 APP_NAME VARCHAR(128),
                                 CONTENT CLOB NOT NULL,
                                 MD5 VARCHAR(32),
                                 GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
                                 GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
                                 SRC_USER TEXT,
                                 SRC_IP VARCHAR(20),
                                 CONSTRAINT CONS134220041 PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX "uk_configinfotag_datagrouptenanttag" ON CONFIG_INFO_TAG (DATA_ID,GROUP_ID,TENANT_ID,TAG_ID);


CREATE TABLE CONFIG_TAGS_RELATION (
                                      ID BIGINT NOT NULL,
                                      TAG_NAME VARCHAR(128) NOT NULL,
                                      TAG_TYPE VARCHAR(64),
                                      DATA_ID VARCHAR(255) NOT NULL,
                                      GROUP_ID VARCHAR(128) NOT NULL,
                                      TENANT_ID VARCHAR(128) DEFAULT '',
                                      NID BIGINT NOT NULL IDENTITY(1, 1),
                                      CONSTRAINT CONS134220039 PRIMARY KEY (NID)
);
CREATE INDEX "idx_tenant_id" ON CONFIG_TAGS_RELATION (TENANT_ID);
CREATE UNIQUE INDEX "uk_configtagrelation_configidtag" ON CONFIG_TAGS_RELATION (ID,TAG_NAME,TAG_TYPE);


CREATE TABLE GROUP_CAPACITY (
                                ID BIGINT NOT NULL IDENTITY(1, 1),
                                GROUP_ID VARCHAR(128) DEFAULT '' NOT NULL,
                                QUOTA BIGINT DEFAULT 0 NOT NULL,
                                "USAGE" BIGINT DEFAULT 0 NOT NULL,
                                MAX_SIZE BIGINT DEFAULT 0 NOT NULL,
                                MAX_AGGR_COUNT BIGINT DEFAULT 0 NOT NULL,
                                MAX_AGGR_SIZE BIGINT DEFAULT 0 NOT NULL,
                                MAX_HISTORY_COUNT BIGINT DEFAULT 0 NOT NULL,
                                GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
                                GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
                                CONSTRAINT CONS134220037 PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX "uk_group_id" ON GROUP_CAPACITY (GROUP_ID);


CREATE TABLE HIS_CONFIG_INFO (
                                 ID DECIMAL(20,0) NOT NULL,
                                 NID BIGINT NOT NULL IDENTITY(1, 1),
                                 DATA_ID VARCHAR(255) NOT NULL,
                                 GROUP_ID VARCHAR(128) NOT NULL,
                                 APP_NAME VARCHAR(128),
                                 CONTENT CLOB NOT NULL,
                                 MD5 VARCHAR(32),
                                 GMT_CREATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
                                 GMT_MODIFIED TIMESTAMP DEFAULT SYSDATE NOT NULL,
                                 SRC_USER TEXT,
                                 SRC_IP VARCHAR(20),
                                 OP_TYPE CHAR(10),
                                 TENANT_ID VARCHAR(128) DEFAULT '',
                                 ENCRYPTED_DATA_KEY CLOB DEFAULT '',
                                 CONSTRAINT CONS134220036 PRIMARY KEY (NID)
);
CREATE INDEX IDX_DID ON HIS_CONFIG_INFO (DATA_ID);
CREATE INDEX IDX_GMT_CREATE ON HIS_CONFIG_INFO (GMT_CREATE);
CREATE INDEX IDX_GMT_MODIFIED ON HIS_CONFIG_INFO (GMT_MODIFIED);


CREATE TABLE TENANT_CAPACITY (
                                 ID BIGINT NOT NULL IDENTITY(1, 1),
                                 TENANT_ID VARCHAR(128) DEFAULT '' NOT NULL,
                                 QUOTA BIGINT DEFAULT 0 NOT NULL,
                                 "USAGE" BIGINT DEFAULT 0 NOT NULL,
                                 MAX_SIZE BIGINT DEFAULT 0 NOT NULL,
                                 MAX_AGGR_COUNT BIGINT DEFAULT 0 NOT NULL,
                                 MAX_AGGR_SIZE BIGINT DEFAULT 0 NOT NULL,
                                 MAX_HISTORY_COUNT BIGINT DEFAULT 0 NOT NULL,
                                 GMT_CREATE TIMESTAMP,
                                 GMT_MODIFIED TIMESTAMP,
                                 CONSTRAINT CONS134220034 PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX "uk_tenant_id" ON TENANT_CAPACITY (TENANT_ID);


CREATE TABLE TENANT_INFO (
                             ID BIGINT NOT NULL IDENTITY(1, 1),
                             KP VARCHAR(128) NOT NULL,
                             TENANT_ID VARCHAR(128) DEFAULT '',
                             TENANT_NAME VARCHAR(128) DEFAULT '',
                             TENANT_DESC VARCHAR(256),
                             CREATE_SOURCE VARCHAR(32),
                             GMT_CREATE BIGINT NOT NULL,
                             GMT_MODIFIED BIGINT NOT NULL,
                             CONSTRAINT CONS134220032 PRIMARY KEY (ID)
);
CREATE INDEX "ti_tenant_id" ON TENANT_INFO (TENANT_ID);
CREATE UNIQUE INDEX "uk_tenant_info_kptenantid" ON TENANT_INFO (KP,TENANT_ID);


CREATE TABLE USERS (
                       USERNAME VARCHAR(50) NOT NULL,
                       PASSWORD VARCHAR(500) NOT NULL,
                       ENABLED TINYINT NOT NULL,
                       CONSTRAINT USERS_PK_NAME PRIMARY KEY (USERNAME)
);

CREATE TABLE ROLES (
                       USERNAME VARCHAR(50) NOT NULL,
                       "ROLE" VARCHAR(50) NOT NULL
);
CREATE UNIQUE INDEX "UK_USERNAME_ROLE" ON ROLES ( USERNAME, ROLE );

CREATE TABLE permissions (
                             role varchar(50) NOT NULL,
                             resource varchar(512) NOT NULL,
                             action varchar(8) NOT NULL
);
CREATE UNIQUE INDEX "uk_role_permission" ON permissions(role,resource,action);


INSERT INTO users (username, password, enabled) VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', TRUE);

INSERT INTO roles (username, role) VALUES ('nacos', 'ROLE_ADMIN');
