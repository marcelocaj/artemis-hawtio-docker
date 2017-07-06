FROM openjdk:8-jre-alpine
MAINTAINER Victor Romero <marcelocaj@gmail.com>

# add user and group for artemis
RUN addgroup -S artemis && adduser -S -G artemis artemis

RUN apk add --no-cache libaio xmlstarlet jq

ENV GOSU_VERSION 1.10
RUN set -x \
    && apk add --no-cache --virtual .gosu-deps \
        dpkg \
        gnupg \
        openssl \
    && update-ca-certificates \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ipv4.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true 

# Uncompress and validate
ENV ACTIVEMQ_ARTEMIS_VERSION 2.1.0
RUN set -x && \
  apk add --no-cache --virtual .gosu-deps wget gnupg && \
  mkdir /opt && cd /opt && \
  wget -q https://repository.apache.org/content/repositories/releases/org/apache/activemq/apache-artemis/${ACTIVEMQ_ARTEMIS_VERSION}/apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}-bin.tar.gz && \
  wget -q https://repository.apache.org/content/repositories/releases/org/apache/activemq/apache-artemis/${ACTIVEMQ_ARTEMIS_VERSION}/apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}-bin.tar.gz.asc && \
  wget -q http://apache.org/dist/activemq/KEYS && \
  gpg --import KEYS && \
  gpg apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}-bin.tar.gz.asc && \
  tar xfz apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}-bin.tar.gz && \
  ln -s apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION} apache-artemis && \
  rm -f apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}-bin.tar.gz KEYS apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}-bin.tar.gz.asc && \
  apk del .gosu-deps

ENV HAWTIO_VERSION 1.5.2
RUN set -x && \
    apk add --no-cache --virtual wget && \
    wget -q -O /opt/apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}/web/hawtio.war \
    https://oss.sonatype.org/content/repositories/public/io/hawt/hawtio-default-offline/${HAWTIO_VERSION}/hawtio-default-offline-${HAWTIO_VERSION}.war

ENV HAWTIO_ARTEMIS_VERSION 1.0.1.CR1
COPY artemis-plugin-${HAWTIO_ARTEMIS_VERSION}.war /opt/apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}/web/artemis-plugin.war
COPY dispatch-hawtio-console-${HAWTIO_ARTEMIS_VERSION}.war /opt/apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}/web/dispatch-hawtio-console.war

# Create broker instance
RUN cd /var/lib && \
  /opt/apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}/bin/artemis create artemis \
    --home /opt/apache-artemis \
    --user artemis \
    --password simetraehcapa \
    --role amq \
    --require-login \
    --cluster-user artemisCluster \
    --cluster-password simetraehcaparetsulc

# Ports are only exposed with an explicit argument, there is no need to binding
# the web console to localhost
RUN cd /var/lib/artemis/etc && \
  xmlstarlet ed -L -N amq="http://activemq.org/schema" \
    -u "/amq:broker/amq:web/@bind" \
    -v "http://0.0.0.0:8161" bootstrap.xml

# add hawtio and artemis plugin to bootstrap.xml
RUN cd /var/lib/artemis/etc && \
    xmlstarlet ed -L -N amq="http://activemq.org/schema" \
       -s /amq:broker/amq:web -t elem -n app -v "" \
       -i /amq:broker/amq:web/app -t attr -n url -v hawtio \
       -i /amq:broker/amq:web/app -t attr -n war -v "hawtio.war" bootstrap.xml && \
    xmlstarlet ed -L -N amq="http://activemq.org/schema" \
       -s /amq:broker/amq:web -t elem -n app -v "" \
       -i /amq:broker/amq:web/app -t attr -n url -v artemis-plugin \
       -i /amq:broker/amq:web/app -t attr -n war -v "artemis-plugin.war" bootstrap.xml  && \
    xmlstarlet ed -L -N amq="http://activemq.org/schema" \
       -s /amq:broker/amq:web -t elem -n app -v "" \
       -i /amq:broker/amq:web/app -t attr -n url -v dispatch-hawtio-console \
       -i /amq:broker/amq:web/app -t attr -n war -v "dispatch-hawtio-console.war" bootstrap.xml


ENV HAWTIO_OPTS -Dhawtio.realm=activemq -Dhawtio.role=amq \
                -Dhawtio.rolePrincipalClasses=org.apache.activemq.artemis.spi.core.security.jaas.RolePrincipal -Djon.id=amq

RUN cd /var/lib/artemis/etc && sed -i 's/\(^JAVA_ARGS=.*\)"/\1 \${HAWTIO_OPTS} \${JAVA_EXTRA_OPTS}"/g' artemis.profile 

RUN chown -R artemis.artemis /var/lib/artemis

RUN mkdir -p /opt/merge
COPY merge.xslt /opt/merge

# Web Server
EXPOSE 8161

# Port for CORE,MQTT,AMQP,HORNETQ,STOMP,OPENWIRE
EXPOSE 61616

# Port for HORNETQ,STOMP
EXPOSE 5445

# Port for AMQP
EXPOSE 5672

# Port for MQTT
EXPOSE 1883

#Port for STOMP
EXPOSE 61613

# Expose some outstanding folders"]
VOLUME ["/var/lib/artemis/data"]
VOLUME ["/var/lib/artemis/tmp"]
VOLUME ["/var/lib/artemis/etc"]
VOLUME ["/var/lib/artemis/etc-override"]

WORKDIR /var/lib/artemis/bin

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["artemis-server"]
