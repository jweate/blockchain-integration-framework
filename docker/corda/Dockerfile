FROM azul/zulu-openjdk:8u192

RUN apt-get update && apt-get -y upgrade && apt-get -y install bash curl unzip

# set up vars
#ARG PARTY_A="PartyA"
#ARG RPC_A="10000"
#ARG P2P_A="10500"
#ENV ME=$PARTY
#ENV RPC_PORT=$RPC
#ENV P2P_PORT=$P2P


# create party A dir structure
RUN echo "Creating node directory structure for PartyA"
RUN mkdir -p /etc/corda
RUN mkdir -p /opt/corda/partyA/cordapps
RUN mkdir -p /opt/corda/partyA/config
RUN mkdir -p /opt/corda/partyA/persistence
RUN mkdir -p /opt/corda/partyA/certificates
RUN mkdir -p /opt/corda/partyA/drivers
RUN mkdir -p /opt/corda/partyA/logs
RUN mkdir -p /opt/corda/partyA/bin
RUN mkdir -p /opt/corda/partyA/additional-node-infos

# create party B dir structure
RUN echo "Creating node directory structure for PartyB"
RUN mkdir -p /opt/corda/partyB/cordapps
RUN mkdir -p /opt/corda/partyB/config
RUN mkdir -p /opt/corda/partyB/persistence
RUN mkdir -p /opt/corda/partyB/certificates
RUN mkdir -p /opt/corda/partyB/drivers
RUN mkdir -p /opt/corda/partyB/logs
RUN mkdir -p /opt/corda/partyB/bin
RUN mkdir -p /opt/corda/partyB/additional-node-infos


RUN addgroup corda && \
    useradd corda -g corda -m -d /opt/corda

WORKDIR /opt/
RUN chown -R corda:corda /opt/corda

# set up node file for party A
ADD corda.jar /opt/corda/partyA/corda.jar
ADD network-parameters /opt/corda/partyA/network-parameters
ADD workflows-0.1.jar /opt/corda/partyA/cordapps/workflows-0.1.jar
ADD contracts-0.1.jar /opt/corda/partyA/cordapps/contracts-0.1.jar
ADD PartyA/certificates/nodekeystore.jks /opt/corda/partyA/certificates/nodekeystore.jks
ADD PartyA/certificates/truststore.jks /opt/corda/partyA/certificates/truststore.jks
ADD PartyA/certificates/sslkeystore.jks /opt/corda/partyA/certificates/sslkeystore.jks
ADD PartyA/node.conf /opt/corda/partyA/node.conf
ADD additional-node-infos /opt/corda/partyA/additional-node-infos

# set up node file for party B
ADD corda.jar /opt/corda/partyB/corda.jar
ADD network-parameters /opt/corda/partyB/network-parameters
ADD workflows-0.1.jar /opt/corda/partyB/cordapps/workflows-0.1.jar
ADD contracts-0.1.jar /opt/corda/partyB/cordapps/contracts-0.1.jar
ADD PartyB/certificates/nodekeystore.jks /opt/corda/partyB/certificates/nodekeystore.jks
ADD PartyB/certificates/truststore.jks /opt/corda/partyB/certificates/truststore.jks
ADD PartyB/certificates/sslkeystore.jks /opt/corda/partyB/certificates/sslkeystore.jks
ADD PartyB/node.conf /opt/corda/partyB/node.conf
ADD additional-node-infos /opt/corda/partyB/additional-node-infos


EXPOSE 10006
EXPOSE 10009

# run nodes
ADD --chown=corda:corda init_node.sh /opt/corda/bin/init_node.sh
RUN chmod +x /opt/corda/bin/init_node.sh
CMD /opt/corda/bin/init_node.sh

# TODO: add additional-node volume
