
echo "Starting corda nodes..."
java -jar /opt/corda/partyA/corda.jar --base-directory=/opt/corda/partyA & java -jar /opt/corda/partyB/corda.jar --base-directory=/opt/corda/partyB && fg
