#!/bin/bash
source ../terminal_control.sh

export FABRIC_CFG_PATH=/root/binaries/supply-chain-management-using-hyperledger-fabric/config/
export ORDERER_CA=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
export CORE_PEER_TLS_ROOTCERT_FILE_ORG1=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG2=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG3=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG4=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/ca.crt

CHANNEL_NAME="supplychain-channel"
CHAINCODE_NAME="supplychain_2"
CHAINCODE_VERSION="1.0"
CHAINCODE_PATH="../chaincode/supplychain/go/"
CHAINCODE_LABEL="supplychain_3"

setEnvForfarmer() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=farmerMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/farmer.supplychain.com/users/Admin@farmer.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setEnvForwarehouse() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=warehouseMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/warehouse.supplychain.com/users/Admin@warehouse.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setEnvForretailer() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=retailerMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/retailer.supplychain.com/users/Admin@retailer.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
}

setEnvFortransporter() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=transporterMSP
    export CORE_PEER_TLS_ROOTCERT_FILE=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=/root/binaries/supply-chain-management-using-hyperledger-fabric/supplychain-network/organizations/peerOrganizations/transporter.supplychain.com/users/Admin@transporter.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:13051
}

packageChaincode() {
    rm -rf ${CHAINCODE_NAME}.tar.gz
    setEnvForfarmer
    print Green "========== Packaging Chaincode on Peer0 farmer =========="
    peer lifecycle chaincode package ${CHAINCODE_NAME}.tar.gz --path ${CHAINCODE_PATH} --lang golang --label ${CHAINCODE_LABEL}
    echo ""
    print Green "========== Packaging Chaincode on Peer0 farmer Successful =========="
    ls
    echo ""
}

installChaincode() {
    setEnvForfarmer
    print Green "========== Installing Chaincode on Peer0 farmer =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on Peer0 farmer =========="
    echo ""

    setEnvForwarehouse
    print Green "========== Installing Chaincode on Peer0 warehouse =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on peer0 warehouse =========="
    echo ""

    setEnvForretailer
    print Green "========== Installing Chaincode on Peer0 retailer =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on Peer0 retailer =========="
    echo ""

    setEnvFortransporter
    print Green "========== Installing Chaincode on Peer0 transporter =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:13051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on Peer0 transporter =========="
    echo ""
}

queryInstalledChaincode() {
    setEnvForfarmer
    print Green "========== Querying Installed Chaincode on Peer0 farmer=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    print Yellow "PackageID is ${PACKAGE_ID}"
    print Green "========== Query Installed Chaincode Successful on Peer0 farmer=========="
    echo ""
}

approveChaincodeByfarmer() {
    setEnvForfarmer
    print Green "========== Approve Installed Chaincode by Peer0 farmer =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 farmer =========="
    echo ""
}

checkCommitReadynessForfarmer() {
    setEnvForfarmer
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 farmer =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 farmer =========="
    echo ""
}

approveChaincodeBywarehouse() {
    setEnvForwarehouse
    print Green "========== Approve Installed Chaincode by Peer0 warehouse =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 warehouse =========="
    echo ""
}

checkCommitReadynessForwarehouse() {
    setEnvForwarehouse
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 warehouse =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 warehouse =========="
    echo ""
}

approveChaincodeByretailer() {
    setEnvForretailer
    print Green "========== Approve Installed Chaincode by Peer0 retailer =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 retailer =========="
    echo ""
}

checkCommitReadynessForretailer() {
    setEnvForretailer
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 retailer =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 retailer =========="
    echo ""
}

approveChaincodeBytransporter() {
    setEnvFortransporter
    print Green "========== Approve Installed Chaincode by Peer0 transporter =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 transporter =========="
    echo ""
}

checkCommitReadynessFortransporter() {
    setEnvFortransporter
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 transporter =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 transporter =========="
    echo ""
}

commitChaincode() {
    setEnvForfarmer
    print Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG1} --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG2} --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG3} --peerAddresses localhost:13051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG4} --version ${CHAINCODE_VERSION} --sequence 1 --init-required
    print Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}

queryCommittedChaincode() {
    setEnvForfarmer
    print Green "========== Query Committed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME}
    print Green "========== Query Committed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}

getInstalledChaincode() {
    setEnvForfarmer
    print Green "========== Get Installed Chaincode from Peer0 farmer =========="
    peer lifecycle chaincode getinstalledpackage --package-id ${PACKAGE_ID} --output-directory . --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Get Installed Chaincode from Peer0 farmer Successful =========="
    echo ""
}

queryApprovedChaincode() {
    setEnvForfarmer
    print Green "========== Query Approved of Installed Chaincode on Peer0 farmer =========="
    peer lifecycle chaincode queryapproved -C s${CHANNEL_NAME} -n ${CHAINCODE_NAME} --sequence 1 
    print Green "========== Query Approved of Installed Chaincode on Peer0 farmer Successful =========="
    echo ""
}

initChaincode() {
    setEnvForfarmer
    print Green "========== Init Chaincode on Peer0 farmer ========== "
    fcn_call='{"function":"initLedger","Args":[]}'
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG1} --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG2} --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG3} --peerAddresses localhost:13051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG4}  --isInit -c ${fcn_call} >&log.txt
    print Green "========== Init Chaincode on Peer0 farmer Successful ========== "
    echo ""
}

if [[ $1 == "packageChaincode" ]]
then
packageChaincode
elif [[ $1 == "installChaincode" ]]
then
installChaincode
elif [[ $1 == "queryInstalledChaincode" ]]
then
queryInstalledChaincode
elif [[ $1 == "approveChaincodeByfarmer" ]]
then
approveChaincodeByfarmer
elif [[ $1 == "checkCommitReadynessForfarmer" ]]
then
checkCommitReadynessForfarmer
elif [[ $1 == "approveChaincodeBywarehouse" ]]
then
approveChaincodeBywarehouse
elif [[ $1 == "checkCommitReadynessForwarehouse" ]]
then
checkCommitReadynessForwarehouse
elif [[ $1 == "approveChaincodeByretailer" ]]
then
approveChaincodeByretailer
elif [[ $1 == "checkCommitReadynessForretailer" ]]
then
checkCommitReadynessForretailer
elif [[ $1 == "approveChaincodeBytransporter" ]]
then
approveChaincodeBytransporter
elif [[ $1 == "checkCommitReadynessFortransporter" ]]
then
checkCommitReadynessFortransporter
elif [[ $1 == "commitChaincode" ]]
then
commitChaincode
elif [[ $1 == "queryCommittedChaincode" ]]
then
queryCommittedChaincode
elif [[ $1 == "getInstalledChaincode" ]]
then
getInstalledChaincode
elif [[ $1 == "queryApprovedChaincode" ]]
then
queryApprovedChaincode
elif [[ $1 == "initChaincode" ]]
then
initChaincode
elif [[ $1 == "help" ]]
then
echo "Usage:" 
echo "       source chaincode_lifecycle.sh [option]"
echo "Options Available:"
echo "Follow this options in sequence"
echo "[ packageChaincode | installChaincode | queryInstalledChaincode | approveChaincodeByfarmer ]"
echo "[ checkCommitReadynessForfarmer | approveChaincodeBywarehouse | checkCommitReadynessForwarehouse ]"
echo "[ approveChaincodeByretailer | checkCommitReadynessForretailer | approveChaincodeBytransporter ]"
echo "[ checkCommitReadynessFortransporter | commitChaincode | queryCommittedChaincode | initChaincode ]"
echo "Other Options:"
echo "[ default(run all options in sequence at once) | getInstalledChaincode | queryApprovedChaincode | help ]"
elif [[ $1 == "default" ]]
then
packageChaincode
installChaincode
queryInstalledChaincode
approveChaincodeByfarmer
checkCommitReadynessForfarmer
approveChaincodeBywarehouse
checkCommitReadynessForwarehouse
approveChaincodeByretailer
checkCommitReadynessForretailer
approveChaincodeBytransporter
checkCommitReadynessFortransporter
commitChaincode
queryCommittedChaincode
initChaincode
else
print Red "$1: Invalid option. (try: source chaincode_lifecycle.sh help)"
fi

