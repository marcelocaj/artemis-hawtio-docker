# Supported tags and respective `Dockerfile` links

-	[`2.1-1.5-1-alpine`, `latest`](https://raw.githubusercontent.com/marcelocaj/artemis-hawtio-docker/2.1-1.5-1-alpine/Dockerfile)
-	[`2.3-1.5-1-alpine`, `latest`](https://raw.githubusercontent.com/marcelocaj/artemis-hawtio-docker/2.3-1.5-1-alpine/Dockerfile)

## Warning: 2.3 incompatibility

Configuration files from Artemis 2.3 are not compatible with 2.1 files since 2.3 already includes hawtio. This upgrade requires manual migration.

# What is this container?

Taking the [vromero/activemq-artemis](https://github.com/vromero/activemq-artemis-docker) image as a base and since ActiveMQ Artemis does not offer any graphical administration console, this container includes the neccesary configuration to run ActiveMQ Artemis + HawtIO + HawtIO Artemis Plugin.

JBoss-AMQ (7.0.1) is an alternative, but it contains propietary parts and does not include ActiveMQ Artemis 2.1.0 yet.

# What is ActiveMQ Artemis?

Apache ActiveMQ Artemis is an open source project to build a multi-protocol, embeddable, very high performance, clustered, asynchronous messaging system. Apache ActiveMQ Artemis is an example of Message Oriented Middleware (MoM)

> [activemq.apache.org/artemis](https://activemq.apache.org/artemis/index.html)

![logo](https://activemq.apache.org/artemis/images/activemq-logo.png)

# What is HawtIO?

HawtIO is a web dashboard for managing and monitoring JVM-based services such as Apache ActiveMQ, Apache Camel, JBoss, Infinispan, Apache Tomcat. There is no integrated support for ActiveMQ Artemis, so it is neccesary to use a plugin.

# How to use this image

## Running the daemon

ActiveMQ Artemis daemon can be run with the following command:

```console
$ docker run -d -p 8161:8161 -p 61616:61616 marcelocaj/artemis-hawtio-docker
```

Open your browser in:

```console
$ http://localhost:8161/hawtio
```

After a few seconds, you can run the following command `docker logs some-thing` (where some-thing is the name docker assigned to your instance), you'll see in the output a block similar to:

```console
     _        _               _
    / \  ____| |_  ___ __  __(_) _____
   / _ \|  _ \ __|/ _ \  \/  | |/  __/
  / ___ \ | \/ |_/  __/ |\/| | |\___ \
 /_/   \_\|   \__\____|_|  |_|_|/___ /
 Apache ActiveMQ Artemis 2.1.0
15:22:46,430 INFO  [org.apache.activemq.artemis.integration.bootstrap] AMQ101000: Starting ActiveMQ Artemis Server
15:22:46,481 INFO  [org.apache.activemq.artemis.core.server] AMQ221000: live Message Broker is starting with configuration Broker Configuration (clustered=false,journalDirectory=./data/journal,bindingsDirectory=./data/bindings,largeMessagesDirectory=./data/large-messages,pagingDirectory=./data/paging)
15:22:46,519 INFO  [org.apache.activemq.artemis.core.server] AMQ221012: Using AIO Journal
15:22:46,569 INFO  [org.apache.activemq.artemis.core.server] AMQ221057: Global Max Size is being adjusted to 1/2 of the JVM max size (-Xmx). being defined as 1,073,741,824
15:22:46,598 INFO  [org.apache.activemq.artemis.core.server] AMQ221043: Protocol module found: [artemis-server]. Adding protocol support for: CORE
15:22:46,598 INFO  [org.apache.activemq.artemis.core.server] AMQ221043: Protocol module found: [artemis-amqp-protocol]. Adding protocol support for: AMQP
15:22:46,599 INFO  [org.apache.activemq.artemis.core.server] AMQ221043: Protocol module found: [artemis-hornetq-protocol]. Adding protocol support for: HORNETQ
15:22:46,599 INFO  [org.apache.activemq.artemis.core.server] AMQ221043: Protocol module found: [artemis-mqtt-protocol]. Adding protocol support for: MQTT
15:22:46,599 INFO  [org.apache.activemq.artemis.core.server] AMQ221043: Protocol module found: [artemis-openwire-protocol]. Adding protocol support for: OPENWIRE
15:22:46,600 INFO  [org.apache.activemq.artemis.core.server] AMQ221043: Protocol module found: [artemis-stomp-protocol]. Adding protocol support for: STOMP
15:22:46,679 INFO  [org.apache.activemq.artemis.core.server] AMQ221034: Waiting indefinitely to obtain live lock
15:22:46,679 INFO  [org.apache.activemq.artemis.core.server] AMQ221035: Live Server Obtained live lock
15:22:46,805 INFO  [org.apache.activemq.artemis.core.server] AMQ221003: Deploying queue DLQ
15:22:46,870 INFO  [org.apache.activemq.artemis.core.server] AMQ221003: Deploying queue ExpiryQueue
15:22:47,269 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: Started EPOLL Acceptor at 0.0.0.0:61616 for protocols [CORE,MQTT,AMQP,STOMP,HORNETQ,OPENWIRE]
15:22:47,271 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: Started EPOLL Acceptor at 0.0.0.0:5445 for protocols [HORNETQ,STOMP]
15:22:47,273 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: Started EPOLL Acceptor at 0.0.0.0:5672 for protocols [AMQP]
15:22:47,276 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: Started EPOLL Acceptor at 0.0.0.0:1883 for protocols [MQTT]
15:22:47,277 INFO  [org.apache.activemq.artemis.core.server] AMQ221020: Started EPOLL Acceptor at 0.0.0.0:61613 for protocols [STOMP]
15:22:47,279 INFO  [org.apache.activemq.artemis.core.server] AMQ221007: Server is now live
15:22:47,280 INFO  [org.apache.activemq.artemis.core.server] AMQ221001: Apache ActiveMQ Artemis Message Broker version 2.1.0 [0.0.0.0, nodeID=f6c542d0-625e-11e7-a95e-0242ac110008]
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/var/lib/artemis/tmp/jetty-0.0.0.0-8161-hawtio.war-_hawtio-any-1794898001073017946.dir/webapp/WEB-INF/lib/slf4j-log4j12-1.7.21.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/apache-artemis-2.1.0/lib/slf4j-jboss-logmanager-1.0.3.GA.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
INFO  | main | Configuration will be discovered via system properties
INFO  | main | Welcome to hawtio 1.5.2 : http://hawt.io/ : Don't cha wish your console was hawt like me? ;-)
INFO  | main | Using file upload directory: /var/lib/artemis/tmp/uploads
INFO  | main | Connected to Log4j appender to trap logs with hawtio log plugin
INFO  | main | hawtio using config directory: /home/artemis/.hawtio/config
INFO  | main | Clone git repo on startup disabled
INFO  | main | Initialised an empty git configuration repo at /home/artemis/.hawtio/config
WARN  | main | Local JVM discovery disabled as this JVM cannot access com.sun.tools.attach.VirtualMachine due to: com/sun/tools/attach/VirtualMachine
INFO  | main | Starting hawtio authentication filter, JAAS realm: "activemq" authorized role(s): "amq" role principal classes: "org.apache.activemq.artemis.spi.core.security.jaas.RolePrincipal"
INFO  | main | Jolokia has not found any overriden configuration property passed at launch time; Default configuration values will be used.
INFO  | main | Using MBean [hawtio:type=security,area=jmx,rank=0,name=HawtioDummyJMXSecurity] for role based access control
INFO  | main | Initial proxy whitelist: [localhost, 127.0.0.1, 172.17.0.8, 0488a048ed31]
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/var/lib/artemis/tmp/jetty-0.0.0.0-8161-artemis-plugin.war-_artemis-plugin-any-8976573406472925476.dir/webapp/WEB-INF/lib/slf4j-log4j12-1.7.21.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/apache-artemis-2.1.0/lib/slf4j-jboss-logmanager-1.0.3.GA.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
INFO  | main | Initialized artemis-plugin plugin
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/var/lib/artemis/tmp/jetty-0.0.0.0-8161-dispatch-hawtio-console.war-_dispatch-hawtio-console-any-7357704615568612636.dir/webapp/WEB-INF/lib/slf4j-log4j12-1.7.21.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/apache-artemis-2.1.0/lib/slf4j-jboss-logmanager-1.0.3.GA.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
INFO  | main | Initialized dispatch-hawtio-console plugin
15:22:50,878 INFO  [org.apache.activemq.artemis] AMQ241001: HTTP Server started at http://0.0.0.0:8161
15:22:50,878 INFO  [org.apache.activemq.artemis] AMQ241002: Artemis Jolokia REST API available at http://0.0.0.0:8161/jolokia
```

## Setting memory values

By default Artemis will use 512 Megabytes or RAM at minimum and 2048 Megabytes at maximum. You can set the memory that you application needs by using the parameters `ARTEMIS__MIN_MEMORY` and `ARTEMIS_MAX_MEMORY`:

```console
$ docker run -d -e 'ARTEMIS_MIN_MEMORY=1512M' -e 'ARTEMIS_MAX_MEMORY=3048M' marcelocaj/artemis-hawtio-docker
```

The previous example will launch Apache ActiveMQ Artemis in docker with 1512 MB of memory, with a maximum usage of 3048 MB of memory.
The format of the values passed is the same than the format used for the Java `-Xms` and `-Xmx` parameters and its documented [here](http://docs.oracle.com/javase/7/docs/technotes/tools/solaris/java.html).


## Setting username and password

If you wish to change the default username and password of `artemis` / `simetraehcapa`, you can do so with the `ARTEMIS_USERNAME` and `ARTEMIS_PASSWORD` environmental variables:

```console
$ docker run -d -e ARTEMIS_USERNAME=myuser -e ARTEMIS_PASSWORD=otherpassword marcelocaj/artemis-hawtio-docker
```

## Configuring JMX

Due to the JMX's nature, often with dynamics ports for RMI and the need having configure the public IP address to reach the RMI server.
It is discouraged to use JMX in Docker. Although in certain scenarios, it could be advisable, as when deploying in a
container orchestrator such as Kubernetes or Mesos, and deploying along side this container a side car. For such cases
the following environment variable could be used: `ENABLE_JMX`.

It is also possible to set the JMX port and the JMX RMI port with these two environment variables respectively: `JMX_PORT` (default: 1099) and `JMX_RMI_PORT` (default: 1098).

Given that JMX is intended for side cars, it is attached only to localhost and not protected with SSL. Likewise, its ports are not declared in the `Dockerfile`.

```console
$ docker run -d -e ENABLE_JMX=true -e JMX_PORT=1199 -e JMX_RMI_PORT=1198 marcelocaj/artemis-hawtio-docker
```

## Performing a performance journal test

Different kinds of volumes need different values in fine tuning.
It is possible to calculate the journal-buffer-timeout you should use with the current data folder and
apply it directly to the broker configuration using the environment variable: `ARTEMIS_PERF_JOURNAL` with one
of the following valid values:

| Value            | Description                                                       |
|------------------|-------------------------------------------------------------------|
|`AUTO`            | Checks for the existence of a `.perf-journal-completed` file in the data volume, if it doesn't exist performs the calculation, applies the configuration and creates the file. |
|`NEVER` (default) | Never do the performance journal configuration                    |
|`ALWAYS`          | Always do the performance journal configuration                   |

It is advisable to set it up in `AUTO` in non manually configured containers, although given that this image is
often used for quick tests and non production environments it is set as NEVER as default value.

```console
$ docker run -d -e ARTEMIS_PERF_JOURNAL=AUTO marcelocaj/artemis-hawtio-docker
```

## Overriding parts of the configuration

It is possible to mount a whole artemis `etc` directory in this image in the volume `/var/lib/artemis/etc`.
But this is an overkill for many situations where only small tweaks are necessary.  

For those cases `/var/lib/artemis/etc-override` can be used.

Multiple files with snippets of configuration can be dropped in the `etc-override` folder. Those configuration files must be named following the name convention `broker-{{desc}}.xml` where `desc` is a numeric representation of the snippet.
The configuration files will be *merged* with the default configuration. An alphabetical precedence of the file names will be considered for the merge and in case of collision the latest change will be treated as final.

For instance lets say that you want to add a diverts section, you could have a local directory, lets say `/var/artemis-data/etc-override`
where you could place a `broker-00.xml` file that looks like the following listing:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>

<configuration xmlns="urn:activemq" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:activemq /schema/artemis-server.xsd">
   <core xmlns="urn:activemq:core">
      <diverts>
         <divert name="order-divert">
            <routing-name>order-divert</routing-name>
            <address>orders</address>
            <forwarding-address>spyTopic</forwarding-address>
            <exclusive>false</exclusive>
         </divert>
      </diverts>
   </core>
</configuration>
```

For the use cases where instead of merging, the desired outcome is an override, a file named `broker-00.xslt`
in `/var/lib/artemis/etc-override` is supported. For instance to delete override the `jms` definitions instead of merging, these files could be used:

`broker.xml`

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>

<configuration xmlns="urn:activemq" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:activemq /schema/artemis-configuration.xsd">
  <jms xmlns="urn:activemq:jms">
    <queue name="myfancyqueue"/>
    <queue name="myotherqueue"/>
  </jms>
</configuration>
```

`broker-00.xslt`

```xslt
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:activemq="urn:activemq" xmlns:jms="urn:activemq:jms">

 <xsl:output omit-xml-declaration="yes"/>

    <xsl:template match="node()|@*">
      <xsl:copy>
         <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
    </xsl:template>

    <xsl:template match="*[local-name()='jms']"/>
</xsl:stylesheet>
```

If you would like to see the final result of your transformations, execute the following:

```
docker run -v /var/artemis-data/override:/var/lib/artemis/etc-override -it --rm marcelocaj/artemis-hawtio-docker cat ../etc/broker.xml
```

## Mount points

| Mount point                      | Description                                                       |
|--------------------------------- |-------------------------------------------------------------------|
|`/var/lib/artemis/data`           | Holds the data files used for storing persistent messages         |
|`/var/lib/artemis/etc`            | Hold the instance configuration files                             |
|`/var/lib/artemis/etc-override`   | Hold the instance configuration files                             |
|`/var/lib/artemis/tmp`            | Holds temporary files created by ActiveMQ Artemis                 |


## Exposed ports

| Port    | Description                                                     |
|-------- |-----------------------------------------------------------------|
| `8161`  | Web Server                                                      |
| `61616` | Core,MQTT,AMQP,HORNETQ,STOMP,Openwire                           |
| `5445`  | HORNETQ,STOMP                                                   |
| `5672`  | AMQP                                                            |
| `1883`  | MQTT                                                            |
| `61613` | STOMP                                                           |

# License

View [license information](http://www.apache.org/licenses/LICENSE-2.0) for the software contained in this image.

# Supported Docker versions

The original vromero/activemq-artemis-docker image is officially supported on Docker version 1.8.2. However, HawtIO integration has been tested only on Docker 1.12+.

# User Feedback

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/marcelocaj/artemis-hawtio-docker/issues).

## Contributing

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/marcelocaj/artemis-hawtio-docker/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
