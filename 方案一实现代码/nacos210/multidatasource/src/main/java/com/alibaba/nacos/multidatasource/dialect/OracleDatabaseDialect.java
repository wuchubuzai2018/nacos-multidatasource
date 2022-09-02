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

package com.alibaba.nacos.multidatasource.dialect;

/**
 * oracle database dialect.
 * @author Long Yu
 */
public class OracleDatabaseDialect extends AbstractDatabaseDialect {

    @Override
    public String getType() {
        return "oracle";
    }

    @Override
    public String getTestQuery() {
        return " SELECT 1 FROM DUAL ";
    }

    @Override
    public String getLimitTopSql(String sql) {
        return "SELECT * FROM ( " + sql + " ) t WHERE ROWNUM <= ? ";
    }

    @Override
    public String getLimitPageSql(String sql) {
        StringBuffer pageSql = new StringBuffer(" SELECT * FROM ( SELECT T.*, ROWNUM RN FROM ( ")
                .append(sql).append(" ) T WHERE ROWNUM <= ? )  WHERE RN >= ? ");
        return pageSql.toString();
    }

    @Override
    public String getLimitPageSql(String sql, int pageNo, int pageSize) {
        int maxNum = getPagePrevNum(pageNo, pageSize);
        int minNum = getPageLastNum(pageNo, pageSize);
        StringBuffer pageSql = new StringBuffer(" SELECT * FROM ( SELECT T.*, ROWNUM RN FROM ( ")
                .append(sql).append(" ) T WHERE ROWNUM <= ").append(maxNum).append(" )  WHERE RN >= ").append(minNum);
        return pageSql.toString();
    }

    @Override
    public int getPagePrevNum(int page, int pageSize) {
        return page * pageSize;
    }

    @Override
    public int getPageLastNum(int page, int pageSize) {
        return (page - 1) * pageSize + 1;
    }

}
