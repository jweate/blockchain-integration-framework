FROM azul/zulu-openjdk:8u192

RUN apt-get update && apt-get -y upgrade && apt-get -y install bash curl unzip

# set up vars
ARG PARTY="PartyA"
ARG RPC="10000"
ARG P2P="10500"
ENV ME=$PARTY
ENV RPC_PORT=$RPC
ENV P2P_PORT=$P2P


# create node dir structure
RUN echo "Creating node directory structure for $ME"
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

RUN echo $ME/certificates/nodekeystore.jks
# set up node file
ADD corda.jar /opt/corda/corda.jar
ADD network-parameters /opt/corda/network-parameters
ADD workflows-0.1.jar /opt/corda/cordapps/workflows-0.1.jar
ADD contracts-0.1.jar /opt/corda/cordapps/contracts-0.1.jar
ADD $ME/certificates/nodekeystore.jks /opt/corda/certificates/nodekeystore.jks
ADD $ME/certificates/truststore.jks /opt/corda/certificates/truststore.jks
ADD $ME/certificates/sslkeystore.jks /opt/corda/certificates/sslkeystore.jks

EXPOSE $RPC_PORT
EXPOSE $P2P_PORT

# configure and run node
ADD --chown=corda:corda init_node.sh /opt/corda/bin/init_node.sh
RUN chmod +x /opt/corda/bin/init_node.sh
CMD /opt/corda/bin/init_node.sh $ME $RPC_PORT $P2P_PORT

# TODO: add additional-node volume
