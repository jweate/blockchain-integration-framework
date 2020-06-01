#!/usr/bin/env bash

generate_config () {
  legal_name="\"O=${party_name},L=NewYork,C=US\""
  ip_address=$(awk 'END{print $1}' /etc/hosts)
  p2p_address="${ip_address}:${p2p_port}"
  rpc_address="${ip_address}:${rpc_port}"
  admin_address="${ip_address}:11000"

  echo -e "devMode=true
  myLegalName=${legal_name}
  p2pAddress=\"${p2p_address}\"
  rpcSettings {
    address=\"${rpc_address}\"
    adminAddress=\"${admin_address}\"
  }
  security {
  authService {
          dataSource {
              type=INMEMORY
              users=[
                  {
                      password=test
                      permissions=[
                          ALL
                      ]
                      user=user1
                  }
              ]
          }
      }
  }
  " > node.conf
}

# check args
party_name=$1
rpc_port=$2
p2p_port=$3

echo "Genearting node.conf for $1..."
generate_config party_name rpc_port p2p_port

echo "Generating nodeInfo..."
java -jar /opt/corda/corda.jar --base-directory=/opt/corda --just-generate-node-info

echo "Adding node info to volume"
cp /opt/corda/nodeInfo-* /opt/corda/additional-node-infos

echo "Starting corda node..."
java -jar /opt/corda/corda.jar --base-directory=/opt/corda
#
#P1=$!
#
#sleep 60
#echo "Adding node info to volume"
#cp /opt/corda/nodeInfo-* /opt/corda/additional-node-infos
#fg $P1
