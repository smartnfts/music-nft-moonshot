require("dotenv").config();
const { ethers } = require("hardhat");

async function main() {
  const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

  const MusicNFTAddress = process.env.MUSIC_NFT_ADDRESS;

  // Create contract instance
  const MusicNFT = new ethers.Contract(
    MusicNFTAddress,
    [
      "function mintNFT(address recipient, string memory tokenURI) public payable returns (uint256)",
      "function owner() public view returns (address)",
      "function ownerOf(uint256 tokenId) public view returns (address)",
      "function maxSupply() public view returns (uint256)"
    ],
    wallet
  );

  // Get max supply to prevent infinite loop
  const maxSupply = (await MusicNFT.maxSupply()).toNumber();

  // Find the next available token ID
  let tokenId = 1;
  while (tokenId <= maxSupply) {
    try {
      // Try to get the owner of the token
      await MusicNFT.ownerOf(tokenId);
      tokenId++;
    } catch (error) {
      // If ownerOf throws an error, this token ID is not minted yet
      break;
    }
  }

  const tokenURI = `${tokenId}`;

  const mintPrice = ethers.utils.parseEther("0.05"); // Should match the contract's mint price

  const contractOwner = await MusicNFT.owner();

  // Check if the wallet is the owner to determine if mint price should be paid
  const isOwner = wallet.address.toLowerCase() === contractOwner.toLowerCase();
  const value = isOwner ? 0 : mintPrice;

  console.log(`Minting NFT for tokenId: ${tokenId} to ${wallet.address}`);
  
  const mintTx = await MusicNFT.mintNFT(wallet.address, tokenURI, { value });
  await mintTx.wait();

  console.log(`NFT minted successfully! TokenID: ${tokenId} URI: ${process.env.BASEURI}${tokenURI}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
