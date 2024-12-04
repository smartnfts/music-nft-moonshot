require("dotenv").config();
const { ethers } = require("ethers");

async function getDeployedBytecode() {
  const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
  const contractAddress = process.env.MUSIC_NFT_ADDRESS;

  const code = await provider.getCode(contractAddress);
  console.log("Deployed Bytecode:", code);
}

getDeployedBytecode();
