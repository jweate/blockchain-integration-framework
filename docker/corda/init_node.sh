
echo "Starting corda node for PartyA..."
java -jar /opt/corda/partyA/corda.jar --base-directory=/opt/corda/partyA & java -jar /opt/corda/partyB/corda.jar --base-directory=/opt/corda/partyB && fg
#
#P1=$!
#
#sleep 60
#echo "Adding node info to volume"
#cp /opt/corda/nodeInfo-* /opt/corda/additional-node-infos
#fg $P1
