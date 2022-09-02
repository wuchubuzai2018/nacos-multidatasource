# 方案一、多种数据库方言实现的注入判断适配
## 一、基本说明

该种方案希望尽量不影响原有的SQL业务逻辑前提下进行实现。目前基于Nacos2.1版本，当前该种方案，在本地开发环境，单机环境和3节点集群环境启动方式已简单的适配核心的PersistService的处理，目前支持MySQL、Oracle、PostgreSQL、达梦。

对于服务注册与配置等基础功能可以实现正常的维护操作。

## 二、开发情况

当前方案基于Nacos2.1.0进行代码实现。

实现对Nacos底层多种数据源的支持，且需要通过配置SPI的方式声明实现，目前已测试单机环境启动支持PostgreSQL、Oracle

、达梦数据库的支持，暂不考虑插件化、动态化，优雅扩展性等。

| 时间   | 状态                                           |
| ------ | ---------------------------------------------- |
| 202206 | 基本骨架流程定义与思考                         |
| 202207 | 单机环境适配PostgreSQL、Oracle、MySQL数据库    |
| 202208 | 测试集群环境相关不兼容代码、增加适配达梦数据库 |

## 三、如何参与当前项目多数据源开发

1、nacos210/multidatasource模块增加数据库驱动pom.xml依赖，对应数据源的基本代码，实现自定义Condition条件注解，实现自定义数据库方言实现。

2、nacos210/config/src/main/java/com/alibaba/nacos/config/server/service/repository/dialect/目录继承相关方言的业务持久化类实现。

3、目前项目支持MySQL\PostgreSQL\Oracle\达梦，在对接其他数据库时，可以先看看和那种比较像，继承已存在的代码，减少重复开发。

## 四、如何使用

使用git克隆项目，然后再本地进行maven打包即可。

### 4.1、使用已打好测试包

百度网盘打包地址：链接: https://pan.baidu.com/s/1H0IiaxtW7rgDgJyWfVD14w 提取码: mcuk 

### 4.2、下载源码自行编译安装与打包命令

```
mvn -Prelease-nacos -Dmaven.test.skip=true -Dpmd.skip=true -Dcheckstyle.skip=true -Drat.skip=true clean install -U  
```

### 4.3、安装包启动

安装后启动即可，安装前根据实际情况，修改application.properties文件中的数据库地址，以及导入如下对应的数据库数据库脚本文件，目前Oracle脚本采用11g触发器的方式设置自增主键。

nacos210/distribution/conf/nacos-oracle.sql

nacos210/distribution/conf/nacos-pg.sql

nacos210/distribution/conf/nacos-mysql.sql

nacos210/distribution/conf/nacos-dameng.sql

## 五、目前发现的兼容性问题处理

### 5.1、通用兼容性解决与设计

1、动态获取驱动配置及JDBC测试查询语句，核心逻辑在ExternalDataSourceProperties文件中，及调用数据库方言进行

2、某些查询需要返回主键问题，抽取为常量，并进行指定返回字段说明，RETURN_PRIMARY_KEYS。

3、某些类中的方法使用LIKE '%' ? '%'问题，更改为通用的方式

4、抽取类中的查询SQL中的分页代码为sqlInner局部变量，动态获取方言获取分页代码

5、ExternalStoragePaginationHelperImpl类中的fetchPage方法，更改调用为方言实现通用查询代码

6、对数据库的分页的计算方式(pageNo - 1) * pageSize，封装为2个单独方法，便于不同的数据库进行分页参数控制

### 5.2、PostgreSQL的兼容性问题：

已解决：

1、PostgreSQL数据库脚本相关梳理

未解决：

1、针对dump业务的removeConfigHistory方法，进行重写，目前删除时，未加上分页控制，非分页删除，待实现如何处理

### 5.3、Oracle的兼容性问题：

已解决：

1、Oracle数据库脚本相关梳理

2、PERMISSIONS表的RESOURCE字段名称冲突问题，创建表的时候，加上双引号，未来看看是否重命名该字段

3、主键自增长问题，目前采用手动创建序列和触发器的方式，对于Oralce11g的脚本

4、tenant_id默认空NULL查询的问题，目前自定义子类，重写相关方法，采用增加默认存储public空间判断的方式

5、分页SQL的问题，目前采用单独封装分页起始范围的方法，进行处理

未解决：

1、用户表boolean类型问题，但是在Oracle上没有报错，存储的是1，可以用。

### 5.4、达梦的兼容性问题：

说明：

当前采用继承Oracle方言的方式。

已解决：

1、由于达梦默认区分大小写，在某些类返回主键ID的时候，增加了默认方言方法

未解决：

未知















