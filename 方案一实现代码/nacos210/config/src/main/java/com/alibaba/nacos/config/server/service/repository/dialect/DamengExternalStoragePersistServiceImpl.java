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

import com.alibaba.nacos.config.server.configuration.ConditionOnExternalStorage;
import com.alibaba.nacos.multidatasource.condition.ConditionOnExternalDamengStorage;
import org.springframework.context.annotation.Conditional;
import org.springframework.stereotype.Component;

/**
 * Dameng External Storage Persist Service.
 *
 * @author Long Yu
 */
@SuppressWarnings(value = {"PMD.MethodReturnWrapperTypeRule", "checkstyle:linelength"})
@Conditional(value = {ConditionOnExternalStorage.class, ConditionOnExternalDamengStorage.class})
@Component
public class DamengExternalStoragePersistServiceImpl extends OracleExternalStoragePersistServiceImpl {


}
