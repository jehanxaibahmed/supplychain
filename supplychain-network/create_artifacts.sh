#!/bin/bash 
source ../terminal_control.sh

export FABRIC_CFG_PATH=${PWD}/configtx/
print Blue "$FABRIC_CFG_PATH"

# # Generate crypto material using cryptogen tool
# print Green "========== Generating Crypto Material =========="
# echo ""

../../fabric-samples/bin/cryptogen generate --config=./crypto-config.yaml --output="organizations"

# print Green "========== Crypto Material Generated =========="
# echo ""

SYS_CHANNEL=supplychain-sys-channel
print Purple "System Channel Name: "$SYS_CHANNEL
echo ""

CHANNEL_NAME=supplychain-channel
print Purple "Application Channel Name: "$CHANNEL_NAME
echo ""

# Generate System Genesis Block using configtxgen tool
print Green "========== Generating System Genesis Block =========="
echo ""

../../fabric-samples/bin/configtxgen -configPath ./configtx/ -profile FourOrgsOrdererGenesis -channelID $SYS_CHANNEL -outputBlock ./channel-artifacts/genesis.block

print Green "========== System Genesis Block Generated =========="
echo ""

print Green "========== Generating Channel Configuration Block =========="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/$CHANNEL_NAME.tx -channelID $CHANNEL_NAME 

print Green "========== Channel Configuration Block Generated =========="
echo ""

print Green "========== Generating Anchor Peer Update For farmerMSP =========="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/farmerMSPAnchor.tx -channelID $CHANNEL_NAME -asOrg farmerMSP

print Green "========== Anchor Peer Update For farmerMSP Sucessful =========="
echo ""

print Green "========== Generating Anchor Peer Update For warehouseMSP =========="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/warehouseMSPAnchor.tx -channelID $CHANNEL_NAME -asOrg warehouseMSP

print Green "========== Anchor Peer Update For warehouseMSP Sucessful =========="
echo ""

print Green "========== Generating Anchor Peer Update For retailerMSP =========="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/retailerMSPAnchor.tx -channelID $CHANNEL_NAME -asOrg retailerMSP

print Green "========== Anchor Peer Update For retailerMSP Sucessful =========="
echo ""

print Green "========== Generating Anchor Peer Update For transporterMSP =========="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/transporterMSPAnchor.tx -channelID $CHANNEL_NAME -asOrg transporterMSP

print Green "========== Anchor Peer Update For transporterMSP Sucessful =========="
echo ""
