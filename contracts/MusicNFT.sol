// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MusicNFT is ERC721URIStorage, Ownable {
    uint256 public mintPrice = 0.05 ether; // Example price
    uint256 private _tokenIds;
    uint256 public maxSupply;
    string private _baseURIextended;

    constructor(string memory name, string memory symbol, uint256 _maxSupply, address initialOwner) 
        ERC721(name, symbol) 
        Ownable(initialOwner) 
    {
        maxSupply = _maxSupply;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseURIextended = baseURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIextended;
    }

    function setMintPrice(uint256 _mintPrice) public onlyOwner {
        mintPrice = _mintPrice;
    }

    function mintNFT(address recipient, string memory tokenURI) public payable returns (uint256) {
        require(_tokenIds < maxSupply, "Max supply reached");
        if (msg.sender != owner()) {
            require(msg.value >= mintPrice, "Insufficient funds");
        }

        _tokenIds += 1;
        uint256 newItemId = _tokenIds;
        _safeMint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
