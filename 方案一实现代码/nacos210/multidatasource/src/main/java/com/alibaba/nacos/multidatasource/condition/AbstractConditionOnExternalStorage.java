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

package com.alibaba.nacos.multidatasource.condition;

import org.springframework.context.annotation.Condition;
import org.springframework.context.annotation.ConditionContext;
import org.springframework.core.env.Environment;

/**
 * Abstract ExternalStorage by condition.
 *
 * @author Long Yu
 */
public abstract class  AbstractConditionOnExternalStorage implements Condition {

    private static final String DATASOURCE_PLATFORM_PROPERTY = "spring.datasource.platform";

    private static final String DEFAULT_DATASOURCE_PLATFORM = "";

    public String getPlatform(ConditionContext context) {
        Environment environment = context.getEnvironment();
        // External data sources are used by default in cluster mode
        String platform = environment.getProperty(DATASOURCE_PLATFORM_PROPERTY, "");
        return platform;
    }

}
