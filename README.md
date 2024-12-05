# Music NFT Beacon Proxy Project

This repository contains the smart contract and scripts for deploying and interacting with Music NFTs on the Energi blockchain. The contract is based on the **ERC721** standard and is designed for minting music-related non-fungible tokens (NFTs).

## Features

- **Minting Fees**: The minting fees are paid by the **minter** (the user who mints the NFT). The mint price is set by the contract owner, and the owner can modify this fee at any time.
- **Royalties**: The **contract owner** does not receive royalties from the minting or resale of NFTs. If the contract is modified to include royalties, this can be done through custom implementations of the ERC721 standard.
- **Base Contract**: The base contract used is OpenZeppelin’s `BeaconProxy`. This allows the contract to be upgradeable while ensuring flexibility in contract functionality and ownership management.
- **Upgradeable NFT contract**
- **Energi blockchain compatible**
- **OpenZeppelin security standards**

## Contract Details

- **Minting Fee**: A minting fee is set by the contract owner, which must be paid by the minter. The current default fee is set to `0.05 NRG`.
- **Royalty Info**: By default, no royalties are collected by the owner during NFT minting or resales. Royalties can be added if desired by extending the ERC721 standard with OpenZeppelin’s `ERC2981` interface for royalties.
- **Upgradeable Contract**: The contract uses OpenZeppelin’s `BeaconProxy` to allow future upgrades of the logic contract without changing the storage of previously minted NFTs.

## How to Compile, Deploy, and Verify the Contract

### Prerequisites

Before getting started, ensure you have the following installed:

- **Node.js** (version 14 or higher)
- **Hardhat** for contract compilation and deployment
- **Metamask** or another Ethereum-compatible wallet
- **Ether** or test tokens for paying gas on the network (Energi Testnet or Mainnet)

### Install Dependencies

Clone the repository and install the required dependencies:

```bash
git clone https://github.com/smartnfts/music-nft-erc721.git music-nft-moonshot
cd music-nft-moonshot
npm install
```

### Compile the Contract
The contract is written in Solidity and can be compiled using Hardhat. To compile the contract:

```bash
npx hardhat compile
```

This will compile the contract and generate the necessary artifacts.

### Deploy the Contract
To deploy the contract, use the following command. Ensure that you’ve updated your `.env` file with the correct RPC URL and your private key.

1. Create a `.env` file in the root of the project directory with the following content:
```env
RPC_URL="https://nodeapi.test.energi.network"  # Energi testnet URL
PRIVATE_KEY="your_private_key"  # Replace with your private key
MUSIC_NFT_ADDRESS="0xab77c088e806D30D7269e06a23C0B007Ee93cD07"  # Replace with Deployed contract address
BASEURI="ipfs://QmeS1BSypLJ3KP3NmpokErySopqqrUos8m6ULAygMCJh79/" # Replace with BASEURI to metadata
```

2. Deploy the contract using Hardhat:
```bash
npx hardhat run scripts/deploy.js --network energiTestnet
```
This will deploy the contract to the Energi Testnet. You can change `energiTestnet` to `energiMainnet` if deploying to the mainnet.

### Verify the Contract
To verify the contract on the Energi Block Explorer run the following command:

```bash
npx hardhat verify --network <network_name> <contract_address> "<arg1>,<arg2>,<arg3>"
```

**Example:**
```bash
npx hardhat verify --network energiTestnet 0xd1985BBd1F0B6D0276C0281F2dBc8255Ed95ae53 "Moonshot by Violetta Zironi Test" "MSVZ" 2500 "0xd66Ee1691Ffe9F7d476Afc5d90C38e41cB44DC3E"
```

### Minting NFTs
To mint an NFT, use the following script:

```bash
npx hardhat run scripts/mint-nft.js --network energiTestnet
```
The script will mint a new NFT for the user and will charge the minting fee.

## Contract Address
Once deployed, your contract will be available at the address specified in the `.env` file (MUSIC_NFT_ADDRESS). Make sure to update this in your `.env` if the address changes after deployment.

## Additional Notes
- **Minting Fee:** The minting fee is set in the contract and can be updated by the contract owner. The fee is required by users who wish to mint NFTs.
- **Upgradeable Contracts:** The contract uses OpenZeppelin's `BeaconProxy`, allowing future upgrades to the logic while maintaining the same storage and NFTs minted.
- **Ether Payment:** When users mint NFTs, they will need to pay the minting fee in NRG.

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE.txt) file for details.
