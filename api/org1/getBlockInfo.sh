export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="farmerMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../../supplychain-network/organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/../../supplychain-network/organizations/peerOrganizations/farmer.supplychain.com/users/Admin@farmer.supplychain.com/msp/
export CORE_PEER_ADDRESS=localhost:7051

export FABRIC_CFG_PATH=${PWD}/../../config/
#peer channel fetch newest supplychain-channel.block -c supplychain-channel --orderer orderer.supplychain.com:7050
peer channel getinfo -c supplychain-channel > block.json 
cat block.json | cut -c 18- > blockchainInfo.json