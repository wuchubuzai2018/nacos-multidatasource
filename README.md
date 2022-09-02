# Nacos-MultiDataSource
## 一、项目介绍

提供Spring Cloud Alibaba微服务注册与配置中心Nacos的多数据源适配支持的开源项目，目前计划支持MySQL、PostgreSQL、Oracle、达梦、人大金仓等。

当前本地环境已基于Nacos2.1实现简单适配Oracle11g、PostgreSQL、达梦数据库。

当前nacos底层数据库存储目前仅支持MySQL与Derby，然而很多企业内部用的是非MySQL数据库，且社区也有一些人基于Nacos1.4.2版本(Spring Data JPA)进行了Oracle和Postgresql适配，目前还未有一个实现多数据源适配的项目，于是根据自己开发BI系统的经验计划搞一搞。

## 二、当前适配计划列表

| 适配版本   | 适配数据库 | 进展                 | 测试范围1 | 测试范围2     |
| ---------- | ---------- | -------------------- | --------- | ------------- |
| Nacos2.1   | Oracle     | 本地环境简单测试通过 | 单机环境  | 3节点集群环境 |
| Nacos2.1   | PostgreSQL | 本地环境简单测试通过 | 单机环境  | 3节点集群环境 |
| Nacos2.1   | 达梦       | 本地环境简单测试通过 | 单机环境  | 3节点集群环境 |
| Nacos2.1   | 人大金仓   | 待开始尝试           |           |               |
| Nacos2.1   | DB2        | 待开始尝试           |           |               |
| Nacos1.4.3 | Oracle     | 待开始尝试           |           |               |
| Nacos1.4.3 | PostgreSQL | 待开始尝试           |           |               |
| Nacos1.4.3 | 达梦       | 待开始尝试           |           |               |
| Nacos1.4.3 | 人大金仓   | 待开始尝试           |           |               |

## 三、项目文件夹结构

根目录：

​			方案一实现代码：

​						nacos210:适配Nacos2.1.0版本代码(目前已将数据源代码进行提交)

方案一开发文档说明(文档中提供测试包)：[Nacos支持适配多种数据库方言实现说明](https://github.com/wuchubuzai2018/nacos-multidatasource/tree/main/%E6%96%B9%E6%A1%88%E4%B8%80%E5%AE%9E%E7%8E%B0%E4%BB%A3%E7%A0%81)



## 四、个人当前适配方案

### 4.1、(当前采用)方案一、多种数据库方言实现的注入判断适配

该种方案希望尽量不影响原有的SQL业务逻辑前提下进行实现。目前基于Nacos2.1版本，当前该种方案，在本地开发环境，已简单的适配核心的PersistService的处理，支持MySQL、Oracle、PostgreSQL、达梦。部分功能未测试，对于服务注册与配置等基础功能可以实现正常的维护操作。

核心类图如下所示：

![方案一](https://user-images.githubusercontent.com/42382506/181712475-6205dacc-b8d0-4199-9962-233b241db665.png)

最近代码梳理好后，会上传到仓库。



### 4.2、方案二、通过委派模式解耦抽取SQL及方言适配

该种方案计划，希望采用容易扩展的插件或解耦的方式，将不同的业务SQL抽取到不同的表数据操作类中，同时并基于这些表数据，提供门面类对外统一暴露SPI接口的方式，同时在原有功能中，采用委派模式动态选择具体的数据库实现类型。

核心类图如下所示：

![方案二](https://user-images.githubusercontent.com/42382506/181146438-d3b28f16-04e2-43c2-b938-79013a031916.png)

目前该种方案预计耗时时间长，但是个人觉得扩展性和解耦来说，比较合适。

## 五、数据库兼容性说明

当前发现的需要视频的多数据源数据库的适配改动，核心的改造点为：

1、不同数据库的分页SQL的适配

2、不同数据库的主键自增问题适配

3、不同数据库的默认tenant_id为空查询的适配

4、不同数据库的user表boolean的适配处理

## 六、业界目前存在适配实现方案

**社区Oracle实现资料：**

通过javaagent方式：https://github.com/wuwen5/ojdbc-mysql2oracle

基于 Spring Data JPA ：https://github.com/alibaba/nacos/tree/feature_multiple_datasource_support

通过javaagent方式：https://github.com/siaron/mysql2postgresql-jdbc-agent

**社区PostgreSQL实现资料：**

https://blog.csdn.net/dph5199278/article/details/124675548

https://github.com/dph5199278/nacos/releases

**开源之夏Nacos 多数据源插件化建设：**	

https://summer-ospp.ac.cn/#/org/projectlist?nameCode=nacos	

https://summer-ospp.ac.cn/#/preview/1542	

**网友博客：**

https://blog.csdn.net/qq_24101357/article/details/123415776

## 七、参与贡献

个人能力有限，感兴趣的小伙伴可以一起参与项目的开发与贡献。



