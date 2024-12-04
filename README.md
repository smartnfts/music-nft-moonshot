# Music NFT Beacon Proxy Project

## Overview
Deployable upgradeable Music NFT contract on Energi blockchain using OpenZeppelin BeaconProxy.

## Prerequisites
- Node.js
- npm
- Hardhat
- Energi blockchain wallet

## Installation
```bash
git clone <repository-url>
cd music-nft-erc721
npm install
```

## Configuration
1. Copy `.env.example` to `.env`
2. Add your private key
3. Copy `scripts/deploy-template.js` to `scripts/deploy.js`
4. Edit lines 23, 24 and 25 in `scripts/deploy.js`

## Deployment

### Testnet
```bash
npx hardhat run scripts/deploy.js --network energiTestnet
```

### Mainnet
```bash
npx hardhat run scripts/deploy.js --network energiMainnet
```

## Features
- Upgradeable NFT contract
- Energi blockchain compatible
- OpenZeppelin security standards

## License
ISC License
