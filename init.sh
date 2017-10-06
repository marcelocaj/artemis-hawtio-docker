#!/bin/bash

set -e

/opt/apache-artemis-${ACTIVEMQ_ARTEMIS_VERSION}/bin/artemis create artemis \
    --home /opt/apache-artemis \
    --user artemis \
    --password simetraehcapa \
    --role amq \
    --require-login \
    --cluster-user artemisCluster \
    --cluster-password simetraehcaparetsulc \
    ${ARTEMIS_INSTANCE_DIR} --force

# Ports are only exposed with an explicit argument, there is no need to binding
# the web console to localhost
cd ${ARTEMIS_INSTANCE_DIR}/etc && \
  xmlstarlet ed -L -N amq="http://activemq.org/schema" \
    -u "/amq:broker/amq:web/@bind" \
    -v "http://0.0.0.0:8161" bootstrap.xml

# add hawtio and artemis plugin to bootstrap.xml
#cd ${ARTEMIS_INSTANCE_DIR}/etc && \
#    xmlstarlet ed -L -N amq="http://activemq.org/schema" \
#       -s /amq:broker/amq:web -t elem -n app -v "" \
#       -i /amq:broker/amq:web/app -t attr -n url -v hawtio \
#       -i /amq:broker/amq:web/app -t attr -n war -v "hawtio.war" bootstrap.xml && \
#    xmlstarlet ed -L -N amq="http://activemq.org/schema" \
#       -s /amq:broker/amq:web -t elem -n app -v "" \
#       -i /amq:broker/amq:web/app -t attr -n url -v artemis-plugin \
#       -i /amq:broker/amq:web/app -t attr -n war -v "artemis-plugin.war" bootstrap.xml  && \
#    xmlstarlet ed -L -N amq="http://activemq.org/schema" \
#       -s /amq:broker/amq:web -t elem -n app -v "" \
#       -i /amq:broker/amq:web/app -t attr -n url -v dispatch-hawtio-console \
#       -i /amq:broker/amq:web/app -t attr -n war -v "dispatch-hawtio-console.war" bootstrap.xml

#cd ${ARTEMIS_INSTANCE_DIR}/etc && sed -i 's/\(^JAVA_ARGS=.*\)"/\1 \${HAWTIO_OPTS} \${JAVA_EXTRA_OPTS}"/g' artemis.profile

chown -R artemis.artemis ${ARTEMIS_INSTANCE_DIR}

