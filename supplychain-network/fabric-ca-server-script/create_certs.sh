createCertForfarmer() {
    echo
    echo "Enroll CA admin of farmer"
    echo
    mkdir -p ../organizations/peerOrganizations/farmer.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.farmer.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.farmer"
    echo

    fabric-ca-client register --caname ca.farmer.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    echo
    echo "Register peer1.farmer"
    echo

    fabric-ca-client register --caname ca.farmer.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    echo
    echo "Register user1.farmer"
    echo

    fabric-ca-client register --caname ca.farmer.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    echo
    echo "Register admin.farmer"
    echo

    fabric-ca-client register --caname ca.farmer.supplychain.com --id.name org1admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/farmer.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.farmer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/msp --csr.hosts peer0.farmer.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.farmer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.farmer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/tlsca/tlsca.farmer.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer0.farmer.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/ca/ca.farmer.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.farmer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/msp --csr.hosts peer1.farmer.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.farmer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.farmer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/tlsca/tlsca.farmer.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/peers/peer1.farmer.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/ca/ca.farmer.supplychain.com-cert.pem
    
    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/farmer.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/farmer.supplychain.com/users/User1@farmer.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.farmer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/users/User1@farmer.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/farmer.supplychain.com/users/Admin@farmer.supplychain.com

    echo
    echo "Generate farmer Admin MSP"
    echo

    fabric-ca-client enroll -u https://org1admin:adminpw@localhost:7054 --caname ca.farmer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/users/Admin@farmer.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/farmer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/farmer.supplychain.com/users/Admin@farmer.supplychain.com/msp/config.yaml
}

createCertForwarehouse() {
    echo
    echo "Enroll CA admin of warehouse"
    echo
    mkdir -p ../organizations/peerOrganizations/warehouse.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.warehouse.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-warehouse-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-warehouse-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-warehouse-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-warehouse-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.warehouse"
    echo

    fabric-ca-client register --caname ca.warehouse.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    echo
    echo "Register peer1.warehouse"
    echo

    fabric-ca-client register --caname ca.warehouse.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    echo
    echo "Register user1.warehouse"
    echo

    fabric-ca-client register --caname ca.warehouse.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    echo
    echo "Register admin.warehouse"
    echo

    fabric-ca-client register --caname ca.warehouse.supplychain.com --id.name org2admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/warehouse.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.warehouse.supplychain.com -M ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/msp --csr.hosts peer0.warehouse.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.warehouse.supplychain.com -M ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.warehouse.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/tlsca/tlsca.warehouse.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer0.warehouse.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/ca/ca.warehouse.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.warehouse.supplychain.com -M ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/msp --csr.hosts peer1.warehouse.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.warehouse.supplychain.com -M ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.warehouse.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/tlsca/tlsca.warehouse.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/peers/peer1.warehouse.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/ca/ca.warehouse.supplychain.com-cert.pem
    
    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/warehouse.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/warehouse.supplychain.com/users/User1@warehouse.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.warehouse.supplychain.com -M ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/users/User1@warehouse.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/warehouse.supplychain.com/users/Admin@warehouse.supplychain.com

    echo
    echo "Generate warehouse Admin MSP"
    echo

    fabric-ca-client enroll -u https://org2admin:adminpw@localhost:8054 --caname ca.warehouse.supplychain.com -M ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/users/Admin@warehouse.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/warehouse/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/warehouse.supplychain.com/users/Admin@warehouse.supplychain.com/msp/config.yaml
}

createCertForretailer() {
    echo
    echo "Enroll CA admin of retailer"
    echo
    mkdir -p ../organizations/peerOrganizations/retailer.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.retailer.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-retailer-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-retailer-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-retailer-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-retailer-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.retailer"
    echo

    fabric-ca-client register --caname ca.retailer.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    echo
    echo "Register peer1.retailer"
    echo

    fabric-ca-client register --caname ca.retailer.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    echo
    echo "Register user1.retailer"
    echo

    fabric-ca-client register --caname ca.retailer.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    echo
    echo "Register admin.retailer"
    echo

    fabric-ca-client register --caname ca.retailer.supplychain.com --id.name org3admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/retailer.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca.retailer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/msp --csr.hosts peer0.retailer.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca.retailer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.retailer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/tlsca/tlsca.retailer.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer0.retailer.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/ca/ca.retailer.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca.retailer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/msp --csr.hosts peer1.retailer.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca.retailer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.retailer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/tlsca/tlsca.retailer.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/peers/peer1.retailer.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/ca/ca.retailer.supplychain.com-cert.pem

    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/retailer.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/retailer.supplychain.com/users/User1@retailer.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:9054 --caname ca.retailer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/users/User1@retailer.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/retailer.supplychain.com/users/Admin@retailer.supplychain.com

    echo
    echo "Generate retailer Admin MSP"
    echo

    fabric-ca-client enroll -u https://org3admin:adminpw@localhost:9054 --caname ca.retailer.supplychain.com -M ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/users/Admin@retailer.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/retailer/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/retailer.supplychain.com/users/Admin@retailer.supplychain.com/msp/config.yaml
    
}

createCertFortransporter() {
    echo
    echo "Enroll CA admin of transporter"
    echo
    mkdir -p ../organizations/peerOrganizations/transporter.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.transporter.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-transporter-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-transporter-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-transporter-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-transporter-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.transporter"
    echo

    fabric-ca-client register --caname ca.transporter.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    echo
    echo "Register peer1.transporter"
    echo

    fabric-ca-client register --caname ca.transporter.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    echo
    echo "Register user1.transporter"
    echo

    fabric-ca-client register --caname ca.transporter.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    echo
    echo "Register admin.transporter"
    echo

    fabric-ca-client register --caname ca.transporter.supplychain.com --id.name org4admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/transporter.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.transporter.supplychain.com -M ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/msp --csr.hosts peer0.transporter.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.transporter.supplychain.com -M ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.transporter.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/tlsca/tlsca.transporter.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer0.transporter.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/ca/ca.transporter.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.transporter.supplychain.com -M ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/msp --csr.hosts peer1.transporter.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.transporter.supplychain.com -M ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.transporter.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/tlsca/tlsca.transporter.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/peers/peer1.transporter.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/ca/ca.transporter.supplychain.com-cert.pem

    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/transporter.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/transporter.supplychain.com/users/User1@transporter.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca.transporter.supplychain.com -M ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/users/User1@transporter.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/transporter.supplychain.com/users/Admin@transporter.supplychain.com

    echo
    echo "Generate GoodsClientOrg4 Admin MSP"
    echo

    fabric-ca-client enroll -u https://org4admin:adminpw@localhost:10054 --caname ca.transporter.supplychain.com -M ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/users/Admin@transporter.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/transporter/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/transporter.supplychain.com/users/Admin@transporter.supplychain.com/msp/config.yaml
    
}

createCretificateForOrderer() {
  echo
  echo "Enroll CA admin of Orderer"
  echo
  mkdir -p ../organizations/ordererOrganizations/supplychain.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/ordererOrganizations/supplychain.com

  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register the Orderer Admin"
  echo

  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers
  # mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/supplychain.com

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com

  echo
  echo "Generate the Orderer MSP"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp --csr.hosts orderer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/config.yaml

  echo
  echo "Generate the orderer TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls --enrollment.profile tls --csr.hosts orderer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/ca.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/signcerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/keystore/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.key

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com

  echo
  echo "Generate the Orderer2 MSP"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp --csr.hosts orderer2.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/config.yaml

  echo
  echo "Generate the Orderer2 TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls --enrollment.profile tls --csr.hosts orderer2.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/ca.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/signcerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/keystore/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.key

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com

  echo
  echo "Generate the Orderer3 MSP"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp --csr.hosts orderer3.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/config.yaml

  echo
  echo "Generate the Orderer3 TLS certs"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls --enrollment.profile tls --csr.hosts orderer3.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/ca.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/signcerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/keystore/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.key

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
  # ---------------------------------------------------------------------------

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/users
  mkdir -p ../organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com

  echo
  echo "Generate the Admin MSP Orderer"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com/msp/config.yaml

}

createCertForfarmer
createCertForwarehouse
createCertForretailer
createCertFortransporter
createCretificateForOrderer