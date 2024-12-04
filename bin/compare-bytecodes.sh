#!/bin/bash
#
# Script to compare the deployed bytecode to the local compiled bytecode
#

. .env
echo "Verifying contract: ${MUSIC_NFT_ADDRESS}"
echo "RPC URL: ${RPC_URL}"
echo

# Chain bytecode
echo "Getting bytecode from chain..."
CHAINBYTECODE=$(curl -s -X POST -H "Content-Type: application/json" --data "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getCode\",\"params\":[\"${MUSIC_NFT_ADDRESS}\",\"latest\"],\"id\":1}" ${RPC_URL} | jq -r '.result')
#echo "Chain Bytecode: ${CHAINBYTECODE}"

# Get the local bytecode using the script
echo "Getting local bytecode..."
LOCALBYTECODE=$(node scripts/get-bytecode.js | awk '{print $3}')
#echo "Local Bytecode: ${LOCALBYTECODE}"

# String comparison
echo "Comparing bytecodes..."
if [[ "${CHAINBYTECODE}" == "${LOCALBYTECODE}" ]]
then
    echo -e "\033[32mBytecodes match\033[0m"
else
    echo -e "\033[31mBytecode mismatch\033[0m"
fi
