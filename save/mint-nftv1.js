require('dotenv').config();
const ethers = require('ethers');

// ABI for the MusicNFT contract (only including the mintNFT function)
const abi = [
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "recipient",
        "type": "address"
      },
      {
        "internalType": "string",
        "name": "tokenURI",
        "type": "string"
      }
    ],
    "name": "mintNFT",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  }
];

async function mintNFT() {
  const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
  const signer = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
  const contract = new ethers.Contract(process.env.MUSIC_NFT_ADDRESS, abi, signer);

  try {
    const tx = await contract.mintNFT(signer.address, "/14");
    console.log("Transaction sent:", tx.hash);
    const receipt = await tx.wait();
    console.log("Transaction confirmed in block:", receipt.blockNumber);
    console.log("NFT minted successfully!");
  } catch (error) {
    console.error("Error minting NFT:", error);
  }
}

mintNFT();
