#!/bin/bash

# Load .env
. .env

# Set the NFT Contract Address
export NFT_CONTRACT_ADDRESS=${MUSIC_NFT_ADDRESS}

# Set Mint Account Private Key
export PRIVATE_KEY="add_your_private_key_here"

# Total number of NFTs to mint minus any NFTs you have already minted
TOTALMINT=1

################################
# DO NOT CHANGE ANYTHING BELOW #
################################
#
# Set Counter
COUNT=1

# Check private key is set
if [ "${PRIVATE_KEY}" == "add_your_private_key_here" ]
then
    echo -e "\033[31mPut your private key in PRIVATE_KEY variable before minting!\033[0m"
    exit 0
fi

# Loop through and mint the NFTs
while [ ${COUNT} -le ${TOTALMINT} ]
do
    echo "Minting ${COUNT} of ${TOTALMINT}"
    npx hardhat run scripts/mint-nft.js --network energiTestnet
	((COUNT++))
done
