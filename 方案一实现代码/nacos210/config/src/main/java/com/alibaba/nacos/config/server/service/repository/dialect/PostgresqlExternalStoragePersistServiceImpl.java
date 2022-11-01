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

package com.alibaba.nacos.config.server.service.repository.dialect;

import com.alibaba.nacos.config.server.service.repository.extrnal.ExternalStoragePaginationHelperImpl;
import com.alibaba.nacos.multidatasource.condition.ConditionOnExternalPostgresqlStorage;
import com.alibaba.nacos.config.server.configuration.ConditionOnExternalStorage;
import com.alibaba.nacos.config.server.model.ConfigInfo;
import com.alibaba.nacos.config.server.service.repository.PersistService;
import com.alibaba.nacos.config.server.utils.LogUtil;
import org.springframework.context.annotation.Conditional;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;
import java.util.concurrent.TimeUnit;


/**
 * Postgresql External Storage Persist Service.
 *
 * @author Long Yu
 */
@SuppressWarnings(value = {"PMD.MethodReturnWrapperTypeRule", "checkstyle:linelength"})
@Conditional(value = {ConditionOnExternalStorage.class, ConditionOnExternalPostgresqlStorage.class})
@Component
public class PostgresqlExternalStoragePersistServiceImpl extends DefaultDialectExternalStoragePersistServiceImpl implements PersistService {

    @Override
    public void removeConfigHistory(final Timestamp startTime, final int limitSize) {
        //to do develop limit contro
        String sql = "WITH temp_table as (SELECT id FROM his_config_info WHERE gmt_modified < ? LIMIT ? ) " +
                "DELETE FROM his_config_info WHERE id in (SELECT id FROM temp_table) ";
        ExternalStoragePaginationHelperImpl<ConfigInfo> paginationHelper = (ExternalStoragePaginationHelperImpl<ConfigInfo>) createPaginationHelper();
        int count;
        try {
            count = paginationHelper.updateLimitWithResponse(sql, new Object[] {startTime, limitSize});
            while (count > 0) {
                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException e) {
                    LogUtil.FATAL_LOG.error("[interrupt-error] " + e, e);
                }
                count = paginationHelper.updateLimitWithResponse(sql, new Object[] {startTime, limitSize});
            }
        } catch (CannotGetJdbcConnectionException e) {
            LogUtil.FATAL_LOG.error("[db-error] " + e, e);
            throw e;
        }
    }

}
