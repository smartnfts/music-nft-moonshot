require("dotenv").config();
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  const MusicNFT = await ethers.getContractFactory("MusicNFT");
  const musicNFT = await MusicNFT.deploy(
    "Moonshot by Violetta Zironi Test",  // Name
    "MSVZ",                              // Symbol
    2500,                                // Max Supply
    deployer.address                     // Initial Owner
  );

  await musicNFT.deployed();
  console.log("MusicNFT deployed to:", musicNFT.address);

  const baseURI = process.env.BASEURI;
  const tx = await musicNFT.setBaseURI(baseURI);
  await tx.wait();
  console.log("Base URI set to:", baseURI);

  const mintPrice = ethers.utils.parseEther("0.05");
  const tx2 = await musicNFT.setMintPrice(mintPrice);
  await tx2.wait();
  console.log("Mint price set to:", ethers.utils.formatEther(mintPrice), "NRG");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
