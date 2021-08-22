#!/bin/bash
source ../terminal_control.sh

export FABRIC_CFG_PATH=/root/binaries/supply-chain-management-using-hyperledger-fabric/config/
export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

export CHANNEL_NAME=supplychain-channel

setEnvForPeer0farmer() {
    export PEER0_ORG1_CA=${PWD}/organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=farmerMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/farmer.supplychain.com/users/Admin@farmer.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setEnvForPeer1farmer() {
    export PEER1_ORG1_CA=${PWD}/organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=farmerMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/farmer.supplychain.com/users/Admin@farmer.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:8051
}

setEnvForPeer0warehouse() {
    export PEER0_ORG2_CA=${PWD}/organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=warehouseMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/warehouse.supplychain.com/users/Admin@warehouse.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setEnvForPeer1warehouse() {
    export PEER1_ORG2_CA=${PWD}/organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=warehouseMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/warehouse.supplychain.com/users/Admin@warehouse.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:10051
}

setEnvForPeer0retailer() {
    export PEER0_ORG3_CA=${PWD}/organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=retailerMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/retailer.supplychain.com/users/Admin@retailer.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
}

setEnvForPeer1retailer() {
    export PEER1_ORG3_CA=${PWD}/organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=retailerMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/retailer.supplychain.com/users/Admin@retailer.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:12051
}

setEnvForPeer0transporter() {
    export PEER0_ORG4_CA=${PWD}/organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=transporterMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/transporter.supplychain.com/users/Admin@transporter.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:13051
}

setEnvForPeer1transporter() {
    export PEER1_ORG4_CA=${PWD}/organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=transporterMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/transporter.supplychain.com/users/Admin@transporter.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:14051
}

createChannel() {
    setEnvForPeer0farmer

    print Green "========== Creating Channel =========="
    echo ""
    peer channel create -o localhost:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer.supplychain.com \
    -f ./channel-artifacts/$CHANNEL_NAME.tx --outputBlock \
    ./channel-artifacts/${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 
    echo ""
}

joinChannel() {
    
    setEnvForPeer0farmer
    print Green "========== Peer0farmer Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1farmer
    print Green "========== Peer1farmer Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0warehouse
    print Green "========== Peer0warehouse Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1warehouse
    print Green "========== Peer1warehouse Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0retailer
    print Green "========== Peer0retailer Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1retailer
    print Green "========== Peer1retailer Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0transporter
    print Green "========== Peer0transporter Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1transporter
    print Green "========== Peer1transporter Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""
}

updateAnchorPeers() {
    setEnvForPeer0farmer
    print Green "========== Updating Anchor Peer of Peer0farmer =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""

    setEnvForPeer0warehouse
    print Green "========== Updating Anchor Peer of Peer0warehouse =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""

    setEnvForPeer0retailer
    print Green "========== Updating Anchor Peer of Peer0retailer =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""

    setEnvForPeer0transporter
    print Green "========== Updating Anchor Peer of Peer0transporter =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""
}

createChannel
joinChannel
updateAnchorPeers