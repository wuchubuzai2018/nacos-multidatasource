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

package com.alibaba.nacos.multidatasource.dialect;

/**
 * Abstract DatabaseDialect.
 * Default limit for mysql,postgresql
 * @author Long Yu
 */
public abstract class AbstractDatabaseDialect implements DatabaseDialect {

    @Override
    public String getTestQuery() {
        return " SELECT 1";
    }

    @Override
    public String getLimitTopSql(String sql) {
        return sql + " LIMIT ? ";
    }

    @Override
    public String getLimitPageSql(String sql) {
        return sql + "  OFFSET ? LIMIT ? ";
    }

    @Override
    public String getLimitPageSql(String sql, int pageNo, int pageSize) {
        return sql + "  OFFSET " + getPagePrevNum(pageNo, pageSize) + " LIMIT " + pageSize;
    }

    @Override
    public int getPagePrevNum(int page, int pageSize) {
        return (page - 1) * pageSize;
    }

    @Override
    public int getPageLastNum(int page, int pageSize) {
        return pageSize;
    }

}
