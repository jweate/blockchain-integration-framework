FROM azul/zulu-openjdk:8u192

RUN apt-get update && apt-get -y upgrade && apt-get -y install bash curl unzip

# set up vars
ARG PARTY="PartyA"
ARG RPC_PORT="10000"
ARG PTP_PORT="10500"

# create node dir structure
RUN echo "Creating node directory structure"
RUN mkdir -p /etc/corda
RUN mkdir -p /opt/corda/cordapps
RUN mkdir -p /opt/corda/config
RUN mkdir -p /opt/corda/persistence
RUN mkdir -p /opt/corda/certificates
RUN mkdir -p /opt/corda/drivers
RUN mkdir -p /opt/corda/logs
RUN mkdir -p /opt/corda/bin
RUN mkdir -p /opt/corda/additional-node-infos

RUN addgroup corda && \
    useradd corda -g corda -m -d /opt/corda

WORKDIR /opt/corda
RUN chown -R corda:corda /opt/corda

# set up node file

ADD corda.jar /opt/corda/corda.jar
ADD network-parameters /opt/corda/network-parameters
ADD $PARTY/certificates/nodekeystore.jks /opt/corda/certificates/nodekeystore.jks
ADD $PARTY/certificates/truststore.jks /opt/corda/certificates/truststore.jks
ADD $PARTY/certificates/sslkeystore.jks /opt/corda/certificates/sslkeystore.jks

EXPOSE $RPC_PORT
EXPOSE $P2P_PORT

# configure and run node
ADD --chown=corda:corda init_node.sh /opt/corda/bin/init_node.sh
RUN chmod +x /opt/corda/bin/init_node.sh
CMD ["/opt/corda/bin/init_node.sh", "${PARTY}", "${RPC_PORT}" , "${PTP_PORT}"]

# TODO: add additional-node volume
