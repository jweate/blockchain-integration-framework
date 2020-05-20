FROM azul/zulu-openjdk:8u192


RUN apt-get update && apt-get -y upgrade && apt-get -y install bash curl unzip

# Create dir structure
RUN mkdir -p /etc/corda
RUN mkdir -p /opt/corda/cordapps
RUN mkdir -p /opt/corda/config
RUN mkdir -p /opt/corda/persistence
RUN mkdir -p /opt/corda/certificates
RUN mkdir -p /opt/corda/drivers
RUN mkdir -p /opt/corda/logs
RUN mkdir -p /opt/corda/bin
RUN mkdir -p /opt/corda/additional-node-infos
WORKDIR /opt/corda

# set env vars
ENV CORDAPPS_FOLDER="/opt/corda/cordapps"
ENV PERSISTENCE_FOLDER="/opt/corda/persistence"
ENV CERTIFICATES_FOLDER="/opt/corda/certificates"
ENV DRIVERS_FOLDER="/opt/corda/drivers"
ENV CONFIG_FOLDER="/etc/corda"

# set up node
ADD corda.jar /opt/corda/corda.jar
ADD network-parameters /opt/corda/network-parameters
ADD node.conf /opt/corda/node.conf
ADD certificates/nodekeystore.jks /opt/corda/certificates/nodekeystore.jks
ADD certificates/truststore.jks /opt/corda/certificates/truststore.jks
ADD certificates/sslkeystore.jks /opt/corda/certificates/sslkeystore.jks

# add helper script
ADD run_node.sh /opt/corda/bin/run_node.sh
RUN chmod +x /opt/corda/bin/run_node.sh

